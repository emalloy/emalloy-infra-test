#!/usr/bin/env bash
set -o errexit

export PATH=$PATH:~/bin
echo $PATH


export AWS_ACCESS_KEY_ID=$(egrep ^aws_access ~/.aws/credentials  | awk '{ print $3 }')
export AWS_SECRET_ACCESS_KEY=$(egrep ^aws_secret ~/.aws/credentials  | awk '{ print $3 }')
export AWS_DEFAULT_REGION=eu-central-1

pushd resources 
terraform destroy -force 

popd

