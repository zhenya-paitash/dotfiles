set -g fish_greeting

if status is-interactive
  starship init fish | source
  zoxide   init fish | source
end

# choose theme
fish_config theme choose fish\ default
# fish_config theme choose Catppuccin\ Macchiato
# fish_config theme choose ayu\ Light
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#   --color=fg:-1,fg+:#83C092,bg:-1,bg+:#262626
#   --color=hl:#A7C080,hl+:#E67E80,info:#afaf87,marker:#6F8578
#   --color=prompt:#E69875,spinner:#83C092,pointer:#E67E80,header:#E67E80
#   --color=border:#262626,label:#aeaeae,query:#d9d9d9'

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
# Вывести зависимости 
abbr -a pacsp 'pacman -Sp --print-format "%n"'
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
    set -lx GOOGLE_CLOUD_PROJECT $(cat ~/private/GOOGLE_CLOUD_PROJECT)
    set -lx GEMINI_API_KEY $(cat ~/private/GEMINI_API_KEY)
    command gemini $argv
end

# goose
function goose
  set -lx OPENROUTER_API_KEY $(cat ~/private/OPENROUTER_API_KEY)
  command goose $argv
end

# custom
alias lofi="hyprctl dispatch exec \"mpv --no-border --no-terminal \"https://youtu.be/jfKfPfyJRdk\"\" & disown & exit"
# alias spotify="$HOME/Apps/Spotify-1.2.63.394.g126b0d89-x86_64.AppImage & disown && exit"

# uv
fish_add_path "/home/zh/.local/bin"

# spicetify
fish_add_path /home/zh/.spicetify

# fish log
function fish_log
    # Создаём папку для логов
    mkdir -p ~/obsidian/vault_zhenyapaitash/_logs

    # Глобальная переменная (видна в дочерних функциях)
    set -g log_file ~/obsidian/vault_zhenyapaitash/_logs/(date "+%Y-%m-%d-%H-%M-%S")-(string replace -a " " "-" "$argv").log

    # Функция для логирования
    function log_command --on-event fish_postexec
        echo (date "+%Y-%m-%d %H:%M:%S") "|" $argv >> $log_file
    end

    echo "🔹 Запись логов начата: $log_file"

    # Остановка при выходе
    function stop_logging --on-event fish_exit
        functions --erase log_command
        functions --erase stop_logging
        set --erase log_file
        echo "🔹 Запись логов остановлена: $log_file"
    end
end

