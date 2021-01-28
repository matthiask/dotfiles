#!/bin/bash
set -ex

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
echo -e "deb https://deb.nodesource.com/node_14.x bionic main\ndeb-src https://deb.nodesource.com/node_14.x bionic main\n" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt update
sudo apt -y dist-upgrade

sudo apt remove -y cmdtest
sudo apt install -y gettext vim-nox deborphan \
 python3-venv python3-pip python-pip \
 redis-server postgresql postgresql-client \
 yarn gitk git-gui whois \
 imagemagick apg moreutils poppler-utils watchman

# sudo pip2 install -U fh-fablib
# sudo pip3 install -U tox twine

echo -e "[pypi]\nusername: matthiask\npassword: ----" >> ~/.pypirc
echo ". ~/_dotfiles/bash_aliases" >> ~/.bashrc
