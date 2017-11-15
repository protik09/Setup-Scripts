#!/usr/bin/env bash
#
# Script to update the git repos everyday
#
# Author - Protik Banerji <protik.banerji@teamindus.in>

# cd FlightSoftwareDocuments
# git pull
# cd ..
#
# cd LanderFlightSoftware
# git pull
# cd ..
#
# cd LfswInterfaceSimulator
# git pull
# cd ..
#
# cd PrRover
# git pull
# cd ..
ls -R --directory --color=never */.git | sed 's/\/.git//' | xargs -P10 -I{} git -C {} pull
