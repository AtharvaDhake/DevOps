
#1/bin/bash

###CronJOb
# 1. Set the correct case-sensitive folder path
LOG_DIR="/home/ubuntu/Github/Aws"
LOG_FILE="$LOG_DIR/aws_tracking.log"

# 2. Get the absolute path of THIS script automatically
SCRIPT_PATH=$(realpath "$0")

# 3. Create the directory if it's missing (using -p prevents errors if it exists)
mkdir -p "$LOG_DIR"

# 4. Define the exact cron job line
CRON_LINE="0 0 * * * $SCRIPT_PATH >> $LOG_FILE 2>&1"

# 5. Only add to crontab if it isn't already there (prevents duplicates)
if ! crontab -l 2>/dev/null | grep -Fq "$SCRIPT_PATH"; then
    (crontab -l 2>/dev/null; echo "$CRON_LINE") | crontab -
    echo "Success: Cron job registered for $SCRIPT_PATH"
    echo "Logs will save to: $LOG_FILE"
fi

#########################################
#Author : Atharva
#Date ; 12/4/2026
#
# Version: v1
#
# This script will report the Aws expense
##########################################

set -x
set -e
set -o pipefail

#list s3 buckets
aws s3 ls

#list ec2 Instaces
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

#list aws lambda functions
aws lambda list-functions

#list IAM users
aws iam list-users
