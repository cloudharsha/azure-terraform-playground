# azure-terraform-playground
Terraform starter repo for Azure infrastructure, centered on reusable modules and ready-to-run templates for AKS and other core platform services.

## What is included

This repo now has two layers:

- `modules/` contains reusable Terraform modules for common Azure building blocks.
- `templates/` contains starter root modules that show how to compose those modules for real deployments.

The main platform template is `templates/aks-platform`, which provisions:

- Resource Group
- Virtual Network and AKS subnet
- Log Analytics Workspace
- Azure Container Registry
- Key Vault
- Storage Account
- Azure Kubernetes Service
- `AcrPull` role assignment so AKS can pull images from ACR

Additional standalone templates are included for:

- `templates/virtual-network`
- `templates/container-registry`
- `templates/key-vault`
- `templates/log-analytics`
- `templates/storage-account`

## Repository structure

```text
.
├── modules
│   ├── aks
│   ├── container-registry
│   ├── key-vault
│   ├── log-analytics
│   ├── resource-group
│   ├── storage-account
│   └── virtual-network
└── templates
    ├── aks-platform
    ├── container-registry
    ├── key-vault
    ├── log-analytics
    ├── storage-account
    └── virtual-network
```

## Modules

### `modules/resource-group`
Simple Azure Resource Group module used by all templates.

### `modules/virtual-network`
Creates a VNet and a map of subnets so templates can define network layouts without rewriting subnet resources.

### `modules/log-analytics`
Creates a Log Analytics Workspace for AKS monitoring and general platform observability.

### `modules/container-registry`
Creates an Azure Container Registry with configurable SKU and public network access.

### `modules/key-vault`
Creates a Key Vault with RBAC enabled by default.

### `modules/storage-account`
Creates a Storage Account and optional blob containers.

### `modules/aks`
Creates an AKS cluster with:

- system-assigned managed identity
- Azure CNI-style network settings
- optional Azure RBAC admin groups
- optional Log Analytics integration
- autoscaling-ready default node pool
- OIDC issuer and workload identity enabled by default

## Templates

### `templates/aks-platform`
Best starting point if you want a complete AKS landing zone template in one place.

Use this template when you want a starter platform that already wires together:

- networking
- cluster monitoring
- image registry
- secrets store
- artifact storage

### `templates/virtual-network`
Minimal starter for shared network foundations.

### `templates/container-registry`
Minimal starter for ACR-only deployments.

### `templates/key-vault`
Minimal starter for Key Vault-only deployments.

### `templates/log-analytics`
Minimal starter for workspace-only deployments.

### `templates/storage-account`
Minimal starter for storage account and container creation.

## Getting started

Pick a template directory, then run Terraform from inside it.

Example using the AKS platform template:

```bash
cd templates/aks-platform
terraform init
terraform plan -var-file="terraform.tfvars.example"
```

If you want to customize values first, use the included `terraform.tfvars.example` in that template as your starting point.

## Naming notes

- Keep `prefix` short and lowercase.
- Storage Account and ACR names are derived from `prefix`, so shorter values are safer.
- The AKS platform template validates `prefix` to fit the derived resource naming scheme.

## Next ideas

This scaffold is intentionally a clean starter. Common follow-ups you can add later:

- remote state backend configuration
- environment folders such as `dev`, `stage`, and `prod`
- private endpoints and network rules
- AKS add-ons such as ingress, cert-manager, or Azure Policy
- CI/CD pipelines for `terraform fmt`, `validate`, and `plan`
