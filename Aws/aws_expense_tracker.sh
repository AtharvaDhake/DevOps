#1/bin/bash

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

#Runs the script every day at midnight & Saves all results and any errors into a file called aws_tracking.log
0 0 * * * /home/ubuntu/Github/Aws/aws_expense_tracker.sh >> /home/ubuntu/Github/Aws/aws_tracking.log 2>&1
