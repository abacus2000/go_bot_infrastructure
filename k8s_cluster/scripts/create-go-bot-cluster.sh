#!/bin/bash

eksctl create cluster -f cloudformation/go-bot-cluster.yaml

echo "*************************************************************"
echo "********* FINISHED Creating Go Bot Cluster ******************"
echo "*************************************************************"
