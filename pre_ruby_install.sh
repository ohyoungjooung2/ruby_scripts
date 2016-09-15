#!/usr/bin/env bash
if [[ /etc/redhat-release ]]
then
  sudo yum -y install wget gcc openssl-devel libffi-devel
fi
