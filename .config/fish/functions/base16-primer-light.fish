# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Primer Light scheme by Jimmy Lin

function base16-primer-light -d "base16 Primer Light theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "fa/fb/fc" # Base 00 - Black
    set color01 "d7/3a/49" # Base 08 - Red
    set color02 "28/a7/45" # Base 0B - Green
    set color03 "ff/d3/3d" # Base 0A - Yellow
    set color04 "03/66/d6" # Base 0D - Blue
    set color05 "ea/4a/aa" # Base 0E - Magenta
    set color06 "79/b8/ff" # Base 0C - Cyan
    set color07 "2f/36/3d" # Base 05 - White
    set color08 "95/9d/a5" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "1b/1f/23" # Base 07 - Bright White
    set color16 "f6/6a/0a" # Base 09
    set color17 "a0/41/00" # Base 0F
    set color18 "e1/e4/e8" # Base 01
    set color19 "d1/d5/da" # Base 02
    set color20 "44/4d/56" # Base 04
    set color21 "24/29/2e" # Base 06
    set color_foreground "2f/36/3d" # Base 05
    set color_background "fa/fb/fc" # Base 00

    # 16 color space
    __put_template 0  $color00
    __put_template 1  $color01
    __put_template 2  $color02
    __put_template 3  $color03
    __put_template 4  $color04
    __put_template 5  $color05
    __put_template 6  $color06
    __put_template 7  $color07
    __put_template 8  $color08
    __put_template 9  $color09
    __put_template 10 $color10
    __put_template 11 $color11
    __put_template 12 $color12
    __put_template 13 $color13
    __put_template 14 $color14
    __put_template 15 $color15

    # 256 color space
    __put_template 16 $color16
    __put_template 17 $color17
    __put_template 18 $color18
    __put_template 19 $color19
    __put_template 20 $color20
    __put_template 21 $color21

    # foreground / background / cursor color
    if test -n "$ITERM_SESSION_ID"
        # iTerm2 proprietary escape codes
        __put_template_custom Pg 2f363d # foreground
        __put_template_custom Ph fafbfc # background
        __put_template_custom Pi 2f363d # bold color
        __put_template_custom Pj d1d5da # selection color
        __put_template_custom Pk 2f363d # selected text color
        __put_template_custom Pl 2f363d # cursor
        __put_template_custom Pm fafbfc # cursor text

    else
        __put_template_var 10 $color_foreground
        if test "$BASE16_SHELL_SET_BACKGROUND" != false
            __put_template_var 11 $color_background
            if string match -q -- '*rxvt*' $TERM
                __put_template_var 708 $color_background # internal border (rxvt)
            end
        end
        __put_template_custom 12 ";7" # cursor (reverse video)
    end

    if test -z $base16_fish_shell_disable_prompt_colors
        set -gx fish_color_normal normal
        set -gx fish_color_command "0366d6" blue
        set -gx fish_color_quote "28a745" green
        set -gx fish_color_redirection "ffd33d" yellow
        set -gx fish_color_end "79b8ff" cyan
        set -gx fish_color_error "d73a49" red
        set -gx fish_color_param "24292e" cyan
        set -gx fish_color_comment "959da5" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "2f363d" white --bold --background=brblack
        set -gx fish_color_search_match "ffd33d" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "79b8ff" cyan
        set -gx fish_color_escape "79b8ff" cyan
        set -gx fish_color_cwd "28a745" green
        set -gx fish_color_cwd_root "d73a49" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "959da5" brblack
        set -gx fish_color_user "28a745" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "ffd33d" yellow
        set -gx fish_pager_color_prefix "2f363d" white --bold --underline
        set -gx fish_pager_color_progress "1b1f23" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "fa" "fb" "fc"
    __base16_fish_shell_create_vimrc_background primer-light
    set -U base16_fish_theme primer-light

    if test -n "$_flag_t"
        set base16_colors_hex
        set padded_seq_values (seq -w 0 21)
        for seq_value in $padded_seq_values
            set -l color "color$seq_value"
            set base16_colors_hex $base16_colors_hex (string replace -a / "" $$color)
        end

        __base16_fish_shell_color_test $base16_colors_hex
    end
end
