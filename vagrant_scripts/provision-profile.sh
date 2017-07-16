#!/usr/bin/env bash

mkdir -p /etc/profile.d

echo "" > /etc/profile.d/environment.sh
echo "export PATH=/usr/local/ansible-repo/bin:/vagrant/bin:$PATH" >> /etc/profile.d/environment.sh
echo "export PYTHONPATH=/usr/local/ansible-repo/lib:/vagrant/library:$PYTHONPATH" >> /etc/profile.d/environment.sh
echo "export ANSIBLE_CONFIG=/vagrant/ansible.cfg" >> /etc/profile.d/environment.sh
echo "alias dir='ls -la'" >> /etc/profile.d/environment.sh
echo "cd /vagrant" >> /etc/profile.d/environment.sh
chmod +x /etc/profile.d/environment.sh
