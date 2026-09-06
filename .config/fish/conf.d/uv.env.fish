# Source uv's env (installed to ~/.local/bin/env.fish) when present, on any
# platform. Inert on Linux dev boxes that don't use uv.
if test -f "$HOME/.local/bin/env.fish"
    source "$HOME/.local/bin/env.fish"
end
