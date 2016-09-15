#!/usr/bin/env bash
#Remove dir includes previous sources and etc.
rm_pre(){
  com_dir=`pwd`
  cd /tmp
  if [[ ruby-$1.* ]]
  then
    echo "ruby $1 is exist"
    rm -rfv ruby-$1.*
    cd $com_dir
  fi
}

rm_pre $1
