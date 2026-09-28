# Source uv's standalone-installer env (~/.local/bin/env.fish) when present.
# mise-managed uv (shared in config.toml) does not need this; inert otherwise.
if test -f "$HOME/.local/bin/env.fish"
    source "$HOME/.local/bin/env.fish"
end
