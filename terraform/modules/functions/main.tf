resource "google_cloudfunctions_function" "ingest_function" {
  name        = "ingest-function"
  runtime     = "python310"
  source_archive_bucket = "<bucket-gcs-donde-almacenar-el-zip>"
  entry_point = "ingest_data_pubsub"
  trigger_http = true
}
