if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

if status is-interactive
  starship init fish | source
  zoxide   init fish | source
end

# ssh-add ~/.ssh/id_ed25519

# List Directory
alias ls="eza --color=always --icons=always --long"
alias lls="eza --color=always --icons=always --long --no-filesize --no-time --no-user --no-permissions"
alias l="eza --color=always --icons=always"
alias ll="l -a"
alias la="ls -a"
alias lla="lls -la"
alias lt="ls --tree --level=1"
alias llt="lls --tree --level=1"
alias lt2="ls --tree --level=2"
alias llt2="lls --tree --level=2"
alias lt3="ls --tree --level=3"
alias llt3="lls --tree --level=3"

# kitty
abbr icat 'kitty +kitten icat '

# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'
abbr rm 'rm -rf'

# Fixes "Error opening terminal: xterm-kitty" when using the default kitty term to open some programs through ssh
alias ssh='kitten ssh'

# neovim
set -U EDITOR nvim
alias vim='nvim'
alias lg='lazygit'
alias ld='lazydocker'
alias vf='nvim $(fzf --preview "bat --color=always {}")'

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
