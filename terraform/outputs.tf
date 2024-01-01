output "function_url" {
  value = google_cloudfunctions_function.kafka_producer.https_trigger_url
}