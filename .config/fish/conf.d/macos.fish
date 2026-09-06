# macOS-only environment extras, functions and abbreviations (ported from the
# `main` branch's config.fish). Everything here is gated on Darwin so the
# file is a safe no-op on Linux. Because conf.d files are sourced before
# config.fish, values that config.fish sets unconditionally (e.g. PNPM_HOME)
# are guarded there by a Darwin check so they don't override these.
if test (uname) = Darwin

    # direnv (macOS: activated via brew's direnv)
    status is-interactive; and direnv hook fish | source

    # Cloudflare corporate CA (used by work tooling).
    set -gx NODE_EXTRA_CA_CERTS /usr/local/share/ca-certificates/Cloudflare_CA.pem

    # macOS pnpm global binaries (brew pnpm + corepack).
    set -gx PNPM_HOME "$HOME/Library/pnpm"
    fish_add_path "$PNPM_HOME"

    # Go (installed via Homebrew on macOS).
    fish_add_path "$HOME/go/bin"

    # Python via pyenv on macOS.
    fish_add_path "$HOME/.pyenv/shims"
    set -gx PYTHON python

    # Convert CSV to PSV (pipe-separated-values).
    function csv2psv -d "Convert CSV to PSV (pipe-separated-values)" -a input_file -a output_file
        mlr --icsv --ocsv --ofs pipe cat "$input_file" >"$output_file"
    end

    # URL-encode a string.
    function urlencode -d "URL Encode String" -a str
        echo "$str" | jq -sRr @uri | string replace "%2B" "+" | string replace "%0A" ""
    end

    # Hide/show all desktop icons (useful when presenting).
    abbr hidedesktop 'defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
    abbr showdesktop 'defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

    # brew bundle dump (regenerates the Brewfile).
    abbr bbd 'cd ~/dotfiles/ && brew bundle dump --force'

    # Privileges (temporary admin rights).
    abbr admin '/Applications/Privileges.app/Contents/Resources/PrivilegesCLI --add'
    abbr privileges '/Applications/Privileges.app/Contents/Resources/PrivilegesCLI --add'

    # macOS DNS cache flush.
    abbr flushDNS 'dscacheutil -flushcache'
    abbr flushDNS_all 'dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

end
