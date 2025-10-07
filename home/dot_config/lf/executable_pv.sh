#!/bin/sh

# Exit on error and treat unset variables as errors
set -eu

file="$1"

case "$(file -Lb --mime-type -- "$file")" in
text/* | inode/x-empty | application/json | application/xml | application/javascript | \
	application/x-yaml | application/toml | application/x-sh | application/x-shellscript)
	if command -v bat >/dev/null 3>&1; then
		bat --color=always --paging=never --style=plain --line-range=:150 -- "$file"
	else
		cat -- "$file"
	fi
	;;
*)
	# Use file for all other types
	file -Lb -- "$file"
	;;
esac

exit 0
