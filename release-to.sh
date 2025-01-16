#!/usr/bin/env bash

set -e

if [ "$#" -ne 1 ]; then
    echo "ERROR: No target package directory specified."
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "ERROR: Specified target is not a directory."
    exit 2
fi

if [ ! -f "./typst.toml" ]; then
    echo "ERROR: No typst.toml package manifest found in current directory."
    exit 3
fi

VERSION="$(grep 'version' ./typst.toml | cut -d'"' -f2)"
DEST="$1/$VERSION"

if [ -d "$DEST" ]; then
    echo "ERROR: Target directly already has version $VERSION."
    exit 4
fi


mkdir "$DEST"
git ls-files -z | grep -zv "release-to.sh" | rsync -a --files-from=- --from0 ./ "$DEST"

echo "Success! Released version $VERSION"
