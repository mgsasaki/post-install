# git
# alias gg='git log --oneline --graph --decorate --all'
# alias gg='git log --graph --pretty=format:"%C(auto)%h%d %s %m %Cblue%an %C(yellow)%ai" --all'
alias gg='git log --graph --pretty='\''%C(auto)%h%Creset%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'\'' --all'

alias rmorigs='find . -iname *.orig | xargs rm'

# PlatformIO
alias pio_upload='pio run -t upload'

# esp-idf
alias get_idf='. $HOME/esp/esp-idf/export.sh'

# General
alias upd='sudo apt update && sudo apt upgrade -y'
alias listening='sudo netstat -tulp4n | grep LISTEN'
