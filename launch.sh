#!/usr/bin/env bash
set -o errexit

for y in terraform aws;
  do
    _PROGNAME=$y
    if ! hash ${_PROGNAME} >/dev/null 2>&1; then
    printf "installing -  ${_PROGNAME} ...."
    ../install-${_PROGNAME}.sh
    fi
done

export PATH=$PATH:~/bin
echo $PATH


export AWS_ACCESS_KEY_ID=$(egrep ^aws_access ~/.aws/credentials  | awk '{ print $3 }')
export AWS_SECRET_ACCESS_KEY=$(egrep ^aws_secret ~/.aws/credentials  | awk '{ print $3 }')
export AWS_DEFAULT_REGION=eu-central-1

pushd resources 
terraform get
terraform plan -input=false
terraform apply -input=false

if [[ $? != 0 ]]; then
    exit 1
  else
   sleep 30; popd ; ./describe-asg-instance.sh emalloy-ro-test eu-central-1 
fi
