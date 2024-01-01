provider "google" {
  credentials = file("cred.json")
  project     = var.project_id
  region      = var.region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.80.0"  # Asegúrate de utilizar la última versión disponible
    }
  }
}

resource "google_service_account" "cloud-functions-sa" {
  account_id   = "cloud-functions-sa"
  display_name = "Service Account para Cloud Functions"
  project      = var.project_id
}

resource "google_cloudfunctions_function" "kafka_producer" {
  name        = "kafka_producer"
  runtime     = "python310"
  source_archive_bucket = google_storage_bucket.cloud-function-flight-data-bucket.name
  source_archive_object = "cloud_functions.zip"
  entry_point = "kafka_producer"
  available_memory_mb   = 256
  #timeout_sec            = 60

  trigger_http = true
  #allow_unauthenticated = true
}

resource "google_storage_bucket" "cloud-function-flight-data-bucket" {
  name = "cloud-function-flight-data-bucket"
  location = var.region
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "cloud_functions.zip"
  bucket = google_storage_bucket.cloud-function-flight-data-bucket.name
  source = "./modules/functions/cloud_functions.zip"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = var.dataset_id
  project                    = var.project_id
  location                   = "US"  # Cambia a tu región preferida
  default_table_expiration_ms = 3600000  # 1 hora (ajusta según tus necesidades)
}

module "bigquery" {
  source     = "./modules/bigquery"
  project_id = var.project_id
  dataset_id = "ingesta-test"  
}


#module "cloudrun" {
#  source = "./modules/cloudrun"  # Estructura de módulo para crear recursos de CloudRun
#}