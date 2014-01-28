#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
echo "This script will REMOVE the IFMI web interface upgrade to BAMT."
read -p "Are you sure?(y/n)" input
shopt -s nocasematch
case "$input" in
  y|Y|Yes)
  if [! -e /var/www/IFMI ]; then
          echo "IFMI not installed"
          exit 1 ;;
  else
    mv /var/www/favicon.ico /var/www/IFMI/favicon.ico.ifmi
    mv /var/www/favicon.ico.bamt /var/www/favicon.ico
    mv /var/www/bamt/status.css /var/www/IFMI/status.css.ifmi
    mv /var/www/bamt/status.css.bamt /var/www/bamt/status.css
    mv /usr/lib/cgi-bin/status.pl /var/www/IFMI/status.pl.ifmi
    mv /usr/lib/cgi-bin/status.pl.bamt /usr/lib/cgi-bin/status.pl
    mv /usr/lib/cgi-bin/confedit.pl /var/www/IFMI/
    mv /usr/lib/cgi-bin/poolmanage.pl /var/www/IFMI/
    mv /opt/bamt/common.pl /var/www/IFMI/common.pl.ifmi
    mv /opt/bamt/common.pl.bamt /opt/bamt/common.pl 
    echo "Done!"
  fi ;;
  * ) echo "installation exited";;
esac