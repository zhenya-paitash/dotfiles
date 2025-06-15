set -g fish_greeting

if status is-interactive
  starship init fish | source
  zoxide   init fish | source
end

# choose theme
fish_config theme choose fish\ default
#fish_config theme choose Catppuccin\ Latte
#fish_config theme choose ayu\ Light

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

# fzf
#alias fzf='fzf --preview "bat --color=always {}" --height 60% --inline-info --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(echo -n {+} | wl-copy)+abort"'
alias fzf='fzf --preview "bat --color=always {}" --height 60% --inline-info --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(readlink -f {} | wl-copy -n)+abort"'
alias fzfa='fzf --walker-skip="" --preview "bat --color=always {}" --height 60% --inline-info --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(readlink -f {} | wl-copy -n)+abort"'

# tmux
alias t='tmux'
alias ta='tmux a || tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tk='tmux kill-session -t'

# neovim
set -U EDITOR nvim
function nvim
    if test -n "$NVIM_APPNAME"
        NVIM_APPNAME=$NVIM_APPNAME command nvim $argv
    else
        command nvim $argv
    end
end
alias vim='nvim'
alias viml='nvim leetcode.nvim'
alias vf='nvim $(fzf)'
alias vfa='nvim $(fzfa)'
alias vv="bash $HOME/scripts/nvim-selector"

# lazygit and lazydocker
alias lg='lazygit'
alias ld='~/go/bin/lazydocker'
alias usql='~/go/bin/usql'

# custom
alias lofi="hyprctl dispatch exec \"mpv --no-border --no-terminal \"https://youtu.be/jfKfPfyJRdk\"\" & disown & exit"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# opencode
alias opencode='/home/zh/go/bin/opencode'

# uv
fish_add_path "/home/zh/.local/bin"
