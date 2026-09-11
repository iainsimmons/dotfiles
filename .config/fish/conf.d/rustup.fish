# Linux-only: rustup-managed cargo env. Inert on macOS.
if test (uname) != Darwin && test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end
