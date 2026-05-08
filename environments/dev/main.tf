module "cloud_run_service" {
  source = "../../modules/cloud-run-service"

  project_id            = var.project_id
  region                = var.region
  service_name          = var.service_name
  image                 = var.image
  env_vars              = var.env_vars
  secret_names          = var.secret_names
  allow_public_access   = var.allow_public_access
  service_account_email = var.service_account_email
  container_port        = var.container_port
  cpu_limit             = var.cpu_limit
  memory_limit          = var.memory_limit
  min_instance_count    = var.min_instance_count
  max_instance_count    = var.max_instance_count
  ingress               = var.ingress
  labels                = var.labels
}
