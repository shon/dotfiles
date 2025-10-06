export EDITOR=nvim
alias vim='nvim'
alias v='nvim'
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
alias cat='bat'
alias ls='ls --color=auto'
alias ll='ls -la'
alias p='ping 1.1.1.1'
alias ssh='ssh -A'
