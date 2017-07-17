#!/usr/bin/env bash
#
# Script to initilaize and fix link remote submodules
#
# Author - Protik Banerji <protik.banerji@teamindus.in>

git submodule init
git submodule update
ls -R --directory --color=never */.git | sed 's/\/.git//' | xargs -P10 -I{} git -C {} checkout master
