#!/bin/bash
set -e

apt-get install -y clang libicu-dev libpython2.7-dev libcurl3

# install swift
cd ~
curl -O https://swift.org/builds/swift-3.1.1-release/ubuntu1604/swift-3.1.1-RELEASE/swift-3.1.1-RELEASE-ubuntu16.04.tar.gz
mkdir /usr/local/bin/swift
tar xzf swift-3.1.1-RELEASE-ubuntu16.04.tar.gz -C /usr/local/bin/swift --strip-components 1
echo "export PATH=/usr/local/bin/swift/usr/bin:$PATH" >> /etc/profile.d/environment.sh