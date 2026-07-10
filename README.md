# 🚀 Cloud-Native DevSecOps Todo Application on AWS EKS

This project demonstrates the design, deployment, and automation of a cloud-native, DevSecOps-aligned MERN Stack web application deployed on AWS EKS (Elastic Kubernetes Service). The entire infrastructure is managed as code (IaC) via Terraform and orchestrated using automated GitHub Actions CI/CD pipelines integrated with automated security scanning tools.

---

<br>
<br>

## 🏗️ Architecture Overview

The project implements a multi-layered cloud security architecture designed for High Availability (HA), dynamic auto-scaling, and strict network isolation.

![AWS EKS Architecture]()

---

<br>


## 🛡️ Security & Automation Pipeline (DevSecOps CI/CD)

The system enforces a **Shift-Left Security** methodology through two distinct automated GitHub Actions workflows:



- Infrastructure as Code (IaC) Security Scanning: Automatically inspects Terraform configurations for misclassifications and security vulnerabilities using Checkov.

- Static Application Security Testing (SAST): Syntactically analyzes Frontend and Backend source code utilizing SonarQube to identify bugs, vulnerabilities, and code smells.

- Container Image Vulnerability Scanning: Utilizes Trivy to perform deep layer-by-layer scanning of Docker images prior to pushing them to AWS ECR, preventing deprecated or vulnerable packages from reaching production.



<br>

## 📂 Project Structure

```text
aws-terraform-todo-app/
├── .github/
│   └── workflows/
│       ├── terraform.yml          # Terraform IaC Pipeline
│       └── app-deploy.yml         # Application Deployment Pipeline
│
├── app/
│   ├── backend/                   # Node.js API + Dockerfile
│   └── frontend/                  # React.js + Nginx + Dockerfile
│
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   ├── eks/
│   │   ├── ecr/
│   │   └── security/
│   │
│   ├── backend.tf                 # S3 + DynamoDB Remote State
│   └── main.tf                    # Root Infrastructure
│
└── k8s/
    ├── deployment-backend.yaml
    ├── deployment-frontend.yaml
    ├── ingress.yaml
    └── hpa.yaml
```


<br>


## 🛠 Tech Stack

| Layer | Technologies |
|--------|--------------|
|  Cloud Infrastructure | AWS (VPC, EKS, IAM, ECR, S3, DynamoDB) |
|  Infrastructure as Code | Terraform v1.10+ |
|  Containerization | Docker |
|  Kubernetes | Amazon EKS (v1.30+) |
|  Database | MongoDB Atlas |
|  DevSecOps | Trivy, Checkov, SonarQube |
|  CI/CD | GitHub Actions |
|  Frontend | React.js, Nginx |
|  Backend | Node.js, Express.js |

