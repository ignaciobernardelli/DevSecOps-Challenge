import pandas as pd
from google.cloud import bigquery
import json

def read_data(file_path):
    # Leer datos desde un archivo CSV u otra fuente
    return pd.read_csv(file_path)

def write_to_bigquery(data, table_id, project_id):
    # Configurar cliente de BigQuery
    client = bigquery.Client(project=project_id)

    # Escribir datos en BigQuery
    job_config = bigquery.LoadJobConfig(
        schema=[
            bigquery.SchemaField("column1", "STRING"),
            bigquery.SchemaField("column2", "INTEGER"),
            # Agregar más campos según tu esquema
        ],
        write_disposition="WRITE_TRUNCATE",
    )

    job = client.load_table_from_dataframe(data, table_id, job_config=job_config)
    job.result()  # Esperar a que la carga se complete

def main():
    # Configuración
    with open('config.json') as f:
        config = json.load(f)

    # Leer datos
    input_data = read_data('data/input_data.csv')

    # Especificar el ID de la tabla en BigQuery
    table_id = config['bigquery']['table_id']

    # Especificar el ID del proyecto de GCP
    project_id = config['bigquery']['project_id']

    # Escribir datos en BigQuery
    write_to_bigquery(input_data, table_id, project_id)

if __name__ == "__main__":
    main()
