# fnm
set PATH /opt/homebrew/bin $PATH
if type fnm -q && status is-interactive
    fnm env --shell fish --use-on-cd --fnm-dir ~/.fnm | source
    fnm completions --shell fish | source
end
