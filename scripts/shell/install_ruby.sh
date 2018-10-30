#!/bin/bash
# install_ruby.sh

apt-get autoclean
apt-get install -y build-essential zlib1g zlib1g-dev libreadline6 libreadline6-dev libssl-dev
curl -L https://get.rvm.io | bash -s -- --ignore-dotfiles --autolibs=0 --ruby
touch ~/.gemrc
echo 'gem: -–no-rdoc --no-ri' >> ~/.gemrc
gem install bundler

# rvm install ruby-2.5.2
# rvm use 2.5.2 --default
