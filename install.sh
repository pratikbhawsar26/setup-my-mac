#!/bin/bash
set -e

echo "======================================"
echo "Setting up your mac using setup-my-mac"
echo "======================================"

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# adding brew to path
eval "$(/opt/homebrew/bin/brew shellenv)"
# install git
brew install git
brew install python@3.10
# install pip
curl https://bootstrap.pypa.io/pip/get-pip.py -o get-pip.py
python3 get-pip.py --user
sudo ln -sf ~/Library/Python/3.10/bin/pip /usr/local/bin/pip
# install ansible
pip3 install --user ansible
sudo ln -sf ~/Library/Python/3.10/bin/ansible* /usr/local/bin/

installdir="/tmp/setup-my-mac-$RANDOM"
mkdir $installdir

git clone https://github.com/pratikbhawsar26/setup-my-mac.git $installdir 
if [ ! -d $installdir ]; then
    echo "Failed to find setup-my-mac."
    echo "git clone failed"
    exit 1
else
    cd $installdir 
    ansible-playbook -i ./hosts playbook.yml --verbose
fi

echo "Cleaning up..."

rm -Rfv /tmp/$installdir

echo "Voila! We are done!"
