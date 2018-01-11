#!/usr/bin/env bash
bin=$(dirname $(readlink -f $0))
dyplom=LATEX_dyplom
ignore=${dyplom}/.gitignore
ignore_line="!$1"
link_to="src/$1"
cd ${bin}/..
#grep "${ignore_line}" ${ignore} || echo "${ignore_line}" >> ${ignore}
[ -f "${link_to}" ] || ln -s ../${dyplom}/$1 ${link_to}
git add ${link_to}