alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

PS1="\[\e[32m\][\D{%d.%m. %H:%M:%S}]\[\e[m\] \[\e]0;\w\a\]\[\033[01;34m\]\w\[\033[00m\]\$ "

export PATH=~/bin:~/_dotfiles/bin:~/.cargo/bin:~/.krew/bin:~/.yarn/bin:/usr/local/bin:$PATH
export EDITOR=vim
export PYTHONHASHSEED=random
export PYTHONSTARTUP=~/_dotfiles/pythonstartup.py
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)

alias p='.venv/bin/python -Wonce'
alias m='.venv/bin/python -Wonce manage.py'
alias mds='.venv/bin/python -Wonce manage.py runserver --traceback 0.0.0.0:8000'
alias fixdns='echo nameserver 8.8.8.8 | sudo tee /etc/resolv.conf'
alias pri='prek install -f'
alias pra='prek run -a'
alias pru='prek autoupdate'
alias pdc='podman-compose -f ~/projects/argocd/local/podman-compose.yml'

function tm() {
    tmux -2 new-session -A -s "${1:-main}"
}

function fs() {
    printf '\e]710;%s\007' "xft:Inconsolata:size=$1"
}

function srv() {
    python3 -m http.server "${1:-8001}"
}

case "$(uname -s)" in
Darwin*)
    alias xopen=open
    alias ls='ls -G'
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'
    export PGDATA=/usr/local/var/postgres
    function code () { VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $*; }
    # Load bash completion if available (via Homebrew)
    if [ -f /opt/homebrew/etc/bash_completion ]; then
        . /opt/homebrew/etc/bash_completion
    elif [ -f /usr/local/etc/bash_completion ]; then
        . /usr/local/etc/bash_completion
    fi

    # from https://dev.to/jameson/bash-completion-for-git-on-mac-os-x-monterrey-3imd
    xcode_dev_dir='/Applications/Xcode.app/Contents/Developer'
    git_core="$xcode_dev_dir/usr/share/git-core"
    git_completion="$git_core/git-completion.bash"
    [ -x "$(which git)" ] && \
        [ -f "$git_completion" ] && \
        source "$git_completion"

    # https://gist.github.com/aliang/1024466
    _complete_ssh_hosts ()
    {
            COMPREPLY=()
            cur="${COMP_WORDS[COMP_CWORD]}"
            comp_ssh_hosts=`cat ~/.ssh/config | \
                             grep --color=never "^Host " | \
                             awk '{print $2}'
                       `
            COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
            return 0
    }
    complete -F _complete_ssh_hosts ssh
    complete -f -F __complete_ssh_host scp

    ;;
Linux*)
    alias xopen=xdg-open
    alias code='flatpak run com.visualstudio.code'
    alias mousespeed="gsettings set org.gnome.desktop.peripherals.mouse speed"
    alias brightness="sudo ddcutil --display 1 setvcp 10"
    # Load bash completion
    if [ -f /usr/share/bash-completion/completions/git ]; then
        . /usr/share/bash-completion/completions/git
    fi
    # WSL detection
    if [ -f /proc/version ] && grep -qi Microsoft /proc/version; then
        umask 002
        export DISPLAY=$(awk '/nameserver/ {print $2}' /etc/resolv.conf):0
    fi
    ;;
esac

export NVIM_TUI_ENABLE_TRUE_COLOR=1
alias yt-audio='uvx "yt-dlp[default]" --embed-metadata --embed-thumbnail --audio-quality 0 -o "%(title)s.%(ext)s" -f bestaudio -x'

function pdfcompress () {
   gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dEmbedAllFonts=true -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=144 -sOutputFile="$1.compressed.pdf" "$1"; 
}
