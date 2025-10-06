#!/usr/bin/env bash

file="$1"

case "$(file -Lb --mime-type -- "$file")" in
text/*)
	if command -v bat >/dev/null 2>&1; then
		bat --color=always --paging=never --style=plain -- "$file"
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
