#!/bin/bash

### TERMINAL CONFIGURATION ###
XT_SIZE=$((($1-1)/2))
XT_HEIGHT=$2
SC_WIDTH=$(xwininfo -root | grep "Width" | grep -o "[0-9]*")
SC_HEIGHT=$(xwininfo -root | grep "Height" | grep -o "[0-9]*")
_CONFIG_=""
AUTO_CONFIG=/home/${USER}/.config/autostart

## Clean up current config
if [ ! -d ${AUTO_CONFIG} ];
then
    mkdir ${AUTO_CONFIG}
else
    rm ${AUTO_CONFIG}/*
fi

read -p "Enter number of terminal x-window for ${USER}[2,3]: " TERM_NUMBER
while [ ${TERM_NUMBER} -lt 2 ] || [ ${TERM_NUMBER} -gt 3 ];
do
    echo "Invalid number entered... Choose between [2,3]"
    read -p "[2,3]: " TERM_NUMBER
done

_CONFIG_=""
if [ ${TERM_NUMBER} -eq 3 ];
then
    _CONFIG_="${XT_SIZE}x${XT_HEIGHT}+0+0"
    _CONFIG_="${_CONFIG_} ${XT_SIZE}x$(($XT_HEIGHT/2))+$((($SC_WIDTH)/2))+0"
    _CONFIG_="${_CONFIG_} ${XT_SIZE}x$(($XT_HEIGHT/2))+$(($SC_WIDTH/2))+$(($SC_HEIGHT/2))"
fi

if [ ${TERM_NUMBER} -eq 2 ];
then
    _CONFIG_="${XT_SIZE}x${XT_HEIGHT}+0+0 ${XT_SIZE}x${XT_HEIGHT}+$(($SC_WIDTH/2))+0"
fi

get_terminal_config() {
    TERMS=$(printf "%s\n%s\n%s\n" "[Desktop Entry]" "Type=Application" "Exec=xterm -geometry $1")
    TERMS=$(printf "%s\n%s\n" "${TERMS}" "Hidden=false")
    TERMS=$(printf "%s\n%s\n%s\n" "${TERMS}" "NoDisplay=false" "X-GNOME-Autostart-enabled=true")
    TERMS=$(printf "%s\n%s\n%s\n" "${TERMS}" "Name[en_NG]=Terminal $2" "Name=Terminal $2")
    TERMS=$(printf "%s\n%s\n%s\n" "${TERMS}" "Comment[en_NG]=Terminal" "Commment=Initialize Terminals")
    printf "%s" "${TERMS}"
}

count=0
for i in ${_CONFIG_};
do
    get_terminal_config ${i} "Terminal_${count}" > ${AUTO_CONFIG}/terminal${count}.desktop
    count=$(($count+1))
done

### XAUTOLOCK ###
xc="xautolock -time 5 -locker 'i3lock -e -i /var/public/mlsftwrs/mlsftwrs_back.png -p default -n'"
get_lock_config() {
    FORMAT=$(printf "%s\n%s\n%s\n" "[Desktop Entry]" "Name=ScreenLocker" "Type=Application")
    FORMAT=$(printf "%s\n%s\n%s\n" "${FORMAT}" "Exec=${xc}" "Terminal=false")
    printf "%s\n" "${FORMAT}"
}

get_lock_config > ${AUTO_CONFIG}/i3lock.desktop

echo "look in ~/.config/autostart/ to manually customize..."
