FROM quay.io/nordicesmhub/cesm_libs:latest

#####EXTRA LABELS#####
LABEL autogen="no" \ 
    software="CESM" \ 
    version="2" \
    software.version="2.1.1" \ 
    about.summary="Community Earth System Model" \ 
    base_image="quay.io/nordicesmhub/cesm_libs" \
    about.home="http://www.cesm.ucar.edu/models/simpler-models/N1850/index.html" \
    about.license="Copyright (c) 2017, University Corporation for Atmospheric Research (UCAR). All rights reserved." 
      
MAINTAINER Anne Fouilloux <annefou@geo.uio.no>

ENV USER=root
ENV HOME=/root

RUN mkdir -p $HOME/.cime \
             $HOME/work \
             $HOME/inputdata \
             $HOME/archive \
             $HOME/cases 

COPY config_files/* $HOME/.cime/

RUN cd $HOME \
    && git clone -b release-cesm2.1.1 https://github.com/ESCOMP/CESM.git \
    && cd CESM \
    && sed -i.bak "s/'checkout'/'checkout', '--trust-server-cert', '--non-interactive'/" ./manage_externals/manic/repository_svn.py \
    && ./manage_externals/checkout_externals

ENV CESM_PES=12

## Case-1: NTASK=$CESM_PES

RUN CASE=case1 && \
    sed -i -e "s/\$CESM_PES/$CESM_PES/g" $HOME/.cime/config_machines.xml \
    && cd $HOME/CESM/cime/scripts \
    && ./create_newcase --case $HOME/cases/F1850$CASE --compset F1850 \
    --res f19_g17 --machine espresso --run-unsupported && \
    cd $HOME/cases/F1850$CASE                          && \
    NUMNODES=-1                                   && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES} && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1 && \
    ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0 && \
    ./case.setup && ./case.build
    

## Case-2: NTASK=$CESM_PES*2

RUN CASE=case2 && \
    sed -i -e "s/\$CESM_PES/$CESM_PES/g" $HOME/.cime/config_machines.xml \
    && cd $HOME/CESM/cime/scripts \
    && ./create_newcase --case $HOME/cases/F1850$CASE --compset F1850 \
    --res f19_g17 --machine espresso --run-unsupported && \
    cd $HOME/cases/F1850$CASE                          && \
    NUMNODES="$((2*$CESM_PES))"                                   && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES} && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1 && \
    ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0 && \
    ./case.setup && ./case.build

## Case-3: NTASK=$CESM_PES*3

RUN CASE=case3 && \
    sed -i -e "s/\$CESM_PES/$CESM_PES/g" $HOME/.cime/config_machines.xml \
    && cd $HOME/CESM/cime/scripts \
    && ./create_newcase --case $HOME/cases/F1850$CASE --compset F1850 \
    --res f19_g17 --machine espresso --run-unsupported && \
    cd $HOME/cases/F1850$CASE                          && \
    NUMNODES="$((3*$CESM_PES))"                                   && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES} && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1 && \
    ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0 && \
    ./case.setup && ./case.build

## Case-4: NTASK=$CESM_PES*4

RUN CASE=case4 && \
    sed -i -e "s/\$CESM_PES/$CESM_PES/g" $HOME/.cime/config_machines.xml \
    && cd $HOME/CESM/cime/scripts \
    && ./create_newcase --case $HOME/cases/F1850$CASE --compset F1850 \
    --res f19_g17 --machine espresso --run-unsupported && \
    cd $HOME/cases/F1850$CASE                          && \
    NUMNODES="$((4*$CESM_PES))"                                   && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES} && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1 && \
    ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0 && \
    ./case.setup && ./case.build

## Case-5: NTASK=$CESM_PES*5

RUN CASE=case5 && \
    sed -i -e "s/\$CESM_PES/$CESM_PES/g" $HOME/.cime/config_machines.xml \
    && cd $HOME/CESM/cime/scripts \
    && ./create_newcase --case $HOME/cases/F1850$CASE --compset F1850 \
    --res f19_g17 --machine espresso --run-unsupported && \
    cd $HOME/cases/F1850$CASE                          && \
    NUMNODES="$((5*$CESM_PES))"                                   && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES} && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1 && \
    ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0 && \
    ./case.setup && ./case.build

## Case-6: NTASK=$CESM_PES*6

RUN CASE=case6 && \
    sed -i -e "s/\$CESM_PES/$CESM_PES/g" $HOME/.cime/config_machines.xml \
    && cd $HOME/CESM/cime/scripts \
    && ./create_newcase --case $HOME/cases/F1850$CASE --compset F1850 \
    --res f19_g17 --machine espresso --run-unsupported && \
    cd $HOME/cases/F1850$CASE                          && \
    NUMNODES="$((6*$CESM_PES))"                                   && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES} && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1 && \
    ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0 && \
    ./case.setup && ./case.build

## Case-7: NTASK=$CESM_PES*7

RUN CASE=case7 && \
    sed -i -e "s/\$CESM_PES/$CESM_PES/g" $HOME/.cime/config_machines.xml \
    && cd $HOME/CESM/cime/scripts \
    && ./create_newcase --case $HOME/cases/F1850$CASE --compset F1850 \
    --res f19_g17 --machine espresso --run-unsupported && \
    cd $HOME/cases/F1850$CASE                          && \
    NUMNODES="$((7*$CESM_PES))"                                   && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS --val ${NUMNODES} && \
    ./xmlchange --file env_mach_pes.xml --id NTASKS_ESP --val 1 && \
    ./xmlchange --file env_mach_pes.xml --id ROOTPE --val 0 && \
    ./case.setup && ./case.build

WORKDIR $HOME/cases/

COPY run_f1850 $HOME/cases/

CMD ["/bin/bash"]
