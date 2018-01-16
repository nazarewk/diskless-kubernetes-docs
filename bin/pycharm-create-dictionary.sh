#!/usr/bin/env bash
dir=$(dirname $(readlink -f $0))
cd ${dir}/..
# pacman -S aspell-pl
aspell --lang pl dump master | aspell --lang pl expand | tr ' ' '\n' > dictionaries/pl.dic