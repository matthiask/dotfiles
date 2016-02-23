# some more ls aliases
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

alias xopen='open'

PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export EDITOR=vim
export PATH=~/_dotfiles/bin:/usr/local/bin:$PATH
export PGDATA=/usr/local/var/postgres
export PYTHONWARNINGS=always
export PYTHONHASHSEED=random

alias m='venv/bin/python -Wall manage.py'
alias mds='python -Wall manage.py runserver --traceback 0.0.0.0:8038'
alias gvir='gvim --remote'

function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }

if [ -f ~/_dotfiles/git-completion.bash ]
then
    . ~/_dotfiles/git-completion.bash
fi
