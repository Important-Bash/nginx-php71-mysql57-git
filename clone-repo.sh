#!/bin/bash
sudo chown -R www-data:www-data /var/www/html || exit
cd /var/www/ || exit
sudo -Hu www-data git clone git@github.com:Enorion/se-data.git html || exit
