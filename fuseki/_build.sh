#!/bin/bash

docker build . -t fairvasc_fuseki
docker tag fairvasc_fuseki ghcr.io/louisaslett/fairvasc_fuseki:latest

echo "PAT_HERE" | docker login ghcr.io -u louisaslett --password-stdin

docker push ghcr.io/louisaslett/fairvasc_fuseki:latest
