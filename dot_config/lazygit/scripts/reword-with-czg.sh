#!/bin/bash
set -e

COMMIT_SHA="$1"
CURRENT_HEAD=$(git rev-parse HEAD)

echo "Target commit: $COMMIT_SHA"
echo "Current HEAD: $CURRENT_HEAD"

if [ "$COMMIT_SHA" = "$CURRENT_HEAD" ]; then
	echo "Amending HEAD commit"
	git czg --allow-empty --only --amend
else
	echo "Rebasing to reword commit ${COMMIT_SHA}"
	# Check OS for sed syntax
	if [ "$(uname)" = "Darwin" ]; then
		# macOS (BSD sed)
		GIT_SEQUENCE_EDITOR='sed -i "" "1s/pick/edit/"' git rebase -i "${COMMIT_SHA}~1"
	else
		# Linux (GNU sed)
		GIT_SEQUENCE_EDITOR='sed -i "1s/pick/edit/"' git rebase -i "${COMMIT_SHA}~1"
	fi
	git rebase -i "${COMMIT_SHA}~1"
	echo "Running czg amend"
	git czg --allow-empty --only --amend
	echo "Continuing rebase"
	git rebase --continue
fi
