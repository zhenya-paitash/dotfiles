set -g fish_greeting

if status is-interactive
  starship init fish | source
  zoxide   init fish | source
end

# choose theme
# fish_config theme choose fish\ default
fish_config theme choose Catppuccin\ Macchiato
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

# package manager
# pacman
abbr -a pacs 'sudo pacman -S'         # Установка пакета
abbr -a pacss 'sudo pacman -Ss'       # Поиск в репозиториях
abbr -a pacu 'sudo pacman -Syu'       # Обновить систему
abbr -a pacr 'sudo pacman -Rns'       # Удалить пакет (+ зависимости + конфиги)
abbr -a pacq 'pacman -Q'              # Показать установленные пакеты
abbr -a pacqi 'pacman -Qi'            # Информация об установленном пакете
abbr -a pacql 'pacman -Ql'            # Список файлов пакета
abbr -a pacf 'pacman -F'              # Поиск файлов в пакетах
# Очистка кэша
abbr -a pacc 'sudo pacman -Sc'        # Очистить кэш (старые версии)
abbr -a paccc 'sudo pacman -Scc'      # Полная очистка кэша (опасно!)
# Поиск зависимостей
abbr -a pacwh 'pacman -Qo'            # Какой пакет владеет файлом?
# yay
abbr -a yays 'yay -S'                 # Установка пакета (AUR + репозитории)
abbr -a yayss 'yay -Ss'               # Поиск (AUR + репозитории)
abbr -a yayu 'yay -Syu'               # Полное обновление (AUR + репозитории)
abbr -a yayr 'yay -Rns'               # Удалить пакет (+ зависимости + конфиги)
abbr -a yayq 'yay -Q'                 # Показать установленные пакеты
abbr -a yayqi 'yay -Qi'               # Информация об установленном пакете
abbr -a yayql 'yay -Ql'               # Список файлов пакета

# man
alias ruman="LANG=ru_RU.UTF-8 man"

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
# theme: https://github.com/rose-pine/fzf/blob/main/dist/rose-pine.fish
# alias fzf='fzf --preview "bat --color=always {}" --height 60% --inline-info --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(echo -n {+} | wl-copy)+abort"'
alias fzf='fzf --preview "bat --color=always {}" --height 60% --inline-info --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(readlink -f {} | wl-copy -n)+abort"'
alias fzfa='fzf --walker-skip="" --preview "bat --color=always {}" --height 60% --inline-info --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(readlink -f {} | wl-copy -n)+abort"'
alias rgf='fzf --ansi --disabled --query "$argv" --height 100% --inline-info --delimiter ":" --preview "bat --color=always --style=numbers --highlight-line {2} {1}" --preview-window "right:60%:wrap:+{2}-5" --layout reverse --bind ctrl-u:preview-page-up,ctrl-d:preview-page-down,"ctrl-y:execute-silent(readlink -f {1} | wl-copy -n)+abort" --bind "change:reload:rg --vimgrep {q} || true" --prompt "rg> " --bind "enter:accept"'

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

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# swayimg
alias swayimg="swayimg -C $HOME/.config/swayimg/swayimgrc"

# opencode
alias opencode='/home/zh/go/bin/opencode'

# gemini
function gemini
    set -lx GOOGLE_CLOUD_PROJECT (cat ~/private/GOOGLE_CLOUD_PROJECT)
    set -lx GEMINI_API_KEY (cat ~/private/GEMINI_API_KEY)
    command gemini $argv
end

# uv
fish_add_path "/home/zh/.local/bin"

# custom
alias lofi="hyprctl dispatch exec \"mpv --no-border --no-terminal \"https://youtu.be/jfKfPfyJRdk\"\" & disown & exit"
# alias spotify="$HOME/Apps/Spotify-1.2.63.394.g126b0d89-x86_64.AppImage & disown && exit"


fish_add_path /home/zh/.spicetify
