#!/bin/bash
set -e

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get -y update
apt-get install -y mongodb-org sysfsutils

# disable hugepages
echo "kernel/mm/transparent_hugepage/enabled = never" >> /etc/sysfs.conf
echo "kernel/mm/transparent_hugepage/defrag = never" >> /etc/sysfs.conf

# make sure we start on startup
echo "" > /etc/systemd/system/mongodb.service
echo "[Unit]" >> /etc/systemd/system/mongodb.service
echo "Description=High-performance, schema-free document-oriented database" >> /etc/systemd/system/mongodb.service
echo "After=network.target" >> /etc/systemd/system/mongodb.service
echo "" >> /etc/systemd/system/mongodb.service
echo "[Service]" >> /etc/systemd/system/mongodb.service
echo "User=mongodb" >> /etc/systemd/system/mongodb.service
echo "ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf" >> /etc/systemd/system/mongodb.service
echo "" >> /etc/systemd/system/mongodb.service
echo "[Install]" >> /etc/systemd/system/mongodb.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/mongodb.service

# disable hugepages
# echo "" > /etc/init.d/disable-transparent-hugepages
# echo "#!/bin/bash" >> /etc/init.d/disable-transparent-hugepages
# echo "### BEGIN INIT INFO" >> /etc/init.d/disable-transparent-hugepages 
# echo "# Provides:          disable-transparent-hugepages" >> /etc/init.d/disable-transparent-hugepages
# echo "# Required-Start:    \$local_fs" >> /etc/init.d/disable-transparent-hugepages
# echo "# Required-Stop:" >> /etc/init.d/disable-transparent-hugepages
# echo "# X-Start-Before:    mongod mongodb-mms-automation-agent" >> /etc/init.d/disable-transparent-hugepages
# echo "# Default-Start:     2 3 4 5" >> /etc/init.d/disable-transparent-hugepages
# echo "# Default-Stop:      0 1 6" >> /etc/init.d/disable-transparent-hugepages
# echo "# Short-Description: Disable Linux transparent huge pages" >> /etc/init.d/disable-transparent-hugepages
# echo "# Description:       Disable Linux transparent huge pages, to improve" >> /etc/init.d/disable-transparent-hugepages
# echo "#                    database performance." >> /etc/init.d/disable-transparent-hugepages
# echo "### END INIT INFO" >> /etc/init.d/disable-transparent-hugepages

# echo "case \$1 in" >> /etc/init.d/disable-transparent-hugepages
# echo "  start)" >> /etc/init.d/disable-transparent-hugepages
# echo "   if [ -d /sys/kernel/mm/transparent_hugepage ]; then" >> /etc/init.d/disable-transparent-hugepages
# echo "     thp_path=/sys/kernel/mm/transparent_hugepage" >> /etc/init.d/disable-transparent-hugepages
# echo "   elif [ -d /sys/kernel/mm/redhat_transparent_hugepage ]; then" >> /etc/init.d/disable-transparent-hugepages
# echo "     thp_path=/sys/kernel/mm/redhat_transparent_hugepage" >> /etc/init.d/disable-transparent-hugepages
# echo "   else" >> /etc/init.d/disable-transparent-hugepages
# echo "     return 0" >> /etc/init.d/disable-transparent-hugepages
# echo "   fi" >> /etc/init.d/disable-transparent-hugepages
# echo "" >> /etc/init.d/disable-transparent-hugepages
# echo "   echo 'never' > \${thp_path}/enabled" >> /etc/init.d/disable-transparent-hugepages
# echo "   echo 'never' > \${thp_path}/defrag" >> /etc/init.d/disable-transparent-hugepages
# echo "" >> /etc/init.d/disable-transparent-hugepages
# echo "   re='^[0-1]+$'" >> /etc/init.d/disable-transparent-hugepages
# echo "   if [[ \$(cat \${thp_path}/khugepaged/defrag) =~ \$re ]]" >> /etc/init.d/disable-transparent-hugepages
# echo "   then" >> /etc/init.d/disable-transparent-hugepages
# echo "     # RHEL 7" >> /etc/init.d/disable-transparent-hugepages
# echo "     echo 0  > \${thp_path}/khugepaged/defrag" >> /etc/init.d/disable-transparent-hugepages
# echo "   else" >> /etc/init.d/disable-transparent-hugepages
# echo "     # RHEL 6" >> /etc/init.d/disable-transparent-hugepages
# echo "     echo 'no' > \${thp_path}/khugepaged/defrag" >> /etc/init.d/disable-transparent-hugepages
# echo "   fi" >> /etc/init.d/disable-transparent-hugepages
# echo "" >> /etc/init.d/disable-transparent-hugepages
# echo "   unset re" >> /etc/init.d/disable-transparent-hugepages
# echo "   unset thp_path" >> /etc/init.d/disable-transparent-hugepages
# echo "   ;;" >> /etc/init.d/disable-transparent-hugepages
# echo "esac" >> /etc/init.d/disable-transparent-hugepages

# chmod 755 /etc/init.d/disable-transparent-hugepages
# update-rc.d disable-transparent-hugepages defaults
# make sure we can bind to any ip
sed -e '/bindIp/ s/^#*/#/' -i /etc/mongod.conf

systemctl start mongodb
systemctl enable mongodb