# Use an official Ubuntu base image
FROM ubuntu:25.04

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
    python-is-python3 \
    python3-pip \
    python3-venv \
    python3-setuptools \
    python3-wheel \
    && rm -rf /var/lib/apt/lists/*

# Set up a virtual environment
RUN python3 -m venv /opt/venv

# Ensure the virtual environment is activated in all commands
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies inside the virtual environment
RUN pip install --upgrade pip && \
    pip install \
        pytest 

WORKDIR /work

RUN echo "umask 000" >> /etc/profile

CMD ["bash"]