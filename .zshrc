export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/sbin:$PATH"
export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PATH=${PATH}:/usr/local/lib/ruby/gems/2.7.0/bin
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export ZSH="/Users/isimmons/.oh-my-zsh"

ZSH_THEME=""
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
plugins=(git node macos python docker extract fzf fast-syntax-highlighting zsh-autosuggestions z.lua)
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='whence -va'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias flushDNS='dscacheutil -flushcache'    # flushDNS:     Flush out the DNS Cache
alias flushDNS_all='dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias hosts='sudo vim /etc/hosts'           # hosts:        Edit the local hosts file
alias git_sync="git pull -r && git push"
alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
alias pn=pnpm
sshkey () { mkdir -p "$1" && cd "$1" && ssh-keygen -t rsa -N '' -f cid_rsa; }
alias zshrc='vim ~/.zshrc'
alias zource='source ~/.zshrc'
autoload -U promptinit; promptinit

export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PNPM_HOME="/Users/isimmons/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# bun completions
[ -s "/Users/isimmons/.bun/_bun" ] && source "/Users/isimmons/.bun/_bun"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# go
export PATH="$PATH:/usr/local/go/bin"

# ni custom configuration file path
export NI_CONFIG_FILE="$HOME/.nirc"

# starship
eval "$(starship init zsh)"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
