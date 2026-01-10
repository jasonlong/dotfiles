function merge-mp3s
    set out $argv[1]
    test -n "$out"; or set out audiobook.mp3

    set list (mktemp -t mp3listXXXX.txt)

    for f in *.mp3
        test -f "$f"; or continue
        set p (realpath "$f")
        # Escape single quotes for the concat list: file '<path>'
        # NOTE: only ONE '--' (end of options) before $p; no extra '--'!
        set p_esc (string replace -a -- "'" "'\\''" "$p")
        echo "file '$p_esc'" >>$list
    end

    if test (wc -l < $list) -eq 0
        echo "No .mp3 files found."
        rm $list
        return 1
    end

    # Merge to mono @ 64 kbps (great for audiobooks)
    ffmpeg -hide_banner -nostdin -f concat -safe 0 -i $list -ac 1 -c:a libmp3lame -b:a 64k "$out"
    set code $status
    rm $list
    return $code
end
