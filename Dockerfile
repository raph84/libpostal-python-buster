FROM python:3.8-slim-buster AS base

# Lock Python package version to 3.7
RUN apt-get update && \
    apt-get install -y git && \
    apt-get install -y dselect && \
    dselect update && \
    echo "python3 hold" | dpkg --set-selections

# Libpostal build tools
RUN  apt-get update && apt-get install -y git && \
     apt-get -y install curl autoconf automake libtool pkg-config

# Install libpostal
WORKDIR /
RUN  git clone -n https://github.com/openvenues/libpostal && \
     cd libpostal && \
     git checkout 7c22eb4e644d6ef9faf38904ff8d6c712f7a106a && \
    ./bootstrap.sh && \
     ./configure --datadir=/libpostal_data && \
     make -j4 && \
     make install && \
     ldconfig && \ 
     rm -rf /var/lib/apt/lists/* && \
     cd / && \ 
     /bin/bash -c "pip3 install postal"

#TODO build tool cleanup