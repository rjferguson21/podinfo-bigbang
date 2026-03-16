#!/bin/bash 

# create podinfo namespace
kubectl create namespace podinfo

# label for istio injection
# kubectl label namespace podinfo istio-injection=enabled
kubectl label namespace podinfo istio.io/dataplane-mode=ambient

# deploy podinfo application
helm upgrade --install podinfo --namespace podinfo chart