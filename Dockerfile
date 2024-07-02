# Use the official Ubuntu base image
FROM ubuntu:22.04

# Install the necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    gcc \
    cmake \
    libprotobuf-dev \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

# Copy all contents from the current directory to /usr/src/app/ in the image
COPY . /usr/src/app/

# Initialize git submodules
RUN git submodule update --init

# Create a build directory and compile onnx2c
RUN mkdir /usr/src/app/build
WORKDIR /usr/src/app/build
RUN cmake -DCMAKE_BUILD_TYPE=Release .. && make onnx2c

# Set the working directory
WORKDIR /usr/src/app
