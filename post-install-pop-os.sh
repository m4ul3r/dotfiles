#!/bin/bash
#
# Author:
#   m4ul3r
#
# Description:
#   Personal Linux post install script


PKG_LIST=(
    brave-browser
    gnome-shell-extensions
    vim
    bashtop
    discord
    tldr
    openvpn
    python3-pip
    gnome-tweaks
    zsh
)

# Ensure sudo is being ran
if [[ "${UID}" -ne 0 ]]
then
    #echo "Must be executed with sudo or as root" >&2
    #exit 1
fi

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

# Setup tldr
tldr -u

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# Download user dotfiles
cd ~
wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.bashrc
wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.vimrc
wget https://raw.githubusercontent.com/m4ul3r/dotfiles/main/.gitconfig
wget https://raw/githubusercontent.com/m4ul3r/dotfiles/main/.tmux.conf

# Clean up
sudo apt-get autoclean -y
sudo apt-get autoremove -y
