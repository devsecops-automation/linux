# AWS EC2 Instance Provisioning with Terraform

This project automates the provisioning of Ubuntu and Amazon Linux EC2 instances on AWS using Terraform.

## Prerequisites

- Terraform >= 1.3.0
- AWS CLI configured with appropriate credentials
- SSH client

## Features

- Provisions both Ubuntu and Amazon Linux EC2 instances
- Automatically generates and manages SSH keys
- Configures security groups for SSH access
- Sets up custom hostnames on instances
- Uses dynamic instance naming with random suffixes

## Configuration

### Variables (`terraform.tfvars`)

```hcl
instance_type = "t2.medium"  # Must be t2.small or higher
region        = "us-east-1"  # AWS region
name          = "learning"   # Base name for resources
```

## Module Structure

```
.
├── cleanup.sh          # Cleanup script for destroying resources
├── data.tf            # AWS AMI data sources
├── locals.tf          # Local variable definitions
├── main.tf            # Main Terraform configuration
├── outputs.tf         # Output definitions
├── provider.tf        # AWS provider configuration
├── scripts/
│   ├── amazon-linux.sh  # Amazon Linux instance setup
│   └── ubuntu.sh        # Ubuntu instance setup
├── terraform.tfvars   # Variable values
└── variables.tf       # Variable definitions
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. SSH into instances using the output commands:
```bash
# For Ubuntu instance
$(terraform output -raw ubuntu-ssh)

# For Amazon Linux instance
$(terraform output -raw amazon-linux-ssh)
```

5. To destroy all resources:
```bash
./cleanup.sh
```

## Security Groups

- Inbound: SSH (port 22) from any source
- Outbound: All traffic allowed

## Instance Types

The configuration enforces t2.small or higher instance types for better performance.

## Cleanup

The included `cleanup.sh` script will:
- Destroy all AWS resources
- Remove local Terraform files
- Clean up SSH key files
- Remove state files and JSON configurations