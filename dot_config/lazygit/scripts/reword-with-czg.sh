#!/usr/bin/env bash

set -e

COMMIT_SHA="$1"
CURRENT_HEAD=$(git rev-parse HEAD)

echo "Target commit: $COMMIT_SHA"
echo "Current HEAD: $CURRENT_HEAD"

if [ "$COMMIT_SHA" = "$CURRENT_HEAD" ]; then
	echo "Amending HEAD commit"
	git czg --allow-empty --only --amend
else
	# Create a more robust sequence editor script
	cat >/tmp/git-sequence-editor.sh <<'EOF'
#!/bin/bash
# Find the first line starting with "pick" and change it to "edit"
awk '{
    if (!changed && /^pick /) {
        sub(/^pick/, "edit")
        changed = 1
    }
    print
}' "$1" > "$1.tmp" && mv "$1.tmp" "$1"
EOF
	chmod +x /tmp/git-sequence-editor.sh
	CUSTOM_GIT_SEQUENCE_EDITOR="/tmp/git-sequence-editor.sh"

	# Check if it's the first commit (no parent)
	if ! git rev-parse --verify "${COMMIT_SHA}~1" >/dev/null 2>&1; then
		echo "Rebasing first commit with --root (like LazyGit)"
		GIT_SEQUENCE_EDITOR="${CUSTOM_GIT_SEQUENCE_EDITOR}" git rebase --interactive --autostash --keep-empty --no-autosquash --rebase-merges --root
		echo "Running czg amend"
		git czg --allow-empty --only --amend
		echo "Continuing rebase"
		git rebase --continue
	else
		echo "Rebasing to reword commit ${COMMIT_SHA}"
		GIT_SEQUENCE_EDITOR="${CUSTOM_GIT_SEQUENCE_EDITOR}" git rebase --interactive --autostash --keep-empty --no-autosquash --rebase-merges "${COMMIT_SHA}~1"
		echo "Running czg amend"
		git czg --allow-empty --only --amend
		echo "Continuing rebase"
		git rebase --continue
	fi

	# Clean up
	rm -f /tmp/git-sequence-editor.sh
fi
