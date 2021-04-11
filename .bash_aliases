export PS1='[\[\033[01;32m\]\u@laptop\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]] $ '
export EDITOR=vim
alias ls='ls --color=auto'
alias ll='ls -l'
alias p='ping google.com'
alias gitcbranch='git rev-parse --abbrev-ref HEAD'
pull () {
    branch="`gitcbranch`"
    cmd="git pull origin $branch"
    echo "Executing: $cmd"
    $cmd
}
push () {
    branch="`gitcbranch`"
    cmd="git push origin $branch"
    echo "Executing: $cmd"
    $cmd
}
fetch () {
    cmd="git fetch origin $1"
    echo "Executing: $cmd"
    $cmd && git checkout $1
    echo "Switched branch to $1"
}
alias wget='wget -c'
alias wgets='wget -c --no-check-certificate'
alias bc='python'
alias rm='rm -i'
alias netstat='sudo netstat -lptu'
alias pss='pss -i'
alias wh='/usr/bin/google-chrome --app=http://web.whatsapp.com'
alias castnow='~/node_modules/.bin/castnow'
alias cat='/usr/bin/bat'
