#!/bin/bash


## Variables ###############################

VERSION="7.6.1"
#VERSION="7.4.1"
IP=$(hostname -I | cut -d " " -f 2)

## Check root #############################

sudo -n true
if [ $? -ne 0 ]
    then
        echo "This script requires user to have passwordless sudo access"
        exit
fi


## functions #############################

dependency_check_deb() {
java -version
if [ $? -ne 0 ]
    then
        # Installing Java 7 if it's not installed
        sudo apt-get install openjdk-7-jre-headless -y
    # Checking if java installed is less than version 7. If yes, installing Java 7. As logstash & Elasticsearch require Java 7 or later.
    elif [ "`java -version 2> /tmp/version && awk '/version/ { gsub(/"/, "", $NF); print ( $NF < 1.7 ) ? "YES" : "NO" }' /tmp/version`" == "YES" ]
        then
            sudo apt-get install openjdk-7-jre-headless -y
fi
}

dependency_check_rpm() {
    java -version
    if [ $? -ne 0 ]
        then
				sudo yum install java-11-openjdk-headless.x86_64 -y
    fi
}

debian_elk() {
    sudo apt-get update
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.deb
    sudo dpkg -i /opt/logstash*.deb
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}-amd64.deb
    sudo dpkg -i /opt/elasticsearch*.deb
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-amd64.deb
    sudo dpkg -i /opt/kibana*.deb
    sudo service logstash start
    sudo service elasticsearch start
    sudo service kibana start
}

rpm_elk() {
    sudo yum install wget -y
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/logstash/logstash-${VERSION}.rpm
    sudo rpm -ivh /opt/logstash*.rpm
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}-x86_64.rpm
    sudo rpm -ivh /opt/elasticsearch*.rpm
    sudo wget --directory-prefix=/opt/ https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-x86_64.rpm
    sudo rpm -ivh /opt/kibana*.rpm
    sudo systemctl enable logstash
    sudo systemctl start logstash
    sudo systemctl enable elasticsearch
    sudo systemctl start elasticsearch
    sudo systemctl enable kibana
    sudo systemctl start kibana
}

vagrant_steps(){
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sed -i s/"#server.host: \"localhost\""/"server.host: \"0.0.0.0\""/g /etc/kibana/kibana.yml
sudo systemctl restart kibana
sed -i s/"#discovery.seed_hosts:".*/"discovery.seed_hosts: [\"${IP}\", \"127.0.0.1\"]"/g /etc/elasticsearch/elasticsearch.yml
sed -i s/"#network.host:".*/"network.host: 0.0.0.0"/g /etc/elasticsearch/elasticsearch.yml
sudo systemctl restart elasticsearch
}

## Exec ###############################################
if [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]
    then
        echo " It's a Debian based system"
        dependency_check_deb
        debian_elk
elif [ "$(grep -Ei 'fedora|redhat|centos' /etc/*release)" ]
    then
        echo "It's a RedHat based system."
        dependency_check_rpm
        rpm_elk
				vagrant_steps
else
    echo "This script doesn't support ELK installation on this OS."
fi
