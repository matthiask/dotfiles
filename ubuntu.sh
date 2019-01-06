curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt -y dist-upgrade

sudo apt install -y gettext vim-nox deborphan
sudo apt install -y python3-venv python3-pip python-pip virtualenv twine tox
sudo apt install -y redis-server postgresql postgresql-client
sudo apt install -y x11-xserver-utils xfce4-terminal rxvt-unicode
sudo apt install -y fonts-inconsolata fonts-emojione
sudo apt install -y yarn
sudo pip2 install -U fh-fablib
