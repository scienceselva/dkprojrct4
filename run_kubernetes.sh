#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=scienceselva/devopsproject4

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run mlappk --image=$dockerpath:mlapp --port=8080

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward deployment/mlappk 8080:80

#use pods if the pods are already created
#kubectl port-forward pods/mlappk 8080:80