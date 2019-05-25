#!/bin/bash
#
# Unlicensed ml.sftwrs 2019 
#
# 
# Script to Automate ml.sftwrs nodes configuration(Debian only - script)
# To be updated for Arch | Server Env.| Support Env. | Front-End Env.
# PXE helper Script
#

ML_PUBLIC=/var/public
PUBLIC_DIR=${ML_PUBLIC}/mlsftwrs
GITHUB_REPO="https://raw.githubusercontent.com/mlsftwrsteam/ml-dev-nodes/master/res"
STATUS_FMT="\e[31m"
NOTIFY_FMT="\e[34m"
NORMAL_FMT="\e[0m"


### Create 'mlsftwrs' public dir in var ###
if [ -d "${PUBLIC_DIR}" ];
then
    echo "${PUBLIC_DIR} exists already..."
else
    echo "Creating a public dir in /var/..."
    if [ -d "${ML_PUBLIC}" ];
    then
        sudo mkdir ${PUBLIC_DIR}
    else
        sudo mkdir ${ML_PUBLIC} && sudo mkdir ${PUBLIC_DIR}
    fi
    echo "/var/public/mlsftwrs/ has been created."
fi


### Dowload res files from the repo ###
RES_FILES="dev_install.txt mongo_install.sh generate_wlc.sh write_bashrc.sh auto_start.sh mlsftwrs_back.png prompt"
for i in ${RES_FILES};
do
    if [ ! -f ${PUBLIC_DIR}/${i} ];
    then
        sudo wget -P ${PUBLIC_DIR} ${GITHUB_REPO}/${i}
    fi
done


### Install Required Packages ###
packages=""
for i in $(cat ${PUBLIC_DIR}/dev_install.txt); # TODO: cat dev_install.txt
do
    packages+="${i} "
done

####### Debian based only #### TODO: update later for other package managers
sudo apt install -y ${packages}

sleep 2


### Maximize ACTIVE WINDOW ###
#TODO: xdotool for non debian & acurate config
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz


#### MONGO DB INSTALLATION ####
bash ${PUBLIC_DIR}/mongo_install.sh


### BASHRC MODIFICATION ###
BASHRC=${HOME}/.bashrc
bash ${PUBLIC_DIR}/generate_wlc.sh
bash ${PUBLIC_DIR}/write_bashrc.sh ${BASHRC} ${PROMPT} ${PUBLIC_DIR}


### AUTOSTART : Terminal WKSTATIONS setups & i3lock(5minutes) ####
TERM_LINES=$(tput lines)
TERM_COLS=$(tput cols)
bash ${PUBLIC_DIR}/auto_start.sh ${TERM_COLS} ${TERM_LINES}


### THEMES CONFIGURATION: GNOME && GTK ENVIRONMENT ONLY ###
cd ~
THEME_SRC_GTK="https://github.com/daniruiz/flat-remix-gtk/archive/master.zip"
THEME_SRC="https://github.com/daniruiz/flat-remix/archive/master.zip"


set_themes(){
    mkdir ./temp
    cd ./temp/
    wget $1
    unzip -q master.zip
    cd $2
    all_t=$(ls -d */ | grep "^Flat-" | sed 's/\///')
    if [ $3 -eq 0 ];
    then
        for i in ${all_t};
        do
            sudo cp -r ${i} /usr/share/icons/
        done
    else
        for i in ${all_t};
        do
            sudo cp -r ${i} /usr/share/themes/
        done
    fi
    cd ./../../
    rm -rf ./temp
}

set_themes ${THEME_SRC} flat-remix-master 0
set_themes ${THEME_SRC_GTK} flat-remix-gtk-master 1
if [ -d "~/temp" ];
then
    rm -rf ~/temp
fi

#Cursor Installation
sudo add-apt-repository ppa:starlabs/ppa
sudo apt update
sudo apt install starlabs-cursor-theme -y

### TODO: GIT CONFIG: TO BE CUSTOMIZED FOR USER SPECIFICI ###
git config --global user.name "ml.sftwrs developer"
git config --global user.email "dev@mlsftwrs.ml"
git config --global core.editor emacs

sudo apt-get autoremove
echo "Configuration completed!"

#reboot
