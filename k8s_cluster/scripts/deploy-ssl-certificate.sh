#!/bin/bash

domain_name="go-bot-arena.com"
hosted_zone_id="Z02234441F3YAA7D4OG10"

aws cloudformation deploy --stack-name go-bot-ssl-certificate --template-file cloudformation/go-bot-acm.yaml --parameter-overrides DomainName=${domain_name} HostedZoneId=${hosted_zone_id}
