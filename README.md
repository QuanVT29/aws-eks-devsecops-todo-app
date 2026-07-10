# 🚀 Cloud-Native DevSecOps Todo Application on AWS EKS

This project demonstrates the design, deployment, and automation of a cloud-native, DevSecOps-aligned MERN Stack web application deployed on AWS EKS (Elastic Kubernetes Service). The entire infrastructure is managed as code (IaC) via Terraform and orchestrated using automated GitHub Actions CI/CD pipelines integrated with automated security scanning tools.

---

<br>
<br>

## 🏗️ Architecture Overview

The project implements a multi-layered cloud security architecture designed for High Availability (HA), dynamic auto-scaling, and strict network isolation.

![AWS EKS Architecture](screenshots/aws-eks-architecture.png)

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


<br>

## 🚀 Deployment Guide

Step 1: Remote State & Backend Initialization
Ensure the AWS CLI is configured locally and Terraform is installed. Initialize an S3 Bucket and a DynamoDB table via the AWS Console to handle state locking and storage securely.

Step 2: Provision Infrastructure via Terraform

```
cd terraform

terraform init

terraform plan

terraform apply -auto-approve
```

Step 3: Configure Kubernetes Cluster Context

Once the Terraform execution completes, fetch the cluster authentication context to interact with your EKS cluster using kubectl:

```text
aws eks update-kubeconfig --region us-east-1 --name todo-app-cluster
```

Step 4: Deploy Manifests to the Cluster

```text
cd ../k8s
kubectl apply -f .
```

<br>

## 📊 Screenshots & Verification

The following verification metrics confirm system stability and pipeline compliance post-automation:

1. Dynamic Web UI Accessible via Ingress
   
Screenshot specifications: A full-browser window captured in an Incognito tab rendering the live application via the ALB/Ingress endpoint. The page title must display "CI/CD Automated", the data fields load seamlessly, and the browser DevTools Console (F12) displays clean with zero execution errors.

3. Real-Time Data Persistence on MongoDB Atlas

Screenshot specifications: The "Browse Collections" interface on the MongoDB Atlas Cloud Console, confirming that test documents inserted via the Web UI successfully populated the todos collection.

4. Successful DevSecOps Pipeline Status

Screenshot specifications: The GitHub Actions dashboard displaying a successful execution run (Green Checkmark) for the application compilation and the Trivy container image vulnerability scanning stage.

5. Cluster Runtime Status (Kubernetes Workloads)

Screenshot specifications: A terminal output executing kubectl get all -n default, displaying all frontend and backend pods in a healthy Running state along with active active Ingress resources.

<br>

## 🧹 Clean Up

To prevent unexpected billing charges on your AWS account, tear down all active cloud resources immediately after testing:

```text
kubectl delete -f k8s/
cd terraform
terraform destroy -auto-approve
```

<br>

## 📝 Author

QuanVT29 – Information Assurance Student @ FPT University & Cloud DevOps Engineer Fresher.

Connect with me on GitHub or https://www.linkedin.com/in/qu%C3%A2n-vt-243752337/ 
