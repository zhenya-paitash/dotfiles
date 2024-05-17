#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# starship
# eval "$(starship init bash)"

# node from nvm.fish
export PATH=$PATH:$HOME/.local/share/nvm/v21.7.3/bin
