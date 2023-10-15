# /bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 007469101954.dkr.ecr.us-east-1.amazonaws.com

docker build -t go-bot-arean .

docker tag go-bot-arean:latest 007469101954.dkr.ecr.us-east-1.amazonaws.com/go-bot-arean:latest

docker push 007469101954.dkr.ecr.us-east-1.amazonaws.com/go-bot-arean:latest