#!/usr/bin/env bash
set -e
dir=$(dirname $(readlink -f $0))
cd ${dir}/../src
src=$(pwd)
image_name=pandoc-local

cmd() {
  echo "$ $@"
  "$@"
}

run_pandoc () {
  if [[ "$(docker images -q ${image_name} 2> /dev/null)" == "" ]]; then
    ../bin/build-pandoc.sh ${image_name}
  fi
  local opts
#  opts="${opts} --user $(id -u)"
  opts="${opts} -v ${src}/../dist:/dist"
  opts="${opts} -v ${src}/:/source/:ro"
  opts="${opts} -v ${src}/kubernetes-cluster/:/source/kubernetes-cluster:ro"
  opts="${opts} -v ${src}/ipxe-boot/:/source/ipxe-boot:ro"
  opts="${opts} --rm"
  cmd docker run ${opts} ${image_name} "$@"
}

run_pandoc \
-N -s \
--reference-links --reference-location=document \
--bibliography=bibliography.bib \
--template=template.latex \
--listings \
--filter pandoc-include-code \
metadata.yml \
*.md \
"$@"
