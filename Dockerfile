# Use an official Ubuntu base image
FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    cmake \
    make \
    git \
    libopenblas-dev \
    liblapack-dev \
    libarpack2-dev \
    libsuperlu-dev \
    libarmadillo-dev \
    libeigen3-dev \
    python3 \ 
    python3-pip \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies for testing
RUN pip3 install pytest

WORKDIR /work

RUN echo "umask 000" >> /etc/profile

CMD ["bash"]