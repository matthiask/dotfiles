curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt update
apt -y dist-upgrade

apt install -y gettext vim-nox deborphan
apt install -y python3-venv python3-pip python-pip virtualenv twine tox
apt install -y redis-server postgresql postgresql-client
apt install -y x11-xserver-utils xfce4-terminal rxvt-unicode
apt install -y fonts-inconsolata fonts-emojione
apt install -y yarn
sudo pip2 install -U fh-fablib
