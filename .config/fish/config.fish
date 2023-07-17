#
# ███████╗██╗███████╗██╗  ██╗
# ██╔════╝██║██╔════╝██║  ██║
# █████╗  ██║███████╗███████║
# ██╔══╝  ██║╚════██║██╔══██║
# ██║     ██║███████║██║  ██║
# ╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝
# A smart and user-friendly command line
# https://fishshell.com/

fish_add_path $HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin
fish_add_path $HOME/.config/bin # my custom scripts
fish_add_path /usr/local/bin

eval (/usr/local/bin/brew shellenv)
starship init fish | source # https://starship.rs/
zoxide init fish | source # 'ajeetdsouza/zoxide'
direnv hook fish | source # direnv

set -U fish_greeting # disable fish greeting
set -U fish_key_bindings fish_vi_key_bindings
# set -U LANG en_US.UTF-8
# set -U LC_ALL en_US.UTF-8

# set -Ux BAT_THEME Catppuccin-mocha # 'sharkdp/bat' cat clone
set -Ux EDITOR nvim # 'neovim/neovim' text editor
# set -Ux FZF_DEFAULT_COMMAND "fd -H -E '.git'"
# set -Ux PAGER "~/.local/bin/nvimpager" # 'lucc/nvimpager'
set -Ux VISUAL nvim

# env vars
set -gx XDG_CONFIG_HOME "/Users/isimmons/.config"

set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git --color=always"
set -gx FZF_DEFAULT_OPTS --ansi
set -gx FZF_TMUX_OPTS -p
set -gx FZF_CTRL_R_OPTS "--reverse --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

fish_add_path "$HOME/.rvm/bin"
fish_add_path "$HOME/.pyenv/bin"
# eval (pyenv init --path)
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source
set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path "$VOLTA_HOME/bin"
set -gx PNPM_HOME /Users/isimmons/Library/pnpm
fish_add_path "$PNPM_HOME"
fish_add_path "$HOME/.yarn/bin"
fish_add_path "$HOME/.config/yarn/global/node_modules/.bin"

# go
fish_add_path /usr/local/go/bin

# ni custom configuration file path
set -gx NI_CONFIG_FILE "$HOME/.nirc"

function tm
    tmux a -t tmux || exec tmux new -s tmux && exit
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

abbr myip "ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
abbr cp 'cp -iv' # Preferred 'cp' implementation
abbr mv 'mv -iv' # Preferred 'mv' implementation
abbr mkdir 'mkdir -pv' # Preferred 'mkdir' implementation
abbr ls exa # Use exa instead of ls
abbr ll 'exa -lah --icons --git' # Preferred 'ls'/'exa' implementation
abbr less 'less -FSRXc' # Preferred 'less' implementation
abbr cd.. 'cd ../' # Go back 1 directory level (for fast typers)
abbr .. 'cd ../' # Go back 1 directory level
abbr ... 'cd ../../' # Go back 2 directory levels
abbr .3 'cd ../../../' # Go back 3 directory levels
abbr .4 'cd ../../../../' # Go back 4 directory levels
abbr .5 'cd ../../../../../' # Go back 5 directory levels
abbr .6 'cd ../../../../../../' # Go back 6 directory levels
abbr f 'open -a Finder ./' # f:            Opens current directory in MacOS Finder
abbr ~ "cd ~" # ~:            Go Home
abbr which 'whence -va' # which:        Find executables
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
abbr zz zi
abbr find fd
# Hide/show all desktop icons (useful when presenting)
abbr hidedesktop "defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
abbr showdesktop "defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

alias c clear # c:            Clear terminal display
alias vim nvim
alias vi nvim
alias v nvim
alias t '~/.tmux/plugins/t'