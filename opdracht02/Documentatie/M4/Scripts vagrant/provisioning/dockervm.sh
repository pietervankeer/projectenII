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

#------------------------------------------------------------------------------
# Provision server
#------------------------------------------------------------------------------

log "Starting server specific provisioning tasks on ${HOSTNAME}"


# TODO: insert code here, e.g. install Apache, add users (see the provided
# functions in utils.sh), etc.
#------------------------------------------------------------------------------
# Installation Cockpit
#------------------------------------------------------------------------------

log "===== Cockpit ====="

# Install Cockpit
apt-get install cockpit -y
log "Cockpit installed"

# Enable Cockpit
systemctl start cockpit.socket
systemctl enable cockpit.socket
log "Cockpit started"

# Open firewall
# firewall-cmd --permanent --add-service=cockpit
# firewall-cmd --reload
# log "Cockpit added to firewall"