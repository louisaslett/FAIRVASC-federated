#!/bin/bash

docker build . -t ghcr.io/louisaslett/fairvasc-federated/fuseki:latest

echo "PAT_HERE" | docker login ghcr.io -u louisaslett --password-stdin

docker push ghcr.io/louisaslett/fairvasc-federated/fuseki:latest
