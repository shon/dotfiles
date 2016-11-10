export PS1='[\[\033[01;32m\]\u@laptop\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]] $ '
export EDITOR=vim
alias ls='ls --color=auto'
alias ll='ls -l'
alias p='ping google.com'
alias gitcbranch='git rev-parse --abbrev-ref HEAD'
pull () { git pull origin `gitcbranch`; }
push () { git push origin `gitcbranch`; }
alias wget='wget -c'
alias wgets='wget -c --no-check-certificate'
alias bc='python'
alias rm='rm -i'
alias netstat='sudo netstat -lptu'
alias pss='pss -i'
