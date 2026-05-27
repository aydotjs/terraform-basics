Terraform talks directly to AWS APIs. Unlike CDK, it does not go through CloudFormation. It tracks everything it creates in a local state file called `terraform.tfstate`.

---

## Core concepts

**Provider**
Tells Terraform which cloud to talk to and which region to deploy in.
```hcl
provider "aws" {
  region = "eu-north-1"
}
```

**Resource**
The actual thing you want to create in AWS.
```hcl
resource "aws_instance" "web" {
  ami           = "ami-089146c5626baa6bf"
  instance_type = "t3.micro"
}
```

**State file**
`terraform.tfstate` is Terraform's brain. It remembers everything it has created in AWS. Never delete it, never push it to GitHub.

**User Data**
Bootstrap script that runs once when the instance first boots.
```hcl
user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install nginx -y
  sudo systemctl start nginx
EOF
```

---

## Key commands

```bash
terraform init      # download provider plugins, set up working directory
terraform plan      # preview what will change before touching anything
terraform apply     # deploy to AWS
terraform destroy   # tear everything down
```

---

## Terraform vs CloudFormation

| | Terraform | CloudFormation |
|---|---|---|
| Made by | HashiCorp | AWS |
| Works with | AWS, GCP, Azure, anything | AWS only |
| Language | HCL (.tf files) | JSON or YAML |
| Goes through CloudFormation | No — direct API | Yes |
| State management | Local state file | AWS manages it |
| Multi-cloud | Yes | No |

---

## Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform installed
- An AWS account with appropriate permissions

---

## Setup

```bash
terraform init
terraform plan
terraform apply
```

To clean up:
```bash
terraform destroy
```

---

## Important

Never push `terraform.tfstate` to a public repository. It contains real AWS resource IDs and potentially sensitive data. In a team environment store state remotely in an S3 bucket with DynamoDB locking.