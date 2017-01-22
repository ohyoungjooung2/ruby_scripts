#!/usr/bin/env bash
#This script is for installing and compling ruby from source.
#Each version is $1
#Ruby current stable version is 2.3.1
set -x

##Remove dir includes previous sources and etc.

. ./rm_pre.sh


PSCRIPT="./pre_ruby_install.sh"
if [[ ! -x $PSCRIPT ]]
then 
  chmod 700 pre_ruby_install.sh
fi
#Execute pre script to get and compile each ruby versions.
. ./pre_ruby_install.sh

RUBIES="rubies"

RUBY_DIR="$HOME/$RUBIES"

check_ruby_dir(){
 if [[ ! -d "$RUBY_DIR" ]]
 then
    mkdir $RUBY_DIR
 fi
}



install(){
 wget $RUBY_URL
 VERSION=$(echo $RUBY_URL | awk -F '/' '{print $7}' | awk -F '.tar.gz' '{print $1}')
 tar xvzf "$VERSION.tar.gz"
 cd $VERSION
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

 

#cd to /tmp
cd /tmp
if [[ $1 == "2.0.0-p598" ]]
then
 RUBY_URL="http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p598.tar.gz"
 install
elif [[ $1 == "2.1.5" ]]
then
 RUBY_URL="http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.5.tar.gz"
 install
elif [[ $1 == "2.2.0" ]]
then
 RUBY_URL="http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.0.tar.gz"
 install
elif [[ $1 == "2.3" ]]
then
 RUBY_URL="http://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz"
 install
else
 echo "Usage: chmod a+x $0; and ./$0 ruby version(2.0.0-p598,2.1.0,2.2.0)"
 exit 1
fi


#To add auto completion function into irb file
. ./add_completion.rb
