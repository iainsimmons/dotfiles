# macOS-only: Homebrew paths. Inert on Linux (fish sources all conf.d files,
# but /opt/homebrew only exists on Apple Silicon macOS).
if test (uname) = Darwin
    fish_add_path /opt/homebrew/sbin /opt/homebrew/bin
    if test -x /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv | source
    end
end