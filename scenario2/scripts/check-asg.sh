#!/bin/bash

ASG_NAME="NoHands_ASG2"

EXISTING_ASG=$(aws autoscaling describe-auto-scaling-groups \
  --region ap-northeast-2 \
  --auto-scaling-group-names "$ASG_NAME" \
  --query "AutoScalingGroups[*].AutoScalingGroupName" \
  --output text)

if [ "$EXISTING_ASG" == "$ASG_NAME" ]; then
  echo "ASG_EXISTS=true" >> "$GITHUB_ENV"
else
  echo "ASG_EXISTS=false" >> "$GITHUB_ENV"
fi