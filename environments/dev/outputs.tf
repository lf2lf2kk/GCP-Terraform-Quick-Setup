output "service_name" {
  description = "Cloud Run service name."
  value       = module.cloud_run_service.service_name
}

output "service_url" {
  description = "Cloud Run service URL."
  value       = module.cloud_run_service.service_url
}
