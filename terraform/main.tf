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

# Variables y outputs (variables.tf y outputs.tf) - Define tus variables y outputs aquí

# Recursos específicos
module "pubsub" {
  source = "./pubsub"  # Estructura de módulo para crear recursos de Cloud Pub/Sub
}

module "functions" {
  source = "./functions"  # Estructura de módulo para crear funciones de Cloud Functions
}

module "bigquery" {
  source = "./bigquery"  # Estructura de módulo para crear recursos de BigQuery
}
