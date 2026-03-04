#!/bin/bash 

# create podinfo namespace
kubectl create namespace podinfo

# label for istio injection
kubectl label namespace podinfo istio-injection=enabled

# deploy podinfo application
helm upgrade --install podinfo --namespace podinfo .