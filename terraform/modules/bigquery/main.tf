resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_id
  project                    = var.project_id
  location                   = "US"  # Cambia a tu región preferida
  default_table_expiration_ms = 3600000  # 1 hora (ajusta según tus necesidades)
}