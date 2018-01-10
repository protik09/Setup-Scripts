#!/bin/bash

gitserver_ip='10.10.0.26'
fsw_repo='/axiom/flight-software/depot'

git clone $USER@$gitserver_ip:$fsw_repo/LfswTest.git
cd LfswTest
/bin/bash git_init_all.sh
/bin/bash git_update_all.sh

cd ~/Projects
git clone $USER@$gitserver_ip:$fsw_repo/PrRover.git
git clone $USER@$gitserver_ip:$fsw_repo/AtmelTraining.git
git clone $USER@$gitserver_ip:$fsw_repo/LfswInterfaceSimulator.git
git clone $USER@$gitserver_ip:$fsw_repo/FlightSoftwareDocuments.git
