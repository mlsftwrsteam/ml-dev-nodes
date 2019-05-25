#!/bin/bash

BASHRC=$1
PROMPT=$2
PUBLIC_DIR=$3

cat /etc/skel/.bashrc > ${BASHRC}

echo "Writing to ${USER} .bashrc..."
echo "### SCRIPT AUTOMATATICALLY - WRITTEN to .bashrc" >> ${BASHRC}
printf "\n" >> ${BASHRC}

echo "## SHELL CONFIGURATION for USER_ACCOUNT" >> ${BASHRC}
echo  ${PROMPT} >> ${BASHRC}
printf "\n" >> ${BASHRC}

echo "## EMACS ALIASING" >> ${BASHRC}
echo "alias emacs=\"emacs -nw\"" >> ${BASHRC}
echo "\n" >> ${BASHRC}

echo "## Terminal Message" >> ${BASHRC}
echo "toilet \"ml.sftwrs\" --gay" >> ${BASHRC}
echo "cat ${PUBLIC_DIR}/ml.message" >> ${BASHRC}
printf "\n" >> ${BASHRC}

echo "You should manually review the ${USER}'s .bashrc for inconsistencies..."

sleep 2
