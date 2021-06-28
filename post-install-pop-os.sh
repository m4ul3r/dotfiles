#!/bin/bash
#
# Author:
#   m4ul3r
#
# Description:
#   Personal Linux post install script


PKG_LIST=(
    brave-browser
    virt-manager
    qemu-kvm
    libvirt-daemon-system
    libvirt-clients
    bridge-utils
    gnome-shell-extensions
    vim
    htop
    bashtop
    neofetch
    discord
    tldr
    openvpn
    python3-pip
    gnome-tweaks
)

# Ensure sudo is being ran
#if [[ "${UID}" -ne 0 ]]
#then
    #echo "Must be executed with sudo or as root" >&2
    #exit 1
#fi

# Update and upgrade system
sudo apt-get update && sudo apt-get upgrade -y

# Install Brave
sudo apt-get install apt-transport-https curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt-get update

# Install Packages
for pkg_name in ${PKG_LIST[@]}; do
    if ! sudo apt list --installed | grep -q "^\<$pkg_name\>"; then
        echo "Installing $pkg_name"
        sleep .5
        sudo apt-get install "$pkg_name" -y
        echo "$pkg_name installed"
    else
        echo "$pkg_name already installed"
    fi
done

# Setup KVM
sudo adduser $USER libvirt
sudo adduser $USER kvm
sudo systemctl enable --now libvirtd

# Setup tldr
tldr -u

# change gnome terminal theme
cd /tmp
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git
cd nord-gnome-terminal/src
./nord.sh
echo "\nNord terminal theme installed - Apply changes in terminal preferences"

# change shell theme to nordic-darker
cd /tmp
wget https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE2MjQ4MjMyMjMiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6IjA5MzM4ZTk2YWZmMWM4MzQ2YjlhZmNjNjFhNTlkM2VjYjA3NTQzMDE2NzAyM2M1MWIwOTAzZDgyOTgwODdhMDBlMWVlZWEwZDRlZGNiYjllOThmMjBlMWQxNmI2YTZkNWZmYTE2NTBmNDdkMjlmYzM1ZjU1NWZmOTk0OWFlZWY0IiwidCI6MTYyNDg5ODM5MSwic3RmcCI6bnVsbCwic3RpcCI6bnVsbH0.yN726QExG9uyxgz3OZofdcarhNvH8UND8PqKfZKwOco/Nordic-darker-v40.tar.xz
tar xf Nordic-darker-v40.tar.xz
sudo mv Nordic-darker/ /usr/share/themes/
gsettings set org.gnome.desktop.interface gtk-theme Nordic-Darker

# Download user dotfiles
cd ~
wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.bashrc
wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.vimrc
wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.gitconfig
wget https://raw/githubusercontent.com/m4ul3r/dotfiles/main/.tmux.conf

# Download root dotfiles
#sudo wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.ROOTBASHRC /root/.bashrc
#sudo wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.vimrc /root/.vimrc

# Clean up
sudo apt-get autoclean -y
sudo apt-get autoremove -y
