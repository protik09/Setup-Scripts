#!/usr/bin/env bash
#
# Script to update the git repos everyday
#
# Author - Protik Banerji <protik.banerji@teamindus.in>

git pull
ls -R --directory --color=never */.git | sed 's/\/.git//' | xargs -P10 -I{} git -C {} pull
git pull
