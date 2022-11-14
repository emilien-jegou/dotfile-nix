#!/usr/bin/env bash

set -e

ARGS=($@)
FROM=${ARGS[0]:=origin/master}

echo "-- fixup $FROM..HEAD"

#echo "here:" ${ARGS[@]:2}

GITLOG=$(git log "$FROM..HEAD" --pretty=format:'%h %s\n' --no-merges | grep -v 'fixup!')
FZF_HEIGHT=$(echo -e $GITLOG | wc -l | xargs expr 1 + )

COMMIT_HASH=$(echo -e $GITLOG \
  | fzf --height=$FZF_HEIGHT \
	| cut -c -7)

echo -- git commit --fixup ${ARGS[@]:2} $COMMIT_HASH
git commit --fixup ${ARGS[@]:2} $COMMIT_HASH
