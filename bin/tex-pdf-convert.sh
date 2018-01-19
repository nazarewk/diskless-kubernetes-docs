#!/usr/bin/env bash
dir=$(dirname $(readlink -f $0))
$(dirname $(readlink -f $0))/pandoc.sh -o ../dist/output.tex
