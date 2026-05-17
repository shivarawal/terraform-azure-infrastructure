# Terraform Azure Infrastructure Project

This project provisions Azure infrastructure using Terraform with a modular structure.

## Features

- Azure Resource Group
- Virtual Network
- Subnet
- Network Security Groups (NSG)
- Public IPs
- Network Interface
- Linux Virtual Machine
- Terraform Modules
- Variables and Outputs



# Project Structure

terraform/
│
├── modules/
│   └── network/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── main.tf
├── variables.tf
├── outputs.tf
├── locals.tf
├── data.tf
├── .gitignore
└── terraform.tfvars