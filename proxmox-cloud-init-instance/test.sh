#!/usr/bin/env bash
terraform apply -var-file=example.tfvars --auto-approve
terraform destroy -var-file=example.tfvars --auto-approve