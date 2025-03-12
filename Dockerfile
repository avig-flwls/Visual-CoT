FROM nvidia/cuda:12.0.0-devel-ubuntu18.04

# Update package lists and install curl first
RUN apt-get update && apt-get install -y curl

# Add the NVIDIA repository key and update package lists
RUN curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub | gpg --dearmor -o /usr/share/keyrings/nvidia-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nvidia-archive-keyring.gpg] http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/ /" | tee /etc/apt/sources.list.d/cuda.list && \
    apt-get update

# Install required packages
RUN apt-get install -y \
      software-properties-common \
      build-essential \
      ffmpeg \
      git \
      mesa-utils \
      unzip \
      wget

# Install micromamba
RUN mkdir -p /opt/micromamba && \
    cd /opt/micromamba && \
    curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba && \
    ./bin/micromamba shell init -s bash && \
    mkdir -p /root/micromamba/pkgs

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh # install uv

# Copies all files into /app folder
COPY . /app
WORKDIR /app