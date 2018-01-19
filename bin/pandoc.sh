#!/usr/bin/env bash
set -e
dir=$(dirname $(readlink -f $0))
cd ${dir}/../src

cmd() {
  echo "$ $@"
  "$@"
}

cmd pandoc \
-N -s \
--reference-links --reference-location=document \
--bibliography=bibliography.bib \
--template=template.latex \
--listings \
--filter pandoc-include-code \
metadata.yml \
*.md \
"$@"
