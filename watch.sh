#!/bin/bash

watch -n 1 -c "helm template chart --api-versions networking.istio.io/v1  | kgrep -s"