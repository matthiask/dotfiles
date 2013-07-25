# some more ls aliases
alias ls='ls --color=auto'
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

alias xopen='xdg-open'

export PS1='\u@\h:\w$ '
export EDITOR=vim
alias m='python -Wall manage.py'
alias mds='python -Wall manage.py runserver --traceback 0.0.0.0:8038'
alias gvir='gvim --remote'
