#! /bin/bash


#------------------------------------------------------------------------------
# Web Application Installation
#------------------------------------------------------------------------------
log "================================"
log "===== Web App Installation ====="
log "================================"


#------------------------------------------------------------------------------
# Wordpress Database
#------------------------------------------------------------------------------
log "===== Wordpress Database ====="

# Create new database
execute_query "CREATE DATABASE ${mariadb_db_name};"
log "New database '${mariadb_db_name}' created"

# Create new user
execute_query "CREATE USER '${mariadb_username}'@'localhost' IDENTIFIED BY '${mariadb_password}';"
log "New user '${mariadb_username}' created"

# Grant all privileges
execute_query "GRANT ALL ON ${mariadb_db_name}.* TO '${mariadb_username}'@'localhost';" 
log "User '${mariadb_username}' granted all privileges"

# Flush privileges
execute_query "FLUSH PRIVILEGES;"
log "Privileges flushed"


#------------------------------------------------------------------------------
# Wordpress Installation 
#------------------------------------------------------------------------------
log "===== Wordpress Installation ====="

# Usage: get_new_keys_and_salts
#
# Replaces current keys and salts in wp-config.php with newly generated ones
get_new_keys_and_salts() {

    # Download new salts
    curl -L -o salts "https://api.wordpress.org/secret-key/1.1/salt/"

    # Split wp-config.php into 3 on the first and last definition statements
    csplit wp-config.php '/AUTH_KEY/' '/NONCE_SALT/+1'

    # Recombine the first part, the new salts and the last part
    cat xx00 salts xx02 > wp-config.php

    # Tidy up
    rm salts xx00 xx01 xx02
}


# Download Wordpress
log "Downloading Wordpress"
curl -L -o /tmp/wordpress.tar.gz  https://wordpress.org/latest.tar.gz

# Unpack Wordpress in /var/www/html/
log "Unpacking Wordpress"
tar -xzf /tmp/wordpress.tar.gz -C /var/www/html/

# Configure Wordpress
log "Configuring Wordpress"
cd /var/www/html/wordpress/

# Rename config-sample
mv wp-config-sample.php wp-config.php

# Fill in DB credentials
sed -i "s/database_name_here/${mariadb_db_name}/" wp-config.php
sed -i "s/username_here/${mariadb_username}/" wp-config.php
sed -i "s/password_here/${mariadb_password}/" wp-config.php

# Get new keys and salts
get_new_keys_and_salts

# Set permissions
chmod -R 775 /var/www/html/wordpress/

# Set owner (apache)
chown -R apache:apache /var/www/html/wordpress/

log "Wordpress up and running"