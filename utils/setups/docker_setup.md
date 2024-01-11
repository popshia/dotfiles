# Docker Dependencies Setup
- __Description:__ set up docker dependencies
- __Author:__ Noah Lin
- __Contact:__ noah@c-link.com.tw
- __Date:__ 2024-01-10

# Table of Contents
1. [Install nvidia drivers](#install-nvidia-drivers)
2. [Install docker](#install-docker)
3. [Setup docker permissions](#setup-docker-permissions)
4. [Install nvidia-docker](#install-nvidia-docker)
5. [Test](#test)
6. [Install VNC](#install-vnc)
7. [Make image](#make-image)
8. [IP settings](#ip-settings)

## Install nvidia drivers
```bash
# check
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt install ubuntu-drivers-common
# check device drivers
ubuntu-drivers devices
# auto install drivers
ubuntu-drivers autoinstall
# or choose the recommend driver
sudo apt install (nvidia-430)
# reboot to take effects
sudo reboot
```
## Install docker engine
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
# Install the latest version
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Verify installation
sudo docker run hello-world
```
## Setup docker permissions
```bash
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo reboot
```
[Docker reference](https://docs.docker.com/engine/install/ubuntu/)

## Install nvidia-docker
```bash
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo sed -i -e '/experimental/ s/^#//g' /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update && sudo apt install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
sudo nvidia-ctk runtime configure --runtime=containerd
sudo systemctl restart containerd
sudo nvidia-ctk runtime configure --runtime=crio
sudo systemctl restart crio
```
[nvidia-docker reference](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
## Test
```bash
docker run --rm --runtime=nvidia --gpus all nvidia/cuda:12.3.1-devel-ubuntu22.04 nvidia-smi
```
[dockerhub-nvidia/cuda](https://hub.docker.com/r/nvidia/cuda/)

## Install VNC
```bash
git clone --recursive https://github.com/fcwu/docker-ubuntu-vnc-desktop
cd docker-ubuntu-vnc-desktop
git submodule init; git submodule update
```
## Make image
```bash
make clean
FLAVOR=lxqt ARCH=amd64 IMAGE=nvidia/cuda:12.3.1-devel-ubuntu22.04 make build
make run
```
## IP settings
```bash
limit ip
sudo iptables -I DOCKER-USER -m iprange -i enp5s0 ! --src-range 140.135.10.210-140.135.11.221 -j DROP
```
