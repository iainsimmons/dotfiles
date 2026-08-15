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
export PATH=/home/iain/.opencode/bin:$PATH

# Add local bin directory to PATH
export PATH=/home/iain/bin:/home/iain/.local/bin:/home/iain/.local/share/mise/installs/node/25.0.0/bin:/home/iain/.local/share/mise/installs/python/3.14.4/bin:/home/iain/coding/yt-pl-dl:/home/iain/.local/share/mise/installs/go/1.26.2/bin:/home/iain/.cargo/bin:/home/iain/.local/share/mise:/home/iain/.local/share/omarchy/bin:/home/iain/bin:/usr/local/bin:/home/iain/.local/share/pnpm/bin:/home/iain/.local/share/mise/shims:/usr/bin:/home/iain/.local/share/../bin:/usr/local/sbin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

# nvpm
export NVPM_HOME=/home/iain/.config/nvpm
source <(nvpm env)


# peon-ping quick controls
alias peon="bash /home/iain/.claude/hooks/peon-ping/peon.sh"
[ -f /home/iain/.claude/hooks/peon-ping/completions.bash ] && source /home/iain/.claude/hooks/peon-ping/completions.bash
