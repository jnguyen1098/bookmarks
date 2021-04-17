#!/usr/bin/env bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 readme bookmarks"
    exit 1
fi

diff <(sort <(sed -nr 's/- \[[^]]*\]\(\s*([^)]*)\s*\).*$/\1/p' "$1")) <(sort "$2")
