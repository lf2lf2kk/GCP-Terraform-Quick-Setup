# GCP Terraform Quick Setup

Production-minded Terraform starter for deploying a containerized application to Google Cloud Run.

This project is intentionally small, but it is organized like a real infrastructure repository: reusable modules live under `modules/`, environment-specific configuration lives under `environments/`, and operational notes live under `docs/`. You can use it as a clean starting point for Cloud Run services that need Secret Manager-backed environment variables and optional public access.

## Table Of Contents

- [What This Deploys](#what-this-deploys)
- [Repository Layout](#repository-layout)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Adding Another Environment](#adding-another-environment)
- [Operations](#operations)
- [Security Notes](#security-notes)
- [Next Steps For Production](#next-steps-for-production)

## What This Deploys

- A Google Cloud Run v2 service.
- Runtime environment variables referenced from Google Secret Manager without storing secret values in Terraform state.
- An optional public invoker IAM binding.
- Environment-specific provider configuration.
- Typed inputs and outputs so the configuration can be reused safely.

## Repository Layout

```text
.
|-- docs/
|   `-- operations.md
|-- environments/
|   `-- dev/
|       |-- main.tf
|       |-- outputs.tf
|       |-- terraform.tfvars.example
|       |-- variables.tf
|       `-- versions.tf
|-- modules/
|   `-- cloud-run-service/
|       |-- main.tf
|       |-- outputs.tf
|       `-- variables.tf
|-- .gitignore
`-- README.md
```

## Prerequisites

Before you run Terraform, make sure you have:

- A Google Cloud project with billing enabled.
- Terraform `>= 1.5`.
- Google Cloud CLI installed and authenticated.
- Permission to manage Cloud Run, IAM, and Secret Manager resources.
- A container image published to Artifact Registry or Container Registry.
- Secret Manager secrets created if you plan to inject secrets as environment variables.

Authenticate locally with:

```sh
gcloud auth application-default login
gcloud config set project YOUR_PROJECT_ID
```

## Quick Start

1. Copy the example variables file:

   ```sh
   cd environments/dev
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your project, region, service name, image, and secret names.

3. Initialize Terraform:

   ```sh
   terraform init
   ```

4. Review the plan:

   ```sh
   terraform plan
   ```

5. Apply the deployment:

   ```sh
   terraform apply
   ```

After the apply finishes, Terraform prints the Cloud Run service URL.

## Configuration

The main configuration lives in `environments/dev/terraform.tfvars`.

```hcl
project_id   = "my-gcp-project"
region       = "asia-east1"
service_name = "my-service"
image        = "asia-east1-docker.pkg.dev/my-gcp-project/apps/my-service:latest"

secret_names = [
  "DATABASE_URL",
  "API_KEY"
]

env_vars = {
  NODE_ENV = "production"
}

allow_public_access = true
```

Secrets are referenced from Secret Manager and exposed to the container as environment variables with the same names. For example, a secret named `DATABASE_URL` becomes an environment variable named `DATABASE_URL`. The secret values are not copied into Terraform state.

## Adding Another Environment

To add `staging` or `prod`, copy `environments/dev`:

```sh
cp -r environments/dev environments/prod
```

Then update the new environment's `terraform.tfvars`. In a mature setup, each environment should use its own remote backend, service account, and review process.

## Operations

Common commands:

```sh
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
terraform destroy
```

Use `terraform destroy` carefully. It removes the infrastructure managed by the active environment.

See `docs/operations.md` for practical deployment and maintenance notes.

## Security Notes

- Do not commit `terraform.tfvars`, service account keys, state files, or generated plan files.
- Prefer workload identity or application-default credentials over long-lived JSON keys.
- Keep `allow_public_access = false` for private services.
- Store sensitive runtime values in Secret Manager, not in Terraform files.
- Use remote state with locking before collaborating with a team.

## Next Steps For Production

- Configure a remote Terraform backend such as Google Cloud Storage with state locking controls.
- Add CI checks for `terraform fmt`, `terraform validate`, and policy scanning.
- Split environments into separate projects or folders if your organization requires strict isolation.
- Add custom domain mapping and HTTPS routing if the service is public.
- Add monitoring, alerts, and deployment promotion workflows.
