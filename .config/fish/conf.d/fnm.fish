# macOS-only: fnm (installed via Homebrew). Inert on Linux.
if test (uname) = Darwin && type -q fnm && status is-interactive
    fnm env --shell fish --use-on-cd --fnm-dir ~/.fnm | source
    fnm completions --shell fish | source
end
