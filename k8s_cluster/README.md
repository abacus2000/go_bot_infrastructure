# Go Bot Site Kubernetes Setup

This repository contains scripts and configuration files to set up a Kubernetes cluster for a Go Bot Site.

## Files

- `install-prerequisites.sh`: Installs necessary software (Nano, eksctl, Helm)
- `create-go-bot-cluster.sh`: Creates the Kubernetes cluster
- `deploy-ssl-certificate.sh`: Deploys an SSL certificate using AWS CloudFormation
- `deploy-go-bot-helm-chart.sh`: Deploys the Go Bot Helm chart

## Usage

1. Install prerequisites:
   ```bash
   ./scripts/install-prerequisites.sh
   ```
   
2. Create the Kubernetes cluster:
   ```bash
   ./scripts/create-go-bot-cluster.sh
   ```
   
3. Deploy the SSL certificate:
   ```bash
   ./scripts/deploy-ssl-certificate.sh
   ```
   
4. Deploy the Go Bot Helm chart:
   ```bash
   ./scripts/deploy-go-bot-helm-chart.sh
   ```
