#!/usr/bin/env bash

# Install docker
wget -qO- https://get.docker.com/ | sh

# Update packages
apt-get update

# Configure docker proxy with systemd
mkdir /etc/systemd/system/docker.service.d
#cat > /etc/systemd/system/docker.service.d/http-proxy.conf <<EOF
#[Service]
#Environment="HTTP_PROXY=http://web-proxy.com:8080/" "NO_PROXY=localhost,127.0.0.0/8"
#EOF

# Restart docker daemon
systemctl daemon-reload

#Let vagrant use docker without sudo commands
sudo groupadd docker
sudo gpasswd -a vagrant docker

# Reload docker service to pickup docker configuration
systemctl restart docker

# Install docker-compose
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/1.7.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Install Open-JDK Java 8
sudo apt-get -y install openjdk-8-jre openjdk-8-jdk

# Set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Install Maven3
wget http://www.gtlib.gatech.edu/pub/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar -zxf apache-maven-3.0.5-bin.tar.gz
cp -R apache-maven-3.0.5 /usr/local/
ln -s /usr/local/apache-maven-3.0.5/bin/mvn  /usr/bin/mvn