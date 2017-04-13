#!/bin/bash
echo "*****************************************************";
echo "*****************************************************";
echo "************* Starting Installation *****************";
echo "*****************************************************";
echo "*****************************************************";

LG='\033[0;37m'
CLOSE='\033[0m'
echo "\n\n\n"
echo "${LG} Installing Nginx, PHP7.1, Mysql and Git. \n\n\n ${CLOSE}"

# install Nginx, PHP7.1 & apache2

apt-get install apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
apt-get update
apt-get install sudo
apt-get install mysql-server nginx php7.1 php7.1-mbstring php7.1-xml php7.1-pdo php7.1-mysql apache2 git || exit
# apt-get -y install libapache2-mod-rpaf

# nano /etc/apache2/ports.conf
# copy ports.conf file to apache configuration directory

#sudo cp ports.conf /etc/apache2/ports.conf
#sudo cp apache2.conf /etc/apache2/apache2.conf
#sudo cp 000-default.conf /etc/apache2/sites-enabled/000-default.conf

# copy nginx config

sudo cp default /etc/nginx/sites-available/default
ln /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
#sudo cp proxy_params /etc/nginx/proxy_params

# Install git
git config --global user.name "Enorion"
git config --global user.email "admin@enorion.de"

sudo mkdir /var/www/.ssh
sudo chown -R www-data:www-data /var/www/.ssh/
sudo -Hu www-data ssh-keygen -t rsa # choose "no passphrase"
sudo cat /var/www/.ssh/id_rsa.pub

sudo chown -R www-data:www-data /var/www/html
sudo -Hu www-data git clone git@github.com:Enorion/se-data.git /var/www/*

# Installing Firewall 
apt-get install ufw || echo "Installation Failed" && exit

sudo ufw allow 22/tcp
sudo ufw allow ssh
sudo ufw allow 'Nginx HTTP'

systemctl enable nginx.service
service nginx restart
service apache2 restart

sudo ufw status
sudo ufw app list
echo "here's your SSH key!"

sudo cat /var/www/.ssh/id_rsa.pub
