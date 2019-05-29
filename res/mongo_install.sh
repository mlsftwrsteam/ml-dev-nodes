#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

sudo apt-get update

sudo apt-get install -y mongodb-org

echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

### MONGO-C-DRIVER INSTALLATION ###

CWD=$(pwd)
INS_DIR=mongoc_driver

mkdir ${CWD}/${INS_DIR}
cd ${CWD}/${INS_DIR}

git clone https://github.com/mongodb/mongo-c-driver.git
cd mongo-c-driver

python build/calc_release_version.py > VERSION_CURRENT
mkdir cmake-build
cd cmake-build

cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF ..
make
sudo make install

cd ${CWD} && rm -rf ${INS_DIR}
