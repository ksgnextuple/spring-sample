#!/bin/bash

echo ${{ ECR_REGISTRY }}


aws sts get-caller-identity
aws eks update-kubeconfig --name eksdemo1 --region us-east-1

export ENVIRONMENT="dev"
export COLOR1="blue"
export COLOR2="green"

export SERVICE_ACTIVE_COLOR=$(kubectl get svc rest-uservice -n $ENVIRONMENT -o jsonpath='{.spec.selector.color}' --ignore-not-found=true)

if [ "$SERVICE_ACTIVE_COLOR" == "$COLOR1" ]; then
  export SERVICE_PASSIVE_COLOR="$COLOR2"
else
  export SERVICE_PASSIVE_COLOR="$COLOR1"
fi

echo "Currently running deployment color : $SERVICE_ACTIVE_COLOR"


#kubectl apply -f ./manifests/deployment.yaml
#kubectl apply -f ./manifests/service.yaml
