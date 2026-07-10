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

aws-terraform-todo-app/
├── .github/

│   └── workflows/              # CI/CD pipelines for infrastructure and application deployment

│       ├── terraform.yml       # Infrastructure as Code (IaC) CI/CD pipeline

│       └── app-deploy.yml      # Application DevSecOps pipeline

├── app/

│   ├── backend/                # Node.js API source code & Backend Dockerfile

│   └── frontend/               # React.js application, Nginx configurations & Frontend Dockerfile

├── terraform/                  # AWS Infrastructure as Code (IaC) definitions

│   ├── modules/                # Reusable modules: vpc, eks, security, ecr

│   ├── backend.tf              # Remote State management (S3) & State Locking (DynamoDB)

│   └── main.tf                 # Primary root infrastructure execution plan

└── k8s/                        # Kubernetes manifests and deployment configurations
    ├── deployment-frontend.yaml
    ├── deployment-backend.yaml
    ├── ingress.yaml            # API Gateway routing rules (handling / and /api)
    └── hpa.yaml                # Horizontal Pod Autoscaler for dynamic resource scaling


<br>

## 🛠️ Tech Stack

| Layer  |   Technologies & Tools |

| Cloud Infrastructure  | AWS (VPC, EKS, ECR, S3, DynamoDB, IAM) |

| Infrastructure as Code |  Terraform (v1.10.0+) |

| Container Orchestration |  Kubernetes (AWS EKS v1.30+) |

| Managed Database  |   MongoDB Atlas (Cloud Managed) |

| DevSecOps & Security |   Checkov, Trivy, SonarQube |

| CI/CD Automation |    GitHub Actions |


