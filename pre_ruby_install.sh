#!/usr/bin/env bash
if [[ -e /etc/redhat-release ]]
then
  sudo yum update
  sudo yum -y install wget gcc openssl-devel libffi-devel
  echo "installing necessary packages"
  sleep 3
elif [[ `cat /proc/version | egrep -i "ubuntu|debian"` != "" ]]
then
  sudo apt-get -y update
  sudo apt-get -y install libc6-dev libssl-dev libmysql++-dev libsqlite3-dev make build-essential libssl-dev libreadline6-dev zlib1g-dev libyaml-dev
  echo "installing necessary packages"
  sleep 3
fi
