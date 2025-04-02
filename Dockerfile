# Use an official Ubuntu base image
FROM ubuntu:25.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    gdb \
    cmake \
    make \
    git \
    libopenblas-dev \
    liblapacke-dev \
    libarpack2-dev \
    libsuperlu-dev \
    libarmadillo-dev \
    libeigen3-dev \
    nlohmann-json3-dev \
    libhdf5-dev \
    python3 \ 
    python-is-python3 \
    python3-pip \
    python3-venv \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

# Clone
RUN git clone --recursive  https://github.com/highfive-devs/highfive.git && \ 
    cd highfive && \
    mkdir build && \
    cd build && \ 
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DHIGHFIVE_UNIT_TESTS=OFF -DHIGHFIVE_EXAMPLES=OFF -DHIGHFIVE_BUILD_DOCS=OFF && \
    make -j$(nproc) && \
    make install && \
    cd ../.. && \ 
    rm -rf HighFive 


# Set up a virtual environment
RUN python3 -m venv /opt/venv

# Ensure the virtual environment is activated in all commands
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies inside the virtual environment
RUN pip install --upgrade pip && \
    pip install \
        pytest \
        numpy \
        h5py 

WORKDIR /work

RUN echo "umask 000" >> /etc/profile

CMD ["bash"]