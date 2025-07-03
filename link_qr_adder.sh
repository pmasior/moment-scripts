[ $# -eq 3 ] || { echo '$link_under_qr $input_svg_filename $output_svg_filename'; return 1 2>/dev/null || exit 1;}

link_under_qr="$1" # 'http://example.com/q/1234'
input_svg_filename="$2" # 'input.svg'
output_svg_filename="$3" # 'output.svg'

sed -E \
    -e 's|height=["0-9]+|height="535"|' \
    -e 's|<rect [^>]*fill="#fff"[^>]*/>||' \
    -e 's|</svg>|<text x="17" y="516" font-size="24" font-family="Afacad Flux" font-weight="400">_insert_link_under_qr</text>\n</svg>\n|' \
    -e "s|_insert_link_under_qr|$link_under_qr|" $input_svg_filename | \
    inkscape --pipe --export-text-to-path --export-filename=$output_svg_filename
