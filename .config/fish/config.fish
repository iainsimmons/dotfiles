#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com/
# env vars
set -gx XDG_CONFIG_HOME "/Users/isimmons/.config"

fish_add_path /opt/homebrew/bin
fish_add_path /usr/local/bin
fish_add_path $HOME/bin

eval (/opt/homebrew/bin/brew shellenv)

source $XDG_CONFIG_HOME/fish/themes/tokyonight_night.fish

# zoxide config, only run in interactive shells
# 'ajeetdsouza/zoxide'
status is-interactive; and zoxide init fish | source

# direnv config, only run in interactive shells
status is-interactive; and direnv hook fish | source

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings

set -Ux EDITOR nvim # 'neovim/neovim' text editor
set -Ux VISUAL nvim
set -Ux PAGER ov # https://github.com/noborus/ov
set -Ux MANPAGER "ov --section-delimiter '^[^\s]' --section-header" # https://noborus.github.io/ov/man/index.html

# fzf.fish config
set --export FZF_DEFAULT_OPTS --cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*" --color=bg:0,fg:7,hl:3 --color=bg+:8,fg+:15,hl+:11 --color=info:5,border:5,prompt:2 --color=pointer:0,marker:9,spinner:9,header:1
set fzf_diff_highlighter diff-so-fancy
set fzf_history_time_format %Y-%m-%d
set fzf_history_opts --reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'
set fzf_fd_opts --type f --hidden --exclude .git --no-ignore --max-depth 5
set fzf_git_log_opts --bind "ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
set fzf_directory_opts --reverse --bind "ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
set fzf_preview_dir_cmd lsd -aghl

# atuin config
# set -gx ATUIN_NOBIND "true"
# only in interactive shell sessions
if status is-interactive
    atuin init fish | source
    # bind to ctrl-r in normal and insert mode, add any other bindings you want here too
    bind \cr _atuin_search
    bind -M insert \cr _atuin_search
end

#fish_add_path "$HOME/.rvm/bin"
set -gx PNPM_HOME /Users/isimmons/Library/pnpm
fish_add_path "$PNPM_HOME"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.config/yarn/global/node_modules/.bin"
# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
fish_add_path "$BUN_INSTALL/bin"

# go
fish_add_path /usr/local/go/bin

# rust
fish_add_path "$HOME/.cargo/bin"

# python
fish_add_path "$HOME/.pyenv/shims"
set -gx PYTHON python
# eval (pyenv init --path)
# status --is-interactive; and pyenv init - | source
# status --is-interactive; and pyenv virtualenv-init - | source

function tm
    sesh connect dotfiles
    # tmux a -t dotfiles || exec tmux new -c ~ -s dotfiles
end

function mcd # Makes new Dir and jumps inside
    mkdir -p "$1" && cd "$1"
end

function trash # Moves a file to the MacOS trash
    command mv "$argv" ~/.Trash
end

function ql # Opens any file in MacOS Quicklook Preview
    qlmanage -p "$argv" >&/dev/null
end

function sshkey # generate ssh key in directory
    mkdir -p "$1" && cd "$1" && ssh-keygen -t rsa -N '' -f cid_rsa
end

function clone -d "Clone and open tmux window for given repo" -a repo_arg -a parent_arg -a dir_name_arg
    if test -n "$repo_arg"
        string match -rq '\/(?<repo_name>.+?)\.git$' -- $repo_arg
    else
        echo "Please specify a git repo to clone"
        return 1
    end

    if test -n "$parent_arg"
        set parent_dir "$parent_arg"
    else
        set parent_dir ~/dev/Squiz/
    end

    if test -n "$dir_name_arg"
        set dir_name "$dir_name_arg"
    else
        set dir_name (string trim "$repo_name")
    end

    cd "$parent_dir" && git clone "$repo_arg" "$dir_name" && sesh connect "$parent_dir/$dir_name"
end

abbr myip "ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
abbr cp 'cp -iv' # Preferred 'cp' implementation
abbr mv 'mv -iv' # Preferred 'mv' implementation
abbr mkdir 'mkdir -pv' # Preferred 'mkdir' implementation
abbr cd.. 'cd ../' # Go back 1 directory level (for fast typers)
abbr .. 'cd ../' # Go back 1 directory level
abbr ... 'cd ../../' # Go back 2 directory levels
abbr .3 'cd ../../../' # Go back 3 directory levels
abbr .4 'cd ../../../../' # Go back 4 directory levels
abbr .5 'cd ../../../../../' # Go back 5 directory levels
abbr .6 'cd ../../../../../../' # Go back 6 directory levels
abbr f 'open -a Finder ./' # f:            Opens current directory in MacOS Finder
abbr ~ "cd ~" # ~:            Go Home
abbr path 'echo -e ${PATH//:/\\n}' # path:         Echo all executable Paths
abbr show_options shopt # Show_options: display bash options settings
abbr fix_stty 'stty sane' # fix_stty:     Restore terminal settings when screwed up
abbr cic 'set completion-ignore-case On' # cic:          Make tab-completion case-insensitive
abbr flushDNS 'dscacheutil -flushcache' # flushDNS:     Flush out the DNS Cache
abbr flushDNS_all 'dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
abbr hosts 'sudo nvim /etc/hosts' # hosts:        Edit the local hosts file
abbr git_sync "git pull -r && git push"
abbr pn pnpm
abbr fishrc 'nvim ~/.config/fish/config.fish'
abbr fsource 'source ~/.config/fish/config.fish'
abbr z zoxide
abbr za zoxide add
abbr zz zi
abbr find fd
abbr y yazi
# Hide/show all desktop icons (useful when presenting)
abbr hidedesktop "defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
abbr showdesktop "defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
# delete item from history, use fzf to select
abbr hd "history delete --exact --case-sensitive (history | fzf-tmux -p -m --reverse)"
abbr obsidian_styles "nvim ~/Dropbox/Obsidian\ Vault/.obsidian/snippets/styles.css"
abbr bbd 'cd ~/dotfiles/ && brew bundle dump --force --describe'

alias c clear # c:            Clear terminal display
alias cd z # use zoxide for cd (change directory)
alias vim nvim
alias vi nvim
alias v nvim
alias ls lsd # Use lsd instead of ls
alias ll 'lsd -aghl' # Preferred 'ls'/'lsd' implementation
