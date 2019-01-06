#!/bin/bash
set -ex

mkdir -p ~/.local/share/fonts
if [ ! -e ~/.local/share/fonts/source-code-pro ]
then
    git clone https://github.com/adobe-fonts/source-code-pro/ -b release --depth 1 ~/.local/share/fonts/source-code-pro
    fc-cache -fv
fi

mkdir -p ~/.local/share/xfce4/terminal/colorschemes
(
    cd ~/.local/share/xfce4/terminal/colorschemes;
    curl -O https://raw.githubusercontent.com/arcticicestudio/nord-xfce-terminal/develop/src/nord.theme
)
