#!/bin/bash

set -euo pipefail

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

input_file=cv.tex
pdf_name="Michael Darwish - CV"
pdf_sample_name="${pdf_name} - Sample"
screenshot_name=screenshot

is_sample=
for arg in "$@"; do
    case "$arg" in
    -h|-help|--help)
        echo "Usage: $0 [--sample]" >& 2
        exit 1
        ;;
    -s|-sample|--sample)
        is_sample=1
        ;;
    *)
        echo "Unknown argument '$arg'" >& 2
        exit 1
        ;;
    esac
done

if [[ "$is_sample" == 1 ]]; then
    lualatex -jobname="$pdf_sample_name" "\def\issample{1} \input{$input_file}"
    pdftoppm "${pdf_sample_name}.pdf" "$screenshot_name" -png -singlefile
else
    lualatex -jobname="$pdf_name" "$input_file"
fi
