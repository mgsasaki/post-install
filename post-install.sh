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
ASDF_BRANCH="v0.12.0"
git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch $ASDF_BRANCH
. $HOME/.asdf/asdf.sh
asdf update
echo "Install asdf by putting the following lines on ~/.bashrc"
echo '. $HOME/.asdf/asdf.sh'
echo '. $HOME/.asdf/completions/asdf.bash'

if [ ! -d "$HOME/.local/bin" ]; then
    mkdir -p $HOME/.local/bin
fi

# ASDF Plugins
asdf plugin add gitconfig
asdf plugin add nodejs
asdf plugin add python
asdf plugin add ruby
# asdf plugin add gradle
# asdf plugin add maven
# asdf plugin add yarn

# TODO: dotfiles (https://github.com/skwp/dotfiles)

##########
# Install sublime text editor (https://www.sublimetext.com/docs/3/linux_repositories.html)
# TODO: use snap?
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
# Make sure to uninstall conflicting packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg

# Add Docker’s official GPG key:
# sudo mkdir -p /etc/apt/keyrings
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Use the following command to set up the stable repository. To add the nightly or test repository, add the word nightly or test (or both) after the word stable in the commands below.
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index, and install the latest version of Docker Engine and containerd
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Testing
sudo docker run hello-world

echo -e '\n=> Removing Sudo requirement Docker'
#sudo groupadd docker
sudo usermod -aG docker ${USER}

# Install dark theme for git gui
# https://wiki.tcl-lang.org/page/List+of+ttk+Themes
# https://blog.serindu.com/2019/03/07/applying-tk-themes-to-git-gui/

# Install powerline for bash?
# sudo apt-get install powerline fonts-powerline
# echo "Install powerline for bash by putting the following lines on ~/.bashrc"
# echo 'if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then'
# echo '  powerline-daemon -q'
# echo '  POWERLINE_BASH_CONTINUATION=1'
# echo '  POWERLINE_BASH_SELECT=1'
# echo '  source /usr/share/powerline/bindings/bash/powerline.sh'
# echo 'fi'

# Install bash-git-prompt (https://github.com/magicmonty/bash-git-prompt)
# git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
# echo "Install bash-git-prompt by putting the following lines on ~/.bashrc"
# echo 'if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then'
# echo '    GIT_PROMPT_ONLY_IN_REPO=1'
# echo '    source $HOME/.bash-git-prompt/gitprompt.sh'
# echo 'fi'

# TODO: Install oh-my-bash (https://github.com/ohmybash/oh-my-bash)
# bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# TODO: Backup ~/.bashrc

# Install VSCode (https://code.visualstudio.com/docs/setup/linux)
sudo snap install code --classic
# Alternate method (.deb)
# sudo apt-get install wget gpg
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# rm -f packages.microsoft.gpg
# sudo apt install apt-transport-https
# sudo apt update
# sudo apt install code # or code-insiders

# https://github.com/Vanderscycle/dot-config/blob/main/postInstallScripts/ubuntuPostInstall.sh
# -----------------------------------------------------------------------------
# => if local machine
# -----------------------------------------------------------------------------
echo '\n=> Install favorite applications'
echo '=> spotify discord mailspring vlc gitkraken Brave(browser)'
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

# TODO: Add applications:
# tilix
