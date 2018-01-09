#!/usr/bin/env bash
dir=$(dirname $(readlink -f $0))
cd ${dir}/..
pandoc \
-N \
--reference-links --reference-location=document \
--template=src/template \
-s src/metadata.yml \
--bibliography=src/bibliography.bib \
src/*.md \
"$@"
