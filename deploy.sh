#!/bin/bash

echo $ECR_REGISTRY

cd initial
export SERVICE_NAME=`echo $GITHUB_REPOSITORY | awk -F "/" '{print $2}'`
export VERSION=`bash ./gradlew -Pbuild_target=SNAPSHOT -q properties | grep version | sed -e "s@version: @@g"`
export SERVICE_CODE=`echo "$VERSION" | cut -d '-' -f1`
export IMAGE_NAME="$ECR_REGISTRY/$SERVICE_NAME:$SERVICE_CODE.$COMMIT_HASH"
cd ..

echo "$IMAGE_NAME"

aws sts get-caller-identity
#aws eks update-kubeconfig --name eksdemo1 --region us-east-1

export COLOR1="blue"
export COLOR2="green"

#export SERVICE_ACTIVE_COLOR=$(kubectl get svc rest-uservice -n $ENVIRONMENT -o jsonpath='{.spec.selector.color}' --ignore-not-found=true)

if [ "$SERVICE_ACTIVE_COLOR" == "$COLOR1" ]; then
  export SERVICE_PASSIVE_COLOR="$COLOR2"
else
  export SERVICE_PASSIVE_COLOR="$COLOR1"
fi

echo "Currently running deployment color : $SERVICE_ACTIVE_COLOR"

yq --version

#kubectl apply -f ./manifests/deployment.yaml
#kubectl apply -f ./manifests/service.yaml
