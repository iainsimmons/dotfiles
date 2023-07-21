# fnm
set PATH "/Users/isimmons/Library/Application\ Support/fnm" $PATH
if type fnm -q && status is-interactive
    fnm env --shell fish --use-on-cd --fnm-dir ~/.fnm | source
    fnm completions --shell fish | source
end
