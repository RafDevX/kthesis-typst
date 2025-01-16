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

if [ -d "$1/$VERSION" ]; then
    echo "ERROR: Target directly already has version $VERSION."
    exit 4
fi

mkdir "$1/$VERSION"
git ls-files | grep -v "release-to.sh" | xargs cp -t "$1/$VERSION"

echo "Success! Released version $VERSION"
