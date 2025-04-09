#!/bin/bash

AMI_ID="$1"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
INFO_FILE="ami-info-$AMI_ID-$TIMESTAMP.txt"

if [ -z "$AMI_ID" ]; then
  echo "ERROR: AMI ID is required as the first argument."
  exit 1
fi

echo "Generating AMI info for $AMI_ID..."

INSTALL_LOG_CONTENT=$(cat install_logs/install.log 2>/dev/null || echo "⚠️ install.log 파일이 존재하지 않음")

cat <<EOF > $INFO_FILE
AMI ID: $AMI_ID
생성 시각: $TIMESTAMP

설치된 구성 요소:
$INSTALL_LOG_CONTENT

기타 정보:
- Ubuntu 22.04 LTS
- Apache2 + PHP for CPU 부하 테스트
- CloudWatch Agent 설정 포함
- Shared User: shareduser
EOF

echo "$INFO_FILE"