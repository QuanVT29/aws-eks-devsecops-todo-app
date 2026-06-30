# AWS Infrastructure as Code for Todo Web Application

<br>

This project demonstrates how to deploy a containerized Todo Web Application on AWS using **Terraform** as the Infrastructure as Code (IaC) tool. It provides a scalable, secure, and automated way to provision AWS resources.

<br>

## 🚀 Architecture Overview

- **Containerization:** The web application is packaged using Docker.
- **Infrastructure:** Provisioned via Terraform, including VPC, Subnets, Security Groups, and EC2/ECS.
- **State Management:** Terraform state is stored remotely in an **S3 Bucket** with **DynamoDB** state locking.
- **Automation:** (Optional) Automated CI/CD pipeline using **GitHub Actions**.

<br>

## 🛠 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed.
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions.
- [Docker](https://www.docker.com/) installed and running.

<br>

## 📂 Project Structure

├── app/            # Application source code and Dockerfile

├── terraform/      # Terraform configurations (modules, main, variables)

└── .github/        # GitHub Actions CI/CD workflows


<br>

## ⚙️ How to Deploy

1. Initialize Terraform:

cd terraform
terraform init

2. Review the plan:

terraform plan

3. Apply the infrastructure:

terraform apply

4. 🧹 Clean Up ( To avoid unnecessary AWS costs, always destroy the resources after testing )

terraform destroy


<br>

## 📝 Author

Developed by [Your Name] – DevOps Intern aspirant. Feel free to connect or reach out!
