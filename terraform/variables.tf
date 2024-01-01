variable "project_id" {
  description = "ID del proyecto GCP"
  type = string
  default = "devsecops-challenge"
}

variable "region" {
  description = "Región de GCP"
  type = string
  default = "us-east1" 
}

variable "dataset_id" {
  description = "BigQuery Dataset ID"
  default = "ingesta-test"
}