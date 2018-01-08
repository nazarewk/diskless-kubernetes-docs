#!/usr/bin/env bash
dir=$(dirname $(readlink -f $0))
cd ${dir}/..
pandoc -N -s metadata.yml markdown/*.md --toc "$@"
