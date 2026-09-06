# macOS-only: rustup-managed cargo env. Inert on Linux (cargo is installed via
# pacman there and added to PATH by config.fish).
if test (uname) = Darwin && test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end
