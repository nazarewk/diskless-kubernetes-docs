#!/usr/bin/env bash
dir=$(dirname $(readlink -f $0))
${dir}/pandoc.sh -o ../dist/output.pdf
