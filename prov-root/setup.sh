echo "### SETUP PACKAGES ############################################"

set -x
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y upgrade
apt-get -y install $(<packages.list)
set +x

echo "### COPY SYSTEM FILES #########################################"

set -x
rsync -av files/ /
set +x

echo "### SETUP WEBSERVER ###########################################"

set -x
a2ensite nextcloud
a2dissite 000-default
a2enmod rewrite
a2enmod headers
a2enmod env
a2enmod dir
a2enmod mime
a2enmod ssl
systemctl restart apache2
set +x

echo "### SETUP DATABASE ############################################"

set -x
mysql -e "CREATE USER IF NOT EXISTS 'vagrant'@'localhost' IDENTIFIED BY 'vagrant'"
mysql -e "CREATE DATABASE IF NOT EXISTS nextcloud"
mysql -e "GRANT ALL ON nextcloud.* TO 'vagrant'@'localhost'"
set +x
