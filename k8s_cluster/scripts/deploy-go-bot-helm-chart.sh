#!/bin/bash

base_domain="go-bot-arena.com"

# deploy the go bot Helm files
helm upgrade --install go-bot-site --set baseDomain=${base_domain} --set ssl.enabled=true ./helm-charts/go-bot
