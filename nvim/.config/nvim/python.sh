#!/usr/bin/env bash
set -e

file="$1"

file="$(cygpath -u "$file" 2>/dev/null)"


python -u "$file"


# FILE_PATH="$1"  
# exec python -u "$FILE_PATH"
