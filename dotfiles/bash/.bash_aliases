# git
# alias gg='git log --oneline --graph --decorate --all'
# alias gg='git log --graph --pretty=format:"%C(auto)%h%d %s %m %Cblue%an %C(yellow)%ai" --all'
alias gg='git log --graph --pretty='\''%C(auto)%h%Creset%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'

alias rmorigs='find . -iname "*.orig" | xargs rm'

# PlatformIO
alias pio_upload='pio run -t upload'

# esp-idf
alias get_idf='. $HOME/esp/esp-idf/export.sh'

# docker
alias docker_comp_list_all='docker compose ps -a --format "table {{.Names}}\t{{.State}}\t{{.Status}}"'

# General
alias upd='sudo apt update && sudo apt upgrade -y && sudo apt autoremove && sudo apt autoclean'
alias upd-brew='brew update && brew upgrade'
alias upd-snap='sudo snap refresh'
alias listening='sudo netstat -tulp4n | grep LISTEN'

# Liferay
alias lf-j8='blade gw -i -Dorg.gradle.java.home=/home/mgsasaki/java/jdk1.8.0_171'
alias gogo-shell='telnet localhost 11311'
alias lf-check-formatting='blade gw checkSourceFormatting'
alias build-backend='blade gw build -xpackageRunBuild -xnpmInstall'
