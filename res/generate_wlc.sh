# ml.sftwrs 2019 - 
#
#
#!/bin/bash

BLUE=$'\e[34m'
GREEN=$'\e[32m'
RED=$'\e[31m'
YELLOW=$'\e[33m'
FILE_SRC=/var/public/mlsftwrs/ml.message


### CREATE public_dirs if does not exists

sudo printf "%s\n" "${YELLOW}\"${GREEN}In the complexities of contemporary existence the specialist" > ${FILE_SRC}
sudo printf "%s\n" "${YELLOW}who is trained but uneducated, technically skilled but culturally" >> ${FILE_SRC}
sudo printf "%s\n" "${RED}incompetent is a menace.${YELLOW}\"" >> ${FILE_SRC}
sudo printf "%35s\n\n" "- ${BLUE}Unknown" >> ${FILE_SRC}


sudo printf "\n%s\n" "${YELLOW}This is a ml.sftwrs terminal." >> ${FILE_SRC}

sudo printf "\n%s\n" "${GREEN}Welcome ${RED}${USER}${GREEN}! Proceed with caution..." >> ${FILE_SRC}
sudo printf "%s\n" "Beware; Systems Admins are lurking around. They are tracking sessions." >> ${FILE_SRC}
sudo printf "%s\n\n" "You have been warned!" >> ${FILE_SRC}

sudo printf "%s\n\n\n\n" "${RED}>${BLUE} 'With great power comes great responsibility'" >> ${FILE_SRC}

sudo printf "%s" "${RED}>>> ${BLUE} ml${GREEN}.${BLUE}sf${YELLOW}t${BLUE}wr${RED}s ${BLUE} terminal 2019" >> ${FILE_SRC}
sudo printf "%s\n\n" " ${RED} <<<" >> ${FILE_SRC}
