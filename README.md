# koltin_challenge

Bien pues esta es la solucion que propongo al challenge!
Muchas gracias por la oportunidad de participar en el proceso de selección.

### Video
[![Ver video](media/demo_thumbnail.png)](media/intro.mp4)
<video src="media/intro.mp4" controls width="600"></video>





### Estructura del proyecto
El proyecto está estructurado en 3 capas: bronze, silver y gold.
- **Bronze**: Carga de datos en bruto desde los archivos CSV proporcionados.
- **Silver**: Limpieza y transformación de los datos para asegurar su calidad e integridad
- **Gold**: Modelos analíticos y de negocio listos para su consumo.

### Tecnologías utilizadas
- **dbt**: Para la transformación y modelado de datos.
- **Snowflake**: Como data warehouse para almacenar y gestionar los datos.
- **Dagster**: Para la orquestación y gestión de los pipelines de datos.
- **AWS S3**: Para el almacenamiento de los archivos CSV originales.


### Flujo de datos
```mermaid
flowchart LR
    subgraph Raw["Ingesta (S3 / Datos crudos)"]
        A1["Bucket S3 (CSV públicos)"]
        A1 --> A3["Lectura desde @KOLTIN_S3 y @KOLTIN_S3_SEMICOLON"]
    end

    subgraph Bronze["Capa bronze (ingesta en bruto)"]
        B1["bronze_customer_certificates"]
        B2["bronze_customer_claims"]
        B3["bronze_customer_certificate_terms"]
        B4["bronze_medical_pathologies"]
        B5["bronze_medical_consultations"]
        A3 --> B1
        A3 --> B2
        A3 --> B3
        A3 --> B4
        A3 --> B5
    end

    subgraph Silver["Capa silver (normalización y limpieza)"]
        S1["silver_customer_certificates"]
        S2["silver_customer_claims"]
        S3["silver_customer_certificate_terms"]
        S4["silver_medical_pathologies"]
        S5["silver_medical_consultations"]
        B1 --> S1
        B2 --> S2
        B3 --> S3
        B4 --> S4
        B5 --> S5
    end

    subgraph Gold["Capa gold (modelos analíticos finales)"]
        G1["gold_clinical_interactions"]
        G2["gold_customer_statistics"]
        G3["gold_medical_consultation_diagnoses"]
        S1 --> G1
        S2 --> G1
        S5 --> G1
        S1 --> G2
        S2 --> G2
        S5 --> G2
        S1 --> G3
        S5 --> G3
    end

    subgraph Consumo["Consumo / Analítica"]
        C1["Dashboards BI"]
        C2["Modelos predictivos (ML)"]
        C3["APIs o reportes automáticos"]
        G1 --> C1
        G2 --> C2
        G3 --> C3
    end

    Raw --> Bronze --> Silver --> Gold --> Consumo
```





### Instrucciones para ejecutar el proyecto
1. Clona el repositorio:
   ```bash
   git clone https://github.com/ingoscarn/koltin-challenge.git
    cd koltin-challenge
    ``` 

2. Instala las dependencias de dbt:
    ```bash
    uv add dbt-core dbt-snowflake
    ``` 

3. Instala dagster y las dependencias necesarias:
    ```bash
    uv add dagster dagster-dbt
    ``` 

4. Pega el archivo profile.yml en la carpeta ~/.dbt/ para configurar la conexión a Snowflake en
  ```bash
  dbt/koltin/profiles.yml
```

5. Ejecuta el ui de dagster:
    ```bash
    dagster dev
    ```


### Visualización del lineage con Dagster

![alt text](media/dagter_lineage.png "Dagster Lineage")


![alt text](media/snowflake.png)