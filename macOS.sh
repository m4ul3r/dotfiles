#!/bin/bash
#
# I don't know why you would try to make something look like
# something that it is not, but to each their own
 
PKG_LIST=(
    gnome-tweaks
    neofetch
    htop
    gnome-shell-extensions
    discord
    tldr
    python3-pip
    chrome-gnome-shell
    libglib2.0-dev
)
 
sudo apt-get update && sudo apt-get upgrade
sudo apt dist-upgrade
 
# install packages
 
for p_name in ${PKG_LIST[@]}; do
    if ! sudo apt list --installed | grep -q "^\<$p_name\>"; then
        echo "Installing $p_name"
        sleep 1
        sudo apt-get install "$p_name" -y
        echo "Installed $p_name"
    else
        echo "$p_name already installed"
    fi
done
 
 
# start downloading and installing gnome extensions through the mighty terminal
cd /usr/share/gnome-shell/extensions
 
wget "https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v42.shell-extension.zip"
UUID=$(unzip -c "user-themegnome-shell-extensions.gcampax.github.com.v42.shell-extension.zip" metadata.json | grep uuid | cut -d \" -f4)
mkdir $UUID
unzip "user-themegnome-shell-extensions.gcampax.github.com.v42.shell-extension.zip" -d $UUID
rm "user-themegnome-shell-extensions.gcampax.github.com.v42.shell-extension.zip"
sudo gnome-extensions enable $UUID
 
 
# download white sur gtk theme
cd ~/Downloads
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd ~/Downloads/WhiteSur-gtk-theme
./install.sh
cd ~/Downloads
rm -rf ~/Downloads/WhiteSur-gtk-theme
 
# download icon pack
cd ~/Downloads
git clone https://github.com/yeyushengfan258/BigSur-icon-theme.git
cd BigSur-icon-theme/
./install.sh
cd ~/Downloads
rm -rf BigSur-icon-theme/
 
 
# Download cursor pack
git clone https://github.com/vinceliuice/McMojave-cursors.git
cd McMojave-cursors
./install.sh
cd ~/Downloads
rm -rf McMojave-curors
