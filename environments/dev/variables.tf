variable "project_id" {
  description = "Google Cloud project ID where resources are deployed."
  type        = string
}

variable "region" {
  description = "Google Cloud region for the environment."
  type        = string
  default     = "asia-east1"
}

variable "service_name" {
  description = "Cloud Run service name."
  type        = string
}

variable "image" {
  description = "Container image URI to deploy."
  type        = string
}

variable "secret_names" {
  description = "Secret Manager secret names to expose as environment variables."
  type        = list(string)
  default     = []
}

variable "env_vars" {
  description = "Plain-text environment variables for the container."
  type        = map(string)
  default     = {}
}

variable "allow_public_access" {
  description = "Whether the Cloud Run service should be publicly invokable."
  type        = bool
  default     = false
}

variable "service_account_email" {
  description = "Runtime service account email for Cloud Run. Leave null to use the project default."
  type        = string
  default     = null
}

variable "container_port" {
  description = "Container port exposed by the application."
  type        = number
  default     = 8080
}

variable "cpu_limit" {
  description = "CPU limit for the Cloud Run container."
  type        = string
  default     = "1"
}

variable "memory_limit" {
  description = "Memory limit for the Cloud Run container."
  type        = string
  default     = "512Mi"
}

variable "min_instance_count" {
  description = "Minimum number of Cloud Run instances."
  type        = number
  default     = 0
}

variable "max_instance_count" {
  description = "Maximum number of Cloud Run instances."
  type        = number
  default     = 10
}

variable "ingress" {
  description = "Cloud Run ingress setting."
  type        = string
  default     = "INGRESS_TRAFFIC_ALL"
}

variable "labels" {
  description = "Labels to apply to the Cloud Run service."
  type        = map(string)
  default     = {}
}
