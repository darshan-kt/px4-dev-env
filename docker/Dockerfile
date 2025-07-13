FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# --------------------------
# Base system & certificates
# --------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl gnupg lsb-release ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ----------------------
# Add Gazebo APT repo
# ----------------------
# Add Gazebo APT repo and key properly
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.osrfoundation.org/gazebo.key | gpg --dearmor -o /etc/apt/keyrings/gazebo-archive-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/gazebo-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/gazebo-stable.list

# ----------------------
# Install PX4 Dependencies
# ----------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo git build-essential \
    python3-pip python3-dev python3-venv python3-setuptools \
    python3-numpy python3-jinja2 python3-empy python3-toml \
    python3-yaml python3-future python3-pygments \
    cmake ninja-build ccache exiftool zip unzip \
    libopencv-dev protobuf-compiler libeigen3-dev \
    libxml2-utils libtinyxml2-dev libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev libpython3-dev \
    libyaml-cpp-dev libgtest-dev clang-format xterm \
    gazebo11 libgazebo11-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install pyserial kconfiglib && pip3 install --user jsonschema
RUN pip3 install --user pyros-genmsg

# ----------------------
# Create user 'px4'
# ----------------------
RUN useradd -ms /bin/bash px4 && \
    usermod -aG sudo px4 && \
    echo "px4:px4" | chpasswd && \
    echo "px4 ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER px4
WORKDIR /home/px4

CMD ["/bin/bash"]
