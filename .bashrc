# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# Add local bin directory to PATH
export PATH=/home/iain/.local/bin:/home/iain/.local/share/mise/installs/codex/latest/bin:/home/iain/.local/share/mise/installs/node/26.7.0/bin:/home/iain/.local/share/mise/installs/opencode/latest:/usr/share/omarchy/bin:/home/iain/.local/share/mise/shims:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/iain/.local/share/mise/shims:/home/iain/.local/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

# nvpm
export NVPM_HOME=/home/iain/.config/nvpm
source <(nvpm env)

