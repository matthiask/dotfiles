#!/bin/bash
set -ex

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt -y dist-upgrade

sudo apt install -y gettext vim-nox deborphan \
 python3-venv python3-pip python-pip virtualenv twine tox \
 redis-server postgresql postgresql-client \
 x11-xserver-utils xfce4-terminal rxvt-unicode \
 fonts-inconsolata fonts-emojione yarn gitk git-gui whois \
 imagemagick

sudo pip2 install -U fh-fablib
