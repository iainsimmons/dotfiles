# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
# /etc/omarchy.conf is written by omarchy-dev-link. When absent, force the
# package default instead of preserving a stale inherited dev-link value before
# we decide which rc file to source.
if [[ -f /etc/omarchy.conf ]]; then
  source /etc/omarchy.conf
  export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
else
  export OMARCHY_PATH=/usr/share/omarchy
fi
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
. "$HOME/.cargo/env"

. "$HOME/.local/share/../bin/env"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Add local bin directory to PATH
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.local/share/mise/installs/node/25.0.0/bin:$HOME/.local/share/mise/installs/python/3.14.4/bin:$HOME/coding/yt-pl-dl:$HOME/.local/share/mise/installs/go/1.26.2/bin:$HOME/.cargo/bin:$HOME/.local/share/mise:$HOME/.local/share/omarchy/bin:$HOME/bin:/usr/local/bin:$HOME/.local/share/pnpm/bin:$HOME/.local/share/mise/shims:/usr/bin:$HOME/.local/share/../bin:/usr/local/sbin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

# nvpm
export NVPM_HOME="$HOME/.config/nvpm"
source <(nvpm env)

# sesh
alias tm="sesh connect dotfiles"

# peon-ping quick controls (desktop only)
if [ "$MISE_ENV" = "desktop" ] && [ -f "$HOME/.claude/hooks/peon-ping/peon.sh" ]; then
  alias peon="bash $HOME/.claude/hooks/peon-ping/peon.sh"
  [ -f "$HOME/.claude/hooks/peon-ping/completions.bash" ] && source "$HOME/.claude/hooks/peon-ping/completions.bash"
fi
