# 🚀 DevOps Engineer Task — Automated Kubernetes Deployment (EKS)

![app/Screenshot (823).png]

## 📘 Project Overview
This project demonstrates a complete **CI/CD pipeline** that automates the process of building, containerizing, and deploying a web application to an **Amazon EKS (Elastic Kubernetes Service)** cluster using **Jenkins**, **Docker**, **Kubernetes**, and **AWS**.

It fulfills the DevOps Engineer Take-Home Task requirements — showcasing Infrastructure as Code, containerization, Kubernetes deployment, and full automation via Jenkins pipelines.

---

## 🧩 Tech Stack

| Category | Tools / Technologies |
|-----------|----------------------|
| CI/CD | Jenkins |
| Containerization | Docker |
| Orchestration | Kubernetes (Amazon EKS) |
| Cloud Provider | AWS |
| IaC | Terraform *(optional for provisioning EKS)* |
| Image Registry | Docker Hub |
| Source Control | GitHub |
| OS | Ubuntu / Linux (Jenkins agent) |

---

## 📂 Repository Structure

```
devops-eks-project/
├── app/
│   └── index.html
├── Dockerfile
├── Jenkinsfile
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/
└── README.md
```

---

## 🧰 Prerequisites

- AWS account with EKS access
- Docker Hub account
- Jenkins with Docker, kubectl, and Git
- EKS kubeconfig (or Terraform to create one)

---

## ⚙️ Setup & Installation

### 1️⃣ Clone Repository

```bash
git clone https://github.com/Shivsamb-Jalkote/devops-eks-project.git
cd devops-eks-project
```

### 2️⃣ Docker Setup

```bash
docker build -t shivjalkote/eks-nginx-app:v1 .
docker run -d -p 8080:80 shivjalkote/eks-nginx-app:v1
```

Visit: **http://localhost:8080**

### 3️⃣ Jenkins Configuration

**Credentials:**
| ID | Type | Purpose |
|----|------|----------|
| dockerhub-creds | Username/Password | DockerHub |
| kubeconfig-file | Secret File | EKS kubeconfig |

**Pipeline Script Path:** `jenkins/Jenkinsfile`

---

## 🧾 Kubernetes Manifests

**deployment.yaml**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hello-world
  template:
    metadata:
      labels:
        app: hello-world
    spec:
      containers:
        - name: hello-world-container
          image: shivjalkote/eks-nginx-app:v1
          ports:
            - containerPort: 80
```

**service.yaml**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: hello-world-service
spec:
  selector:
    app: hello-world
  ports:
    - port: 80
      targetPort: 80
  type: LoadBalancer
```

---

## 🌐 Verify on EKS

```bash
aws eks --region ap-south-1 update-kubeconfig --name my-eks-cluster
kubectl get pods
kubectl get svc
```

**Example Output:**
```
NAME                  TYPE           CLUSTER-IP      EXTERNAL-IP                            PORT(S)        AGE
hello-world-service   LoadBalancer   10.100.45.123   a1b2c3d4.ap-south-1.elb.amazonaws.com   80:31234/TCP   4m
```

Visit: **http://a1b2c3d4.ap-south-1.elb.amazonaws.com**

---

## 🧑‍💻 Author

**👤 Shiv Jadhav**  
DevOps Engineer | AWS | Terraform | Kubernetes | CI/CD | Linux  
📧 shivjalkote@example.com  
🔗 [GitHub Profile](https://github.com/Shivsamb-Jalkote)

---

> 💬 *"Automate everything that can be automated — this project is a great step in that direction."*
