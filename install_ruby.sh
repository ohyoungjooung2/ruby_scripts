#!/usr/bin/env bash
#This script is for installing and compling ruby from source.
#Each version is $1
#Ruby current stable version is 2.3.1
set -x

#Execution dir
EDIR=`pwd`


##Remove dir includes previous sources and etc.

. ./rm_pre.sh


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


remove_pre_installed(){
 if [[ -d $RUBY_DIR/$VERSION ]]
 then
    echo "Previous same version exist"
    echo "Do you want to remove it"
    read answer
    if [[ $answer=="y" || $answer=="Y" || $answer=="Yes" ]]
    then
       rm -rfpv $RUBY_DIR/$VERSION
       echo "success of previous $VERSION"
    fi
 fi
}


install(){
 VERSION=$1
 PRE_URL="http://cache.ruby-lang.org/pub/ruby"
 SOURCE_FILE="ruby-$VERSION.tar.gz"
 SOURCE_DIR="ruby-$VERSION"
 RUBY_URL="$PRE_URL/ruby-$VERSION.tar.gz"
 
 #Removing previous same version 
 remove_pre_installed

 cd /tmp
 wget $RUBY_URL
 #VERSION=$(echo $RUBY_URL | awk -F '/' '{print $7}' | awk -F '.tar.gz' '{print $1}')
 tar xvzf $SOURCE_FILE
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

check_ruby_dir
install $1



#To add auto completion function into irb file
. $EDIR/add_completion.rb
