#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y chrome-gnome-shell gnome-tweak-tool

# TODO: Copy MacOS themes icons fonts wallpaper
# TODO: Instal gnome shell extensions: Dash to Dock, User Themes

# Install dev basic packages
sudo apt install \
    build-essential \
    git git-gui gitk \
    meld \
    tmux \
    tilix \
    default-jdk \
    curl


##########
# Install asdf-vm (https://github.com/asdf-vm/asdf)
# (https://asdf-vm.com/guide/getting-started.html)
##########
ASDF_BRANCH="v0.10.2"
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_BRANCH
. $HOME/.asdf/asdf.sh
asdf update
echo "Install asdf by putting the following lines on ~/.bashrc"
echo '. $HOME/.asdf/asdf.sh'
echo '. $HOME/.asdf/completions/asdf.bash'

# TODO: dotfiles (https://github.com/skwp/dotfiles)

##########
# Install sublime text editor (https://www.sublimetext.com/docs/3/linux_repositories.html)
##########
# Install the GPG key:
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# Ensure apt is set up to work with https sources:
sudo apt-get install apt-transport-https

# Select the Stable channel:
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Update apt sources and install Sublime Text
sudo apt-get update
sudo apt-get install sublime-text

# TODO: Copy user preferences


##########
# Install Docker engine (https://docs.docker.com/engine/install/ubuntu)
##########
# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below.
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index, and install the latest version of Docker Engine and containerd
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Receiving a GPG error when running apt-get update, try uncommenting the line bellow and try again.
#sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo -e '\n=> Removing Sudo requirement Docker'
#sudo groupadd docker
sudo usermod -aG docker ${USER}


# TODO: Install bash-git-prompt (https://github.com/magicmonty/bash-git-prompt)

# https://github.com/Vanderscycle/dot-config/blob/main/postInstallScripts/ubuntuPostInstall.sh
# -----------------------------------------------------------------------------
# => if local machine
# -----------------------------------------------------------------------------
echo '\n=> Install favorite applications'
echo '=> spotify discord mailspring vlc gitkraken Brave(broser)'
echo -e '=> Are you sure? [Y/n] '
read confirmation
confirmation=$(echo $confirmation | tr '[:lower:]' '[:upper:]')
if [[ $confirmation == 'YES' || $confirmation == 'Y' ]]; then

    sudo apt-get install -y --no-install-recommends vlc neomutt
    snap install spotify discord discordcd
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo dpkg -i gitkraken-amd64.deb
    
    echo -e 'Installing Brave browser.\n'
    sudo apt install apt-transport-https
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt install -y --no-install-recommends brave-browser
    
    echo -e 'Done.\n'

fi
