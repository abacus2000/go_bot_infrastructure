#!/bin/bash

# base_domain="go-bot-arena.com"

# deploy the go bot Helm files
# helm upgrade --install go-bot --set baseDomain=${base_domain} --set ssl.enabled=true ./helm-charts/go-bot
helm upgrade --install go-bot ./helm-charts/go-bot
