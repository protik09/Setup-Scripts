#!/usr/bin/env bash
#
# Script to setup atom packages
#
# Author - Protik Banerji <protik.banerji@teamindus.in>
#

# Install python dependencies for atom packages
pip install --upgrade pylint flake8 autopep8

# Install atom tool packages
apm install --upgrade atom-beautify
apm install --upgrade autocomplete-clang autocomplete-python
apm install --upgrade busy busy-signal intentions
apm install --upgrade file-icons
apm install --upgrade language-batchfile language-ini language-matlab
apm install --upgrade linter linter-gcc linter-matlab linter-pylint linter-ui-default
apm install --upgrade minimap tool-bar

# Instal atom theme packages
apm install --upgrade atom-material-ui atom-material-syntax 
apm install --upgrade ariake-dark-syntax gruvbox-plus-syntax
apm install --upgrade aurora-theem ramda-syntax
apm install --upgrade nord-atom-syntax nord-atom-ui