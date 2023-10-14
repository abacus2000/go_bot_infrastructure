#!/bin/bash

domain_name="go-bot-arena.com"
hosted_zone_id="go-bot-arena.com"

aws cloudformation deploy --stack-name go-bot-ssl-certificate --template-file cloudformation/go-bot-acm.yaml --parameter-overrides DomainName=${domain_name}         HostedZoneId=${hosted_zone_id}
