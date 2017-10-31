######################################################
# Purpose - Script to provision Kubernetes mster
#           and minion machines
#
######################################################

echo 'Starting provisioning on machine: '`hostname`

# Update the repository
sudo yum update -y

# Install necessary packages
sudo yum install vim git wget curl ntp \
    yum-utils device-mapper-persistent-data lvm2 epel-release -y

# Update repostiry again after installing epel-release
sudo yum update -y

# Install and configure avahi daemon and nss-mdns to configure mdns
sudo yum install avahi nss-mdns -y
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon

# # Install and configure docker
# sudo yum-config-manager \
#     --add-repo \
#     https://download.docker.com/linux/centos/docker-ce.repo

# sudo yum update -y

yum -y install docker-ce kubernetes etcd
sudo groupadd docker
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl start docker

# Configure ntpd service
sudo systemctl enable ntpd
sudo systemctl start ntpd

echo 'Provisioning completed on machine: '`hostname`
