#!/bin/bash

ASG_NAME="NoHands_ASG2"
LAUNCH_TEMPLATE_NAME="NoHands_tp"
NEW_AMI_ID="$NEW_AMI_ID_FROM_ENV"

# 1. Create new launch template version
NEW_VERSION=$(aws ec2 create-launch-template-version \
  --launch-template-name "$LAUNCH_TEMPLATE_NAME" \
  --version-description "Auto created by GitHub Actions" \
  --source-version 1 \
  --launch-template-data "{\"ImageId\":\"$NEW_AMI_ID\"}" \
  --query 'LaunchTemplateVersion.VersionNumber' \
  --output text)

# 2. Set default version of launch template
aws ec2 modify-launch-template \
  --launch-template-name "$LAUNCH_TEMPLATE_NAME" \
  --default-version "$NEW_VERSION"

# 3. Start ASG rolling update
aws autoscaling start-instance-refresh \
  --auto-scaling-group-name "$ASG_NAME" \
  --strategy Rolling