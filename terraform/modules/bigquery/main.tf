resource "google_bigquery_dataset" "my_dataset" {
  dataset_id = "my_dataset"
  project    = var.project_id
}

resource "google_bigquery_table" "my_table" {
  dataset_id = google_bigquery_dataset.my_dataset.dataset_id
  table_id   = "my_table"

  schema = <<-JSON
    [
      {"name": "column1", "type": "STRING"},
      {"name": "column2", "type": "STRING"},
      # ... otros campos según sea necesario
    ]
  JSON
}
