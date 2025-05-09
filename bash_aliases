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

function tm() {
    tmux -2 new-session -A -s "${1:-main}"
}

function fs() {
    printf '\e]710;%s\007' "xft:Inconsolata:size=$1"
}

function srv() {
    python3 -m http.server "${1:-8001}"
}

. /usr/share/bash-completion/completions/git

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
    alias code='flatpak run com.visualstudio.code'
    ;;
esac

if grep -qi Microsoft /proc/version; then
    umask 002
    export DISPLAY=$(awk '/nameserver/ {print $2}' /etc/resolv.conf):0
fi
export NVIM_TUI_ENABLE_TRUE_COLOR=1
alias mousespeed="gsettings set org.gnome.desktop.peripherals.mouse speed"
alias brightness="sudo ddcutil --display 1 setvcp 10"
alias yt-audio='yt-dlp --embed-metadata --embed-thumbnail --audio-quality 0 -o "%(title)s.%(ext)s" -f bestaudio -x'

function pdfcompress () {
   gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dEmbedAllFonts=true -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=144 -sOutputFile="$1.compressed.pdf" "$1"; 
}
