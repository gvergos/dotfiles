autoload -Uz compinit
compinit

autoload -U colors && colors
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-prompt '%S%M matches:%s'
zstyle ':completion:*' list-colors \
  'di=1;34'  'fi=0;37'  'ln=1;36'  'ex=1;32'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%F{yellow}%d%f'
zstyle ':completion:*' description 'yes'

xset r rate 300 50

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"

set -o vi

alias ls="colorls -1 -l --gs --sd"
alias la="colorls -1 -a -l --gs --sd"
alias update="sudo pacman -Syu"
alias install="sudo pacman -S"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:~/go/bin
export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH

export PF_ASCII=arch

pfetch
