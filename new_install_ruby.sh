#!/usr/bin/env bash
set -x
#This script is for installing and compling ruby from source.

#Execution dir
EDIR=`pwd`



PSCRIPT="./pre_ruby_install.sh"
if [[ ! -x $PSCRIPT ]]
then
  chmod 700 pre_ruby_install.sh
fi
#Execute pre script to get and compile each ruby versions.
. ./pre_ruby_install.sh

RUBIES=".rubies"

RUBY_DIR="$HOME/$RUBIES"

check_ruby_dir(){
 if [[ ! -d "$RUBY_DIR" ]]
 then
    mkdir $RUBY_DIR
 fi
}




bold=`tput bold`
WGET=`which wget`
URL="https://cache.ruby-lang.org/pub/ruby/"
RUBY_LISTS="/tmp/ruby_lists.html"
WGET_LOG="$RUBY_LISTS.log"
#Only xz extension version

rm_pre(){
  #Remove previous ruby lists html files
  if [[ -e $RUBY_LISTS ]]
  then
     echo "Removing downloaded ruby list file"
     rm -f $RUBY_LISTS
  fi

  #Remove previous ruby compile directory
     echo "Removing previous RUBY SOURCE_DIR"
     find /tmp -type d | grep -i "ruby-*" | xargs rm -rfv
     find /tmp -type f | grep -i "ruby-*" | xargs rm -rfv

}

#Execute rm_pre function
rm_pre

$WGET $URL -O $RUBY_LISTS -o $WGET_LOG

#Ruby xz,gz,bz2 lists
#RLCA=( $(cat $RUBY_LISTS | grep "ruby-[0-9]\.[0-9]\.[0-9]\.tar\.[xgb]z" | awk -F["\"","\""] '{print $2}') )

#Ruby only xz version
RLCA=( $(cat $RUBY_LISTS | grep "ruby-[0-9]\.[0-9]\.[0-9]\.tar\.xz" | awk -F["\"","\""] '{print $2}') )
#echo ${RLCA[*]}
MAX_RLCA=$((${#RLCA[@]} - 1))

ruby_list(){
echo -e "$bold\e[33m##### Available .xz extension ruby versions ##### \e[0m"
for ele in $(seq 0 $((${#RLCA[@]} - 1)) )
do
    echo -e "\e[31m$ele)\e[0m \t ${RLCA[$ele]} "
done


 echo -e "$bold\e[33m Please choose the ruby version from 0) to $((${#RLCA[@]} - 1)))  \e[0m"
 read NUMBER
 if [[ ($NUMBER -lt 0) || $NUMBER -gt $MAX_RLCA ]]
 then
    echo -e "\e[31m Please input from 0 to $MAX_RLCA\e[0m"
    ruby_list
 fi
}



install(){
  ruby_list
  if [[ $NUMBER != "" ]]
  then
   SOURCE_FILE="${RLCA[$NUMBER]}"
   SOURCE_DIR=$(echo $SOURCE_FILE | awk -F '.tar.xz' '{print $1}')
   VERSION=$SOURCE_DIR
   RUBY_URL="$URL${RLCA[$NUMBER]}"
  else
   echo "Please input NUMBER"
   install
  fi  


 cd /tmp
 wget $RUBY_URL
 #VERSION=$(echo $RUBY_URL | awk -F '/' '{print $7}' | awk -F '.tar.gz' '{print $1}')
 tar xvJf $SOURCE_FILE
 cd $SOURCE_DIR
 RUBY_EACH_HOME=$RUBY_DIR/$VERSION
 ./configure --prefix=$RUBY_EACH_HOME
 make
 make install
 #removing sourcedir
 rm -rf $VERSION
 sleep 1
 #touch $HOME/.bashrc
 . ./bash_confirm.sh
 echo "export PATH=$RUBY_EACH_HOME/bin:$PATH" >> $HOME/.bashrc
 cd $HOME; . .bashrc
}


install
