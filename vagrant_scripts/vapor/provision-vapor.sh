#!/bin/bash
set -e

eval "$(curl -sL https://apt.vapor.sh)"
apt-get install -y swift vapor