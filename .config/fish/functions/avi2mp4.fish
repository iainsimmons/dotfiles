function avi2mp4 --description 'Convert AVI to MP4 (H.264/AAC) for Android, iOS and Instagram'
    argparse --name=avi2mp4 'h/help' 's/size=' 'c/crf=' -- $argv
    or return

    if set -q _flag_help
        echo "Usage: avi2mp4 [options] <input.avi> [output.mp4]"
        echo
        echo "Convert AVI to an MP4 that plays natively on Android/iOS and uploads cleanly to Instagram."
        echo
        echo "Options:"
        echo "  -s, --size N   Max width in px, height auto (even), 30 fps cap (default: 1080)"
        echo "  -c, --crf N    x264 quality, lower is better (default: 22)"
        echo "  -h, --help     Show this help"
        return
    end

    if test (count $argv) -eq 0
        echo "avi2mp4: missing input file (see --help)" >&2
        return 1
    end

    set -l input $argv[1]
    set -l output $argv[2]
    set -l size 1080
    set -l crf 22

    set -q _flag_size; and set size $_flag_size
    set -q _flag_crf; and set crf $_flag_crf

    if not test -f "$input"
        echo "avi2mp4: no such file: $input" >&2
        return 1
    end

    if test -z "$output"
        set output (path change-extension mp4 $input)
    end

    ffmpeg -i "$input" \
        -c:v libx264 -preset slow -crf $crf \
        -profile:v high -pix_fmt yuv420p -tag:v avc1 \
        -vf "fps=30,scale='min($size,iw)':-2:flags=lanczos" \
        -c:a aac -b:a 192k -ac 2 -ar 48000 \
        -movflags +faststart \
        "$output"
end
