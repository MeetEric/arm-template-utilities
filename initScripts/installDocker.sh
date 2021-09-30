# Docker installation script for Ubuntu 16.04 (Xenial) on Azure
# Usage: execute sudo -i, first.
# wget -q -O - "$@" https://gist.github.com/catataw/63044e79c3cfa20198408130ba52e110/raw/ --no-cache | sh
# After running the script reboot and check whether docker is running.
export DEBIAN_FRONTEND=noninteractive 

DOCKER_RESULT=1
DOCKER_COMPOSE_VERSION=v2.0.0

while [ $DOCKER_RESULT -ne 0 ]; do
  echo "#################################################"
  echo "  Updating System"
  echo "#################################################"
  apt-get update -y
  apt-get upgrade -y
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

  echo "#################################################"
  echo "  Update and Install Docker"
  echo "#################################################"
  
  apt-get update -y
  apt-get update
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
  
  which docker
  DOCKER_RESULT=$?
  echo "#################################################"
  echo "  Docker install result ${DOCKER_RESULT}"
  echo "#################################################"
done