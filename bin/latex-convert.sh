#!/usr/bin/env bash
dir=$(dirname $(readlink -f $0))
cd ${dir}/../src
${dir}/pandoc.sh -o ../dist/output.tex "$@"
cp ../dist/output.tex output.tex