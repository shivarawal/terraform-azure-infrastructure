# Terraform Azure Infrastructure

Production-style Azure infrastructure built with Terraform using 
a modular approach — provisioning networking, virtual machines, 
and remote backend configuration entirely through code.



## Why I Built This

Most Terraform tutorials show a single `main.tf` file with 
everything hardcoded. I wanted to understand how real 
infrastructure teams structure Terraform at scale — with 
reusable modules, separated concerns, and proper state 
management.

This project is the result of that learning.

## What It Provisions

- **Virtual Network** — custom VNet with subnets configured 
  through a reusable network module
- **Virtual Machines** — Azure VMs with configurable sizing, 
  OS image, and admin credentials via variables
- **Network Interfaces** — NICs attached to subnet with 
  public IP association
- **Remote Backend** — Terraform state stored in Azure 
  Blob Storage for team-safe state management
- **Outputs** — VM public IPs and resource IDs exposed 
  as Terraform outputs

---

## Project Structure

```
terraform-azure-infrastructure/
├── main.tf              # Root module — orchestrates all resources
├── variables.tf         # Input variable definitions
├── outputs.tf           # Output values (IPs, IDs)
├── locals.tf            # Local value computations
├── data.tf              # Data sources
├── .terraform.lock.hcl  # Provider version lock file
└── modules/
    └── network/         # Reusable networking module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf


## Key Concepts Practiced

| Concept | Implementation |
|---------|---------------|
| Modules | Network provisioning extracted into reusable module |
| Variables | All configurable values defined in `variables.tf` |
| Locals | Computed values and naming conventions in `locals.tf` |
| Outputs | Resource IDs and IPs exposed for external use |
| Remote state | Azure Blob Storage backend for state locking |
| Data sources | Referencing existing Azure resources via `data.tf` |



## Tech Stack

- **IaC Tool** — Terraform
- **Cloud Provider** — Microsoft Azure
- **Language** — HCL (HashiCorp Configuration Language)
- **State Backend** — Azure Blob Storage


## How to Use

**Prerequisites:**
- Terraform installed (`>= 1.0`)
- Azure CLI installed and authenticated (`az login`)
- An active Azure subscription

Deploy:

# Clone the repo
git clone https://github.com/shivarawal/terraform-azure-infrastructure
cd terraform-azure-infrastructure

# Initialise providers and backend
terraform init

# Preview what will be created
terraform plan

# Apply the infrastructure
terraform apply


Destroy:
terraform destroy


## What I Learned

- How to structure Terraform projects with modules instead 
  of a single flat file
- Why remote state matters and how to configure Azure 
  Blob Storage as a backend
- How `locals.tf` keeps naming consistent across resources
- How outputs make resources reusable across configurations
- Real Azure resource dependencies and how Terraform 
  resolves them automatically


## Related Projects

- [K8s Cluster on VMware](https://github.com/shivarawal/k8s-cluster-on-vmware) — Production-style Kubernetes cluster built with kubeadm
- [K8s Monitoring Stack](https://github.com/shivarawal/k8s-monitoring-prometheus-grafana) — Prometheus + Grafana without Helm
- [K8s Alerting Stack](https://github.com/shivarawal/k8s-alerting-prometheus-alertmanager) — Alertmanager + Slack notifications



## Connect

- [LinkedIn](https://www.linkedin.com/in/shivarawal)
- [GitHub](https://github.com/shivarawal)
