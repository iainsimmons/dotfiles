# base16-fish-shell (https://github.com/FabioAntunes/base16-fish-shell)
# Inspired by base16-shell (https://github.com/chriskempson/base16-shell)
# Kimber scheme by Mishka Nguyen (https://github.com/akhsiM)

function base16-kimber -d "base16 Kimber theme"
    set options (fish_opt --short=t --long=test)
    argparse $options -- $argv

    # colors
    set color00 "22/22/22" # Base 00 - Black
    set color01 "c8/8c/8c" # Base 08 - Red
    set color02 "99/c8/99" # Base 0B - Green
    set color03 "d8/b5/6d" # Base 0A - Yellow
    set color04 "53/7c/9c" # Base 0D - Blue
    set color05 "86/ca/cd" # Base 0E - Magenta
    set color06 "78/b4/b4" # Base 0C - Cyan
    set color07 "de/de/e7" # Base 05 - White
    set color08 "64/46/46" # Base 03 - Bright Black
    set color09 $color01 # Base 08 - Bright Red
    set color10 $color02 # Base 0B - Bright Green
    set color11 $color03 # Base 0A - Bright Yellow
    set color12 $color04 # Base 0D - Bright Blue
    set color13 $color05 # Base 0E - Bright Magenta
    set color14 $color06 # Base 0C - Bright Cyan
    set color15 "ff/ff/e6" # Base 07 - Bright White
    set color16 "47/6c/88" # Base 09
    set color17 "70/4f/4f" # Base 0F
    set color18 "31/31/31" # Base 01
    set color19 "55/5d/55" # Base 02
    set color20 "5a/5a/5a" # Base 04
    set color21 "c3/c3/b4" # Base 06
    set color_foreground "de/de/e7" # Base 05
    set color_background "22/22/22" # Base 00

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
        __put_template_custom Pg dedee7 # foreground
        __put_template_custom Ph 222222 # background
        __put_template_custom Pi dedee7 # bold color
        __put_template_custom Pj 555d55 # selection color
        __put_template_custom Pk dedee7 # selected text color
        __put_template_custom Pl dedee7 # cursor
        __put_template_custom Pm 222222 # cursor text

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
        set -gx fish_color_command "537c9c" blue
        set -gx fish_color_quote "99c899" green
        set -gx fish_color_redirection "d8b56d" yellow
        set -gx fish_color_end "78b4b4" cyan
        set -gx fish_color_error "c88c8c" red
        set -gx fish_color_param "c3c3b4" cyan
        set -gx fish_color_comment "644646" brblack
        set -gx fish_color_match --background=brblue
        set -gx fish_color_selection "dedee7" white --bold --background=brblack
        set -gx fish_color_search_match "d8b56d" bryellow --background=brblack
        set -gx fish_color_history_current --bold
        set -gx fish_color_operator "78b4b4" cyan
        set -gx fish_color_escape "78b4b4" cyan
        set -gx fish_color_cwd "99c899" green
        set -gx fish_color_cwd_root "c88c8c" red
        set -gx fish_color_valid_path --underline
        set -gx fish_color_autosuggestion "644646" brblack
        set -gx fish_color_user "99c899" brgreen
        set -gx fish_color_host normal
        set -gx fish_color_cancel -r
        set -gx fish_pager_color_completion normal
        set -gx fish_pager_color_description "d8b56d" yellow
        set -gx fish_pager_color_prefix "dedee7" white --bold --underline
        set -gx fish_pager_color_progress "ffffe6" brwhite --background=cyan
    end

    __base16_fish_shell_set_background "22" "22" "22"
    __base16_fish_shell_create_vimrc_background kimber
    set -U base16_fish_theme kimber

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
