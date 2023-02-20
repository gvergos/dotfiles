# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

export EDITOR="nvim"
export SHEL="zsh"
export USER="gver"

# exa configuration
export LS_COLORS=$LS_COLORS:'di=0;37;1'

# pfetch configuration
export PF_INFO="ascii title os host wm editor shell kernel uptime pkgs memory"
export PF_SEP=""
export PF_COLOR=1
export PF_COL1=5
export PF_COL2=7
export PF_COL3=4
export PF_ALIGN="10"
export PF_ASCII="macos"

alias install="sudo pacman -S"
alias update="sudo pacman -Syu"
alias remove="sudo pacman -Rns"
alias ls="exa --long --header"
alias la="exa --long --header --all"
alias find="find ~/ -name"
alias cls="clear"
alias pdf="zathura"
alias rm="rm -rf"
alias vlime='sbcl --load ~/.local/share/nvim/site/pack/packer/start/vlime/lisp/start-vlime.lisp'
alias webcam="ffplay /dev/video0"
alias emcc="/usr/lib/emscripten/./emcc"

export GIT_TOKEN="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"
export NODE_OPTIONS=--openssl-legacy-provider

xset r rate 300 50
pfetch
colorscript -e 22
