#!/bin/bash

BASHRC=$1
PROMPT=$2
PUBLIC_DIR=$3

cat /etc/skel/.bashrc > ${BASHRC}

echo "Writing to ${USER} .bashrc..."
sudo echo ""
sudo echo "### SCRIPT AUTOMATATICALLY - WRITTEN to .bashrc" >> ${BASHRC}
sudo printf "\n" >> ${BASHRC}

sudo echo "## SHELL CONFIGURATION for USER_ACCOUNT" >> ${BASHRC}
sudo echo  ${PROMPT} >> ${BASHRC}
sudo printf "\n" >> ${BASHRC}

sudo echo "## EMACS ALIASING" >> ${BASHRC}
sudo echo "alias emacs=\"emacs -nw\"" >> ${BASHRC}
sudo echo "\n" >> ${BASHRC}

sudo echo "## Terminal Message" >> ${BASHRC}
sudo echo "toilet \"ml.sftwrs\" --gay" >> ${BASHRC}
sudo echo "cat ${PUBLIC_DIR}/ml.message" >> ${BASHRC}
sudo printf "\n" >> ${BASHRC}

echo "You should manually review the ${USER}'s .bashrc for inconsistencies..."

sleep 2
