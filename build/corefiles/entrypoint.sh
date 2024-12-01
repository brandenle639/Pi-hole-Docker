#!/bin/bash
if [ ! -f /etc/pihole/setupVars.conf ]; then
    cp /corefiles/setupVarsdefault.conf /etc/pihole/setupVars.conf
    recon="yes"
fi

if grep -Fxq "WEBPASSWORD" /etc/pihole/setupVars.conf
then
    echo "Web Password Already Set"
elif [[ "$WEBPASSWORD" =~ ^[0-9a-f]{64}$ ]]; then
  #echo "Valid SHA-256 hash"
  #sed '4s/.*/new text/' /corefiles/setupVarsdefault.conf > /etc/pihole/setupVars.conf
  sudo chmod 777 /etc/pihole/setupVars.conf
  ln=$(awk '/WEBPASSWORD/{ print NR; exit }' /etc/pihole/setupVars.conf)
  sed "$ln s/.*/WEBPASSWORD=$WEBPASSWORD/" /corefiles/setupVarsdefault.conf > /etc/pihole/setupVars.conf
elif [ ! "$WEBPASSWORD" = "" ]; then
    sudo pihole -a -p $WEBPASSWORD
fi

if ! grep -Fxq "LOCAL_IPV4" /etc/pihole/pihole-FTL.conf
then
 echo "#; Pi-hole FTL config file" > /etc/pihole/pihole-FTL.conf
 echo "#; Comments should start with #; to avoid issues with PHP and bash reading this file" >> /etc/pihole/pihole-FTL.conf
 echo "MACVENDORDB=/macvendor.db" >> /etc/pihole/pihole-FTL.conf
 echo "LOCAL_IPV4=$(ip -4 addr show eth0 | grep -oP 'inet \K[\d.]+')" >> /etc/pihole/pihole-FTL.conf
fi

if [ "$recon" = "yes" ]; then
 /corefiles/basic-install-{Version Number}.sh --unattended
fi

sudo service pihole-FTL start
sudo service lighttpd start
bash
