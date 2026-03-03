#!/usr/bin/env bash
export LANG=C
export LC_ALL=C
[ -n "$TOPDIR" ] && cd $TOPDIR

try_version() {
	[ -f version ] || return 1
	REV="$(cat version)"
	[ -n "$REV" ]
}

try_git() {
	git rev-parse --git-dir >/dev/null 2>&1 || return 1

	TAG="$(git describe --tags --abbrev=0 2>/dev/null)"
	HASH="$(git rev-parse --short HEAD 2>/dev/null)"

	if [ -n "$TAG" ] && [ -n "$HASH" ]; then
		REV="${TAG}-${HASH}"
	elif [ -n "$HASH" ]; then
		REV="${HASH}"
	else
		return 1
	fi

	[ -n "$REV" ]
}

try_version || try_git || REV="unknown"
echo "$REV"
