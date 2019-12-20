#!/bin/bash

readonly ERR_INVALID_USAGE=2

# Fail fast and be aware of exit codes
set -eo pipefail

# Exposes unset variables
set -o nounset

oops() {
    echo "$0:" "$@" >&2
    exit 1
}

show_usage() {
	cat <<-EOF
		Usage: $(basename $0) COMMAND

		Commands:
		    -h|--help       Shows usage
		    -v|--version    Shows version
	EOF
}

usage() {
	show_usage
	exit $ERR_INVALID_USAGE
}

process() {
    for c in $(seq 1 "$2"); do
        outmp="$1"_col_"$c".txt
        tail -n +2 "$1" | cut -f"$c" -d";" > "$outmp"
        cat "$outmp" >> "$3"
        rm -f "$outmp"
    done
}

main() {
	[[ "$#" != 2 ]] && usage
    infile=$1
    maxcol=$2
    timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    outfile="joined_$timestamp.txt"
    process "$infile" "$maxcol" "$outfile"
    printf "Output file written in %s\n" "$outfile"
    linecount=$(wc -l "$outfile")
    printf "Lines: %s\n" "$linecount" 
}

main $*
