#!/bin/sh

PROJECT_NAME=$1
SOURCE_REPO=$2
SOURCE_BRANCH=$3
GITHUB_OAUTH_TOKEN=$4

PIPELINE_STACK_NAME="my-lambda-project-pipeline"
TEMPLATE_URL="file://pipeline.yml"

aws cloudformation create-stack \
  --stack-name $PIPELINE_STACK_NAME \
  --template-body $TEMPLATE_URL \
  --capabilities CAPABILITY_IAM \
  --parameters \
      ParameterKey=ProjectName,ParameterValue=$PROJECT_NAME \
      ParameterKey=SourceRepo,ParameterValue=$SOURCE_REPO \
      ParameterKey=SourceBranch,ParameterValue=$SOURCE_BRANCH \
      ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_OAUTH_TOKEN

aws cloudformation wait stack-create-complete \
  --stack-name $PIPELINE_STACK_NAME

aws cloudformation describe-stacks \
  --stack-name $PIPELINE_STACK_NAME
