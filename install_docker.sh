# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true

# Update package information, ensure that APT works with the https method, and that CA certificates are installed.
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates

# Add the new GPG key.
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Add an entry for your Ubuntu operating system.
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list

# Update the APT package index.
sudo apt-get update

# Verify that APT is pulling from the right repository.
apt-cache policy docker-engine

# Update your APT package index.
sudo apt-get update

# Install the recommended packages.
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual

# Install Docker.
sudo apt-get install -y docker-engine

# Add your user to docker group.
sudo usermod -aG docker $(whoami)

# Start the docker daemon.
#sudo service docker start

# Adjust memory and swap accounting
#sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"/GRUB_CMDLINE_LINUX_DEFAULT=\"\1 net.ifnames=0 biosdevname=0\"/" /etc/default/grub
#sudo sed -i "s/GRUB_CMDLINE_LINUX=\"\(.*\)\"/GRUB_CMDLINE_LINUX=\"\1 net.ifnames=0 biosdevname=0\"/" /etc/default/grub
#GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"
#sudo update-grub

# Configure a DNS server for use by Docker
#sudo sed -i "s/#DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"/DOCKER_OPTS="-g /data/docker/temp"/g" /etc/default/docker
#sudo service docker restart

# Install docker-compose
sudo apt-get install -y curl
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/1.8.0/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

# Install docker-cleanup command
cd /tmp
git clone https://gist.github.com/76b450a0c986e576e98b.git
cd 76b450a0c986e576e98b
sudo mv docker-cleanup /usr/local/bin/
sudo chmod +x /usr/local/bin/docker-cleanup
sudo rm -rf /tmp/76b450a0c986e576e98b

# Install make
sudo apt-get install -y make