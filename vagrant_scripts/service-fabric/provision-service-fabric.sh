#!/bin/bash
set -e

# Install Yomen
npm install -g yo

# Install Java
apt-get -y install software-properties-common python-software-properties
export DEBIAN_FRONTEND="noninteractive"
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
add-apt-repository -y ppa:webupd8team/java
apt-get -y update
apt-get -y install oracle-java8-installer

# Install Azure CLI
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" | tee /etc/apt/sources.list.d/azure-cli.list
apt-key adv --keyserver packages.microsoft.com --recv-keys 417A0893
apt-get -y update
apt-get -y install azure-cli
npm install -g azure-cli
azure --completion >> /etc/profile.d/azure.completion.sh
echo "source /etc/profile.d/azure.completion.sh" >> /etc/profile.d/environment.sh

# Install Service Fabric and dotnet repos
echo "deb [arch=amd64] http://apt-mo.trafficmanager.net/repos/servicefabric/ trusty main" > /etc/apt/sources.list.d/servicefabric.list
echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > /etc/apt/sources.list.d/dotnetdev.list
apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893

# Setup docker repos
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -y update

# Install Service Fabric SDK and setup everything
echo "servicefabric servicefabric/accepted-eula-v1 select true" | debconf-set-selections
echo "servicefabricsdkcommon servicefabricsdkcommon/accepted-eula-v1 select true" | debconf-set-selections
apt-get -y install servicefabric servicefabricsdkcommon servicefabricsdkcsharp servicefabricsdkjava
/opt/microsoft/sdk/servicefabric/common/sdkcommonsetup.sh
/opt/microsoft/sdk/servicefabric/common/clustersetup/devclustersetup.sh
/opt/microsoft/sdk/servicefabric/csharp/sdkcsharpsetup.sh
/opt/microsoft/sdk/servicefabric/java/sdkjavasetup.sh
/opt/microsoft/sdk/servicefabric/common/clustersetup/devclustersetup.sh

