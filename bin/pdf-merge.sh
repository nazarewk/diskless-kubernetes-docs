#!/usr/bin/env bash
set -e
dir=$(dirname $(readlink -f $0))
cd ${dir}/../dist

cmd() {
  echo "$ $@"
  "$@"
}

cmd pdftk output.pdf merge_*.pdf cat output merged.pdf
