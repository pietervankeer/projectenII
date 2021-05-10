#! /bin/bash
#
# Provisioning script for srv001

#------------------------------------------------------------------------------
# Bash settings
#------------------------------------------------------------------------------

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands

#------------------------------------------------------------------------------
# Variables
#------------------------------------------------------------------------------

# Location of provisioning scripts and files
export readonly PROVISIONING_SCRIPTS="/vagrant/provisioning/"
# Location of files to be copied to this server
export readonly PROVISIONING_FILES="${PROVISIONING_SCRIPTS}/files/${HOSTNAME}"


#------------------------------------------------------------------------------
# "Imports"
#------------------------------------------------------------------------------

# Utility functions
source ${PROVISIONING_SCRIPTS}/util.sh
# Actions/settings common to all servers
source ${PROVISIONING_SCRIPTS}/common.sh
# Config file
source ${PROVISIONING_SCRIPTS}/server.conf

#------------------------------------------------------------------------------
# Provision server
#------------------------------------------------------------------------------

log "Starting server specific provisioning tasks on ${HOSTNAME}"

# TODO: insert code here, e.g. install Apache, add users (see the provided
# functions in utils.sh), etc.

log "Create user"

ensure_user_exists bert
assign_groups bert wheel




#------------------------------------------------------------------------------
# LAMP Installation
#------------------------------------------------------------------------------
log "============================="
log "===== LAMP Installation ====="
log "============================="


#------------------------------------------------------------------------------
# Packages
#------------------------------------------------------------------------------
log "===== Packages ====="

# Apache
yum -y install httpd
log "Apache installed"

# MariaDB
yum -y install mariadb-server
log "MariaDB installed"

# PHP
yum -y module reset php
yum -y module enable php:7.4
yum -y install php php-mysqlnd
log "PHP installed"

# mod_ssl and openssl (https)
yum -y install mod_ssl openssl
log "mod_ssl installed"


#------------------------------------------------------------------------------
# Services
#------------------------------------------------------------------------------
log "===== Services ====="

# Apache
systemctl enable --now httpd
log "Apache enabled"

# MariaDB
systemctl enable --now mariadb
log "MariaDB enabled"

# Firewall
systemctl enable --now firewalld
log "Firewall enabled"


#------------------------------------------------------------------------------
# Security
#------------------------------------------------------------------------------
log "===== Security ====="

# Firewall
firewall-cmd --add-service ssh --permanent
firewall-cmd --add-service http --permanent
firewall-cmd --add-service https --permanent
firewall-cmd --reload
log "Firewall configured"

# SELinux
setenforce 1
sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config
log "SELinus set to enforcing"

# HTTPS
## Generate ssl key and certificate
openssl req -newkey rsa:2048 -nodes -keyout /etc/pki/tls/private/httpd.key -x509 -days 365 -out /etc/pki/tls/certs/httpd.crt -subj "/C=BE/ST=W-F/L=Gent/O=Hogent/OU=TI/CN=webserver"
## Replace placeholder key and certificate
sed -i "s/localhost/httpd/g" /etc/httpd/conf.d/ssl.conf
## Reload service
systemctl restart httpd
log "HTTPS configured"


#------------------------------------------------------------------------------
# Database Configuration
#------------------------------------------------------------------------------
log "===== Database Configuration ====="

db_credentials="--user=root --password=${mariadb_root_password}"

# Usage: execute_query QUERY
#
# Executes query as root user
execute_query() {
    local query=${1}
    mysql ${db_credentials} -e "${query}"
}


# Set root password
if is_mysql_root_password_set; then
    log "Root password is already set!"
else
    mysqladmin --user=root password $mariadb_root_password
    log "Root password set"
fi

# Delete anonymous users
execute_query "DELETE FROM mysql.user WHERE User='';"
log "Anonymous users deleted"

# Disable remote root login
execute_query "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
log "Remote root login disabled"


# Remove the test database
execute_query "DROP DATABASE IF EXISTS test;"
execute_query "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
log "Test database dropped"


# Flush privileges table
execute_query "FLUSH PRIVILEGES;"
log "Privileges flushed"

log "MariaDB configured"




#------------------------------------------------------------------------------
# Web Application Installation
#------------------------------------------------------------------------------
source ${PROVISIONING_SCRIPTS}/webapp_install.sh

#------------------------------------------------------------------------------
# Installation Cockpit
#------------------------------------------------------------------------------

log "===== Cockpit ====="

# Install Cockpit
dnf install cockpit -y
log "Cockpit installed"

# Enable Cockpit
systemctl start cockpit.socket
systemctl enable cockpit.socket
log "Cockpit started"

# Open firewall
firewall-cmd --permanent --add-service=cockpit
firewall-cmd --reload
log "Cockpit added to firewall"