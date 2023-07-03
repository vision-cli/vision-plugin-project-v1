#!/bin/bash
# Recursively finds all directories with a go.mod file and any changes.
# Outputs a GitHub Actions JSON output with all workdirs found. This is used by the linter action.

echo "Resolving modules in $(pwd)"

workdir_in_diff() {
    SUB="${1#./}"
    if [ -z "${2##*$SUB*}" ] && [ -n "$2" ] ; then
        printf '{\"workdir\":\"%s\"},' $1
    fi
}

export -f workdir_in_diff

git fetch origin master:master
DIFF=$(git --no-pager diff --name-only master...HEAD)
PATHS=$(find . -mindepth 2 -not -path "*/vendor/*" -type f -name go.mod -printf '%h\n' | xargs -I {} bash -c 'workdir_in_diff {} "$*"' _ "$DIFF")
echo "matrix={\"include\":[${PATHS%?}]}" >> $GITHUB_OUTPUT
