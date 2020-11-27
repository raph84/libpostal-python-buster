FROM python:3.8-slim-buster AS base

# Install libpostal
WORKDIR /
RUN apt-get update && apt-get install -y git && \
     apt-get -y install curl autoconf automake libtool pkg-config && \ 
     git clone -n https://github.com/openvenues/libpostal && \
     cd libpostal && \
     ./bootstrap.sh && \
     ./configure --datadir=/libpostal_data && \
     make -j4 && \
     make install && \
     ldconfig && \ 
     rm -rf /var/lib/apt/lists/* && \
     cd / && \ 
     /bin/bash -c "pip3 install postal"

#TODO build tool cleanup