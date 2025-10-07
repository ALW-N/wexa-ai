# Wexa-AI

======================================

## Overview

This project is part of the DevOps Internship Assessment, demonstrating the full lifecycle of containerizing, automating, and deploying a Next.js application using:

* Docker
* GitHub Actions
* GitHub Container Registry (GHCR)
* Kubernetes (Minikube)

The goal is to build, push, and deploy a production-ready Next.js application in a Kubernetes environment.

## Tech Stack

* Frontend Framework: Next.js (Node.js)
* Containerization: Docker
* CI/CD: GitHub Actions
* Registry: GitHub Container Registry (GHCR)
* Orchestration: Kubernetes (Minikube)

## Project Structure

```
wexa-ai/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── Dockerfile
├── package.json
├── next.config.js
├── README.md
└── ...
```

## Local Setup (without Docker)

1. Clone the repository:

```
git clone https://github.com/ALW-N/wexa-ai.git
cd wexa-ai
```

2. Install dependencies:

```
npm install
```

3. Run locally:

```
npm run dev
```

Open `http://localhost:3000` in your browser.

## Build & Run Locally with Docker

1. Build the Docker Image:

```
docker build -t ghcr.io/alw-n/wexa-ai:latest .
```

2. Run the container:

```
docker run -p 3000:3000 ghcr.io/alw-n/wexa-ai:latest
```

3. Open the app at `http://localhost:3000`

## GitHub Actions (CI/CD)

The workflow automatically:

1. Builds the Docker image on push to `main` branch
2. Tags and pushes the image to GHCR
3. Uses secure authentication via `${{ secrets.GHCR_TOKEN }}`

Workflow file: `.github/workflows/docker-build.yml`

## Kubernetes Deployment (Minikube)

1. Start Minikube:

```
minikube start
```

2. Create GHCR Secret:

```
Bash:
kubectl create secret docker-registry ghcr-secret \
  --docker-server=ghcr.io \
  --docker-username=<YOUR_USERNAME> \
  --docker-password=<YOUR_PERSONAL_ACCESS_TOKEN> \
  --docker-email=<YOUR_EMAIL_ID>

Powershell:
kubectl create secret docker-registry ghcr-secret --docker-server=ghcr.io --docker-username=<YOUR_USERNAME> --docker-password="<YOUR_PERSONAL_ACCESS_TOKEN>  " --docker-email="<YOUR_EMAIL_ID>"

```

3. Apply manifests:

```
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

4. Check status:

```
kubectl get pods
kubectl get svc
```

Ensure pods are Running.

## Access the Application

Option 1 — Using Minikube Service:

```
minikube service wexa-ai-service
```

Option 2 — Manual Access:

```
minikube ip
http://<minikube-ip>:30001
```

Example: `http://192.168.49.2:30001`

## Deployment Verification

* Check pods:

```
kubectl get pods
```

* View logs:

```
kubectl logs <pod-name>
```

Example output:

```
next start -p 3000 -H 0.0.0.0
✓ Starting...
✓ Ready in 330ms
```

* Access via Minikube: Opened successfully using `minikube service wexa-ai-service`

## GHCR Image URL

```
ghcr.io/alw-n/wexa-ai:latest
```

## Submission Details

* Repository: [https://github.com/ALW-N/wexa-ai](https://github.com/ALW-N/wexa-ai)
* Image URL: ghcr.io/alw-n/wexa-ai:latest
