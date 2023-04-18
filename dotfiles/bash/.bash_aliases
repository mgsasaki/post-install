# git
alias gg='git log --oneline --graph --decorate --all'
#alias gg='git log --pretty=format:"%C(auto)%h%d %s %m %Cblue%an %C(yellow)%ai" --graph --all'
alias rmorigs='find . -iname *.orig | xargs rm'

# PlatformIO
alias pio_upload='pio run -t upload'

# esp-idf
alias get_idf='. $HOME/esp/esp-idf/export.sh' 

# General
alias upd='sudo apt update && sudo apt upgrade -y'
