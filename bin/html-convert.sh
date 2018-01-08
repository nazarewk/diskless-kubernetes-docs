#!/usr/bin/env bash
dir=$(dirname $(readlink -f $0))
$(dirname $(readlink -f $0))/pandoc.sh -t html5 -o dist/output.html --self-contained
