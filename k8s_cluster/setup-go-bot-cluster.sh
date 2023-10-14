#!/bin/bash

chmod +x ./scripts/install-prerequisites.sh
chmod +x ./scripts/create-go-bot-cluster.sh
chmod +x ./scripts/deploy-ssl-certificate.sh
chmod +x ./scripts/deploy-go-bot-helm-chart.sh

# install needed libraries and tools 
echo "Installing prerequisites..."
./scripts/install-prerequisites.sh

# create the cluster
echo "Creating the Kubernetes cluster..."
./scripts/create-go-bot-cluster.sh

# deploy ssl certificate
echo "Deploying SSL certificate..."
./scripts/deploy-ssl-certificate.sh

# deploy - helm chart
echo "Deploying the Go Bot Helm chart..."
./scripts/deploy-go-bot-helm-chart.sh

echo "Setup completed successfully!"
