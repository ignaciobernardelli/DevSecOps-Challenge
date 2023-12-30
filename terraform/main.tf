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

# Variables y outputs (variables.tf y outputs.tf) - Define tus variables y outputs aquí

# Recursos específicos
/* module "pubsub" {
  source = "./modules/pubsub"  # Estructura de módulo para crear recursos de Cloud Pub/Sub
}

module "functions" {
  source = "./modules/functions"  # Estructura de módulo para crear funciones de Cloud Functions
}

module "bigquery" {
  source = "./modules/bigquery"  # Estructura de módulo para crear recursos de BigQuery
}

module "cloudrun" {
  source = "./modules/cloudrun"  # Estructura de módulo para crear recursos de CloudRun
} */