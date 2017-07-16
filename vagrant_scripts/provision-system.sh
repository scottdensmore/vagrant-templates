#!/bin/bash
set -e

SCRIPT_PATH=${BASH_SOURCE[0]}
SCRIPT_PATH=$(cd -P $(dirname $SCRIPT_PATH) && pwd)

# Eliminate errors like 'stdin: is not a tty'
sed -i 's/^mesg n$/tty -s \&\& mesg n/' /root/.profile

# These are required for subsequent installs
apt-get -y update
apt-get -y install curl apt-transport-https build-essential libssl-dev software-properties-common python-software-properties

# Install tools
apt-get -y install git nano man jq vim dnsutils aptitude lynx

# Install npm (and dependencies)
# From: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
curl -sL https://deb.nodesource.com/setup_6.x | bash -
apt-get -y install nodejs
npm install npm@latest -g
npm update -g