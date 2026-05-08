# Operations Guide

This guide covers the everyday workflow for managing the Cloud Run Terraform environment.

## Deploy

Run commands from the environment folder you want to manage:

```sh
cd environments/dev
terraform init
terraform plan
terraform apply
```

Always review the plan before applying changes.

## Update The Container Image

Change the `image` value in `terraform.tfvars`, then run:

```sh
terraform plan
terraform apply
```

For repeatable releases, use immutable image tags such as a Git SHA instead of `latest`.

## Add A Secret

1. Create the secret in Google Secret Manager.
2. Grant the Cloud Run runtime service account access to read the secret.
3. Add the secret name to `secret_names` in `terraform.tfvars`.
4. Run `terraform plan` and `terraform apply`.

## Private Services

Set this value in `terraform.tfvars`:

```hcl
allow_public_access = false
```

When public access is disabled, callers need an identity with `roles/run.invoker`.

## Destroy

Run this only when you intentionally want to remove the environment:

```sh
terraform destroy
```
