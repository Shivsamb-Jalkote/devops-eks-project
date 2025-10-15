# DevOps Engineer Task — Automated Nginx Deployment on AWS EKS

## Overview
This project automates deployment of a simple **Nginx Hello World** web app on an **AWS EKS** cluster using:
- Terraform (provision EKS)
- Docker (containerize)
- Helm (package & deploy)
- Jenkins (CI/CD)
- Docker Hub (image registry)

## Pre-filled variables (replace if needed)
- AWS Region: us-east-1
- EKS Cluster Name: default
- Docker Hub image repository: shivjalkote/eks-nginx-app
- VPC ID: vpc-01d25a141a26571c8
- Subnets: subnet-0a42b10f7b70f11a4, subnet-0711dad0b1507dbea

## Repo structure
- `ec2-bootstrap.sh` — installs Docker, Terraform, kubectl, helm and Jenkins on Ubuntu
- `terraform/` — Terraform code to provision EKS using your existing VPC
- `app/` — Nginx static site + Dockerfile
- `helm-chart/` — Helm chart for deployment
- `jenkins/Jenkinsfile` — Declarative pipeline for build → push → deploy
- `README.md` — this file

## Quickstart (high level)
1. Launch an Ubuntu 22.04 EC2 instance and run `ec2-bootstrap.sh` as userdata or manually.
2. Configure AWS CLI on the EC2 instance: `aws configure`
3. From `terraform/` run:
   ```bash
   terraform init
   terraform apply -var="vpc_id=vpc-01d25a141a26571c8" -var='subnet_ids=["subnet-0a42b10f7b70f11a4", "subnet-0711dad0b1507dbea"]' -var="key_name=your-keypair" -auto-approve
   aws eks update-kubeconfig --region us-east-1 --name default
   kubectl get nodes
   ```
4. Build and test the Docker image locally (optional):
   ```bash
   cd app
   docker build -t shivjalkote/eks-nginx-app:local .
   docker run -p 8080:80 shivjalkote/eks-nginx-app:local
   curl http://localhost:8080
   ```
5. In Jenkins:
   - Create credentials:
     - `dockerhub-creds` (Username with password) — Docker Hub credentials
     - `kubeconfig-file` (Secret file) — upload `~/.kube/config` from the EC2 where you ran `aws eks update-kubeconfig`
   - Create a Pipeline job pointing to this repository (uses `jenkins/Jenkinsfile`).
6. Push code to GitHub → Jenkins will build, push the image and deploy with Helm.

## Notes
- Replace `your-keypair` in `terraform.tfvars` with the EC2 keypair name you want to use for node SSH access.
- The Jenkins pipeline expects credential IDs as named above. You can change the IDs in `jenkins/Jenkinsfile` if needed.

## How to get the app URL
After deployment, run:
```bash
kubectl get svc
```
Look for the `hello-release` service's `EXTERNAL-IP`/hostname. Open it in browser to see the Nginx Hello World page.

## Troubleshooting
- If `kubectl` cannot connect, re-run: `aws eks update-kubeconfig --region us-east-1 --name default`
- If Helm fails due to RBAC, ensure kubeconfig used by Jenkins has cluster-admin rights or appropriate RBAC.

## License
MIT
