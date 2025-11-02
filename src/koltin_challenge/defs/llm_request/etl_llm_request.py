# koltin_challenge/assets/etl_llm_request.py
import os
import re
import sys
import traceback
import pandas as pd
import requests
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from dagster_pipes import open_dagster_pipes

tabla_origen = "gold_medical_consultation_diagnoses"
tabla_destino = "gold_medical_diagnoses_recovery_estimates_llm"

def main():
    with open_dagster_pipes() as pipes:
        try:
            pipes.log.info("INICIANDO ETL LLM (OpenRouter)")

            # Validar variables de entorno
            required = [
                "SNOWFLAKE_USER",
                "SNOWFLAKE_PASSWORD",
                "SNOWFLAKE_ACCOUNT",
                "SNOWFLAKE_DATABASE",
                "SNOWFLAKE_SCHEMA",
                "SNOWFLAKE_WAREHOUSE",
                "OPENROUTER_API_KEY",
            ]
            missing = [v for v in required if not os.getenv(v)]
            if missing:
                raise ValueError(f"Faltan variables de entorno: {missing}")
            pipes.log.info("Variables de entorno OK")

            # Conexión a Snowflake
            connection_url = URL.create(
                "snowflake",
                username=os.environ["SNOWFLAKE_USER"],
                password=os.environ["SNOWFLAKE_PASSWORD"],
                host=os.environ["SNOWFLAKE_ACCOUNT"],
                database=os.environ["SNOWFLAKE_DATABASE"],
                query={
                    "schema": os.environ["SNOWFLAKE_SCHEMA"],
                    "warehouse": os.environ["SNOWFLAKE_WAREHOUSE"],
                },
            )
            engine = create_engine(connection_url)

            # Query incluyendo CUSTOMER_ID y CUSTOMER_NAME
            table = f"{os.environ['SNOWFLAKE_DATABASE']}.{os.environ['SNOWFLAKE_SCHEMA']}.{tabla_origen}"
            query = f"""
                SELECT CUSTOMER_ID, CUSTOMER_NAME, CURRENT_CUSTOMER_AGE, CONSULTATION_DIAGNOSIS_NAME
                FROM {table}
                WHERE CURRENT_CUSTOMER_AGE IS NOT NULL
                  AND CONSULTATION_DIAGNOSIS_NAME IS NOT NULL
                LIMIT 10
            """
            pipes.log.info(f"Query: {query.strip()}")
            df = pd.read_sql(query, engine)
            pipes.log.info(f"{len(df)} filas cargadas")

            # Procesamiento con LLM
            resultados = []
            for _, row in df.iterrows():
                edad = row["current_customer_age"] 
                diag = row["consultation_diagnosis_name"]

                prompt = (
                    f"Paciente de {edad} años con diagnóstico médico: '{diag}'. "
                    "Basándote únicamente en la información del diagnóstico y la edad, "
                    "estima el tiempo promedio de recuperación o tratamiento hasta alcanzar una mejora significativa. "
                    "Responde únicamente con un número entero que represente la cantidad de meses estimados de recuperación, sin texto adicional ni símbolos."
                )

                headers = {
                    "Authorization": f"Bearer {os.environ['OPENROUTER_API_KEY']}",
                    "Content-Type": "application/json",
                }
                body = {
                    "model": "deepseek/deepseek-chat-v3.1:free",
                    "messages": [{"role": "user", "content": prompt}],
                }

                try:
                    resp = requests.post("https://openrouter.ai/api/v1/chat/completions", headers=headers, json=body)
                    resp.raise_for_status()
                    respuesta = resp.json()["choices"][0]["message"]["content"]
                except Exception as e:
                    pipes.log.error(f"Error en llamada a OpenRouter: {e}")
                    respuesta = ""

                match = re.search(r"\d+", respuesta)
                estimado = int(match.group()) if match else None

                resultados.append(estimado)
                pipes.log.info(f"→ {estimado} meses (respuesta: {respuesta.strip()})")

            # Agregar columna con resultados al DataFrame original
            df["RECOVERY_ESTIMATED_MONTHS"] = resultados
            pipes.log.info("Columna RECOVERY_ESTIMATED_MONTHS agregada al DataFrame.")

            # Guardar en nueva tabla en Snowflake
            df.to_sql(tabla_destino, engine, index=False, if_exists="replace")
            pipes.log.info(f"Tabla '{tabla_destino}' creada con {len(df)} filas.")

            # Reportar materialización a Dagster
            pipes.report_asset_materialization(
                metadata={
                    "rows": len(df),
                    "source_table": tabla_origen,
                    "destination_table": tabla_destino,
                }
            )

            pipes.log.info("ETL completado correctamente.")

        except Exception as e:
            print("Error interno en etl_llm_request.py:", file=sys.stderr)
            traceback.print_exc()
            pipes.log.error(f"Fallo interno: {e}")
            raise

if __name__ == "__main__":
    main()
