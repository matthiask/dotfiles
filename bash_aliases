alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

PS1='\[\033[01;34m\]\w\[\033[00m\]\$ '
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\w\a\]$PS1"
    ;;
*)
    ;;
esac

export PATH=~/_dotfiles/bin:/usr/local/bin:$PATH
export EDITOR=vim
export PYTHONWARNINGS=once
export PYTHONHASHSEED=random
export PYTHONSTARTUP=~/_dotfiles/pythonstartup.py
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias m='venv/bin/python manage.py'
alias mds='venv/bin/python manage.py runserver --traceback 0.0.0.0:8000'
alias fixdns='echo nameserver 8.8.8.8 | sudo tee /etc/resolv.conf'

function tm() {
    tmux -2 new-session -A -s "${1:-main}"
}

if [ -f ~/_dotfiles/git-completion.bash ]
then
    . ~/_dotfiles/git-completion.bash
fi

case "$(uname -s)" in
Darwin*)
    alias xopen=open
    alias ls='ls -G'
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'
    export PGDATA=/usr/local/var/postgres
    function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }
    ;;
Linux*)
    alias xopen=xdg-open
    ;;
esac
