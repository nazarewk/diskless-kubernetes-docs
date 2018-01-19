#!/usr/bin/env bash
set -e
dir=$(dirname $(readlink -f $0))
cd ${dir}/..
docker build . -t ${1:-pandoc-local}