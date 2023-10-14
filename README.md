# go_bot_infrastructure
infrastructure as code for training and hosting a Go playing agents. 

This project is in progress...

## kubernetes 

# Setting Up a Go Agent on a Kubernetes Cluster using an EC2 Instance

This guide provides a step-by-step process to set up a application on a Kubernetes cluster using an EC2 instance. You will be able to run your go bot from such a container. 

## Prerequisites

- An AWS account with the necessary permissions to create EC2 instances.
- Basic knowledge of Python, Flask, Docker, and Kubernetes.
- Docker, kubectl, and AWS CLI installed on your local machine. (update your machine before installing)

## Step-by-Step App Placeholder Creation 

### 1. Create a Flask Application Placeholder 

First, create a basic Flask application.

```bash
mkdir my_flask_app
cd my_flask_app
pip install virtualenv
virtualenv venv
source venv/bin/activate
pip install Flask
pip freeze > requirements.txt
```

### 2. Containerize the Flask App with Docker

Next, create a Dockerfile in your project directory to containerize your Flask app.

```Dockerfile
FROM amazonlinux:latest

RUN yum -y update && yum -y install python3 && yum -y install python3-pip

RUN pip3 install --no-cache-dir setuptools

WORKDIR /go_bot

ADD . /go_bot

# RUN pip3 install --no-cache-dir -r /go_bot/requirements.txt
RUN pip3 install flask

# RUN cp -r $(pip3 show dlgo | grep Location | cut -d' ' -f2)/dlgo /go_bot/dlgo

EXPOSE 5000

CMD ["python3", "/go_bot/app/app.py"] 
```

Build the Docker image with the following command:

```bash
docker build -t my_flask_app .
```

### 3. Set Up Kubernetes Cluster

Set up a Kubernetes cluster on your EC2 instance. 

```bash
sudo apt install kubelet=1.20.15-00 kubeadm=1.20.15-00 kubectl=1.20.15-00
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml
```

### 4. Create a Deployment and Service for the Flask App

Create a Deployment and Service for your Flask app. Save the following configuration in a file named `flask.yaml`.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-deployment
spec:
  selector:
    matchLabels:
      app: flask
  replicas: 1
  template:
    metadata:
      labels:
        app: flask
    spec:
      containers:
      - name: flask
        image: my_flask_app
        ports:
          - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: flask-service
spec:
  ports:
  - port: 80
    targetPort: 80
    name: http
  selector:
    app: flask
```

Create the Kubernetes resources using `kubectl apply`.

```bash
kubectl apply -f flask.yaml
```

### 5. Access the App

After successfully creating the deployment and service, you can access the Flask app from outside the cluster using the external IP address of the EC2 instance and the NodePort specified in the service configuration.

Please note that this is a simplified explanation. Depending on your specific requirements, you may need to perform additional steps like setting up a database, configuring persistent storage, setting up Ingress for routing traffic, etc. Be sure to thoroughly understand each step and adapt them to your needs.

## References

- [Build a Python Flask app and deploy with Kubernetes](https://medium.com/analytics-vidhya/build-a-python-flask-app-and-deploy-with-kubernetes-ccc99bbec5dc)
- [Deploying Flask app with Kubernetes](https://medium.com/swlh/deploying-flask-app-with-kubernetes-aba8166e5f2c)
- [A guide to deploy Flask app on Google Kubernetes Engine](https://medium.com/google-cloud/a-guide-to-deploy-flask-app-on-google-kubernetes-engine-bfbbee5c6fb)
- [Deploying a Flask API and MongoDB on Kubernetes](https://jaisriram.hashnode.dev/deploying-a-flask-api-and-mongodb-on-kubernetes)
- [How to install Kubernetes cluster on AWS EC2 instances](https://www.golinuxcloud.com/setup-kubernetes-cluster-on-aws-ec2/)
- [How to setup a Kubernetes cluster on AWS EC2 using kubeadm](https://dev.to/prakashvra/how-to-setup-a-kubernetes-cluster-on-aws-ec2-using-kubeadm-containerd-and-calico-560o)


-- pending update sections... keeping for tracking currently 


## lauch services with cdk 
npx aws-cdk deploy

... pending update 

## requirments.txt content for go bot 

setuptools
numpy
keras >= 2.0.0
flask
flask-cors
future
h5py
tensorflow
six
gomill
dlgo


## Section on running cdk app 
...



Issues 

Ubuntu 22 docker setup 

go install github.com/awslabs/amazon-ecr-credential-helper/ecr-login/cli/docker-credential-ecr-login@latest

sudo apt-get install pass

sudo apt-get install golang-docker-credential-helpers

export PATH=$PATH:$(go env GOPATH)/bin

### add this to your `~/.docker/config.json`
```bash
    {
      "credsStore": "pass"
    }
```


## permissions 
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

# Error
## mesage: E1012 17:23:14.980981   20399 memcache.go:265] couldn't get current server API group list: the server has asked for the client to provide credentials
error: You must be logged in to the server (the server has asked for the client to provide credentials)
The error message you are seeing indicates that you are not authenticated or logged in to the Kubernetes cluster. To resolve this issue, you need to authenticate with the cluster using the appropriate credentials.

Here are a few steps you can follow to authenticate and resolve the error:

1. Verify that you have the correct `kubeconfig` file configured on your local machine. The `kubeconfig` file contains the necessary credentials and cluster information to authenticate with the Kubernetes cluster. You can check the location of your `kubeconfig` file by running the following command:
   ```
   echo $KUBECONFIG
   ```

2. If the `kubeconfig` file is not set or is pointing to the wrong location, you can set it using the `export` command. For example, if your `kubeconfig` file is located at `~/.kube/config`, you can run the following command:
   ```
   export KUBECONFIG=~/.kube/config
   ```

3. If you are using an EKS cluster, you can authenticate with the cluster by running the following command:
   ```
   aws eks update-kubeconfig --name <cluster-name>
   ```
   Replace `<cluster-name>` with the name of your EKS cluster. This command will update your `kubeconfig` file with the necessary credentials.

4. Once you have verified that your `kubeconfig` file is correctly configured, you can try running the `kubectl get nodes` command again to check the nodes in your cluster:
   ```
   kubectl get nodes
   ```

   If you are still experiencing authentication issues, it's possible that your credentials may have expired or are incorrect. In that case, you may need to regenerate or update your credentials.

Please note that the exact steps may vary depending on your specific setup and authentication method. If you are using a different Kubernetes distribution or authentication method, please provide more details so that I can assist you further.



## download the authenticator 
https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html

curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_amd64
curl -Lo aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.5.9/aws-iam-authenticator_0.5.9_linux_arm64
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
aws-iam-authenticator help


# use this to see what role is attached to your cluster 
aws eks describe-cluster --name go-eks-cluster --query "cluster.roleArn" --region us-east-1

## give another role master permissions 
eksctl create iamidentitymapping --cluster go-eks-cluster --region us-east-1 --arn arn:aws:iam::007469101954:role/go-bot-eks-role --username admin --group system:masters
