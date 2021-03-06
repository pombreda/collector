#!/bin/bash

set -x
set -e

apt-get install --quiet cython git git-core > /dev/null
pip install --quiet --upgrade pip

wget https://launchpad.net/meliae/trunk/0.4/+download/meliae-0.4.0.tar.gz
tar -zxpvf meliae-0.4.0.tar.gz
cd meliae-0.4.0/
python setup.py install
cd ..

# Install yappi
sudo pip install --upgrade yappi

if [ -d "w3af" ]; then
  cd w3af
  git pull
else
  git clone --quiet https://github.com/andresriancho/w3af.git
  cd w3af
fi

# Checkout the collector-specified version
git checkout $VERSION

# This will generate the installation script
python -c "from w3af.core.controllers.dependency_check.dependency_check import dependency_check;dependency_check()" || true
/tmp/w3af_dependency_install.sh


