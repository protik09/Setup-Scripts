#!/bin/bash

gitserver_ip='10.10.0.26'
fsw_repo='/axiom/flight-software/depot'

cd ~/Projects
git clone $USER@$gitserver_ip:$fsw_repo/CUnit.git
git clone $USER@$gitserver_ip:$fsw_repo/PrRover.git
git clone $USER@$gitserver_ip:$fsw_repo/AtmelTraining.git
git clone $USER@$gitserver_ip:$fsw_repo/LfswBuildScripts.git
git clone $USER@$gitserver_ip:$fsw_repo/FlightSoftwareDocuments.git
git clone $USER@$gitserver_ip:/axiom/flight-dynamics/depot/modular.git
git clone $USER@$gitserver_ip:/axiom/lander-pcoc/depot/panguWrapper.git
