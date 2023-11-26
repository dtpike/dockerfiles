# syntax=docker/dockerfile:1.2
ARG DISTRO=ubuntu
ARG DISTRO_VERSION=22.04
FROM ${DISTRO}:${DISTRO_VERSION}

ARG USER=user
ARG UID=1000
ARG GID=1000

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y \
    software-properties-common \
    locales \
    sudo \
    wget \
    python3-pip \
    python3-venv \
    stow \
    ninja-build \
    g++ \
    git \
    gcovr \
    pkg-config \
    curl \
    unzip \
    gettext \
    zsh && \
    apt-get clean

# Generate the locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

# Set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Install cmake
ARG CMAKE_VERSION=3.25.1
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-$(uname -m).sh -P /tmp && \
    sh /tmp/cmake-${CMAKE_VERSION}-linux-$(uname -m).sh --skip-license --prefix=/usr/local && \
    rm /tmp/cmake-${CMAKE_VERSION}-linux-$(uname -m).sh

# Install clang
ARG CLANG_VERSION=13
RUN wget https://apt.llvm.org/llvm.sh -P /tmp && \
    chmod +x /tmp/llvm.sh && /tmp/llvm.sh ${CLANG_VERSION} && \
    apt-get install -y clang-format-${CLANG_VERSION} \
    clang-tidy-${CLANG_VERSION} \
    libc++-${CLANG_VERSION}-dev \
    libc++abi-${CLANG_VERSION}-dev && \
    apt-get clean

# Add a user and docker group to the system. When the container is run, we need
# to ensure that the UID and GID are compatible with the host UID and GID in
# order for docker to be able to write to files.
RUN groupadd --gid ${GID} docker && \
    useradd --create-home --uid ${UID} \
    --gid docker \
    --no-user-group \
    --shell /bin/zsh \
    -G sudo \
    ${USER}

# Enable passwordless sudo
RUN echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install neovim
RUN git clone https://github.com/neovim/neovim && \
    cd neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install

# Ouster dependencies
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt install -y libjsoncpp-dev \
    libeigen3-dev \
    libcurl4-openssl-dev \
    libtins-dev \
    libpcap-dev \
    libglfw3-dev \
    libglew-dev \
    libspdlog-dev

# Install flatbuf
RUN git clone https://github.com/google/flatbuffers.git && \
    cd flatbuffers && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DFLATBUFFERS_BUILD_TESTS=OFF -DFLATBUFFERS_BUILD_FLATLIB=OFF && \
    ninja && ninja install

# Install dotfiles
USER ${USER}
RUN git clone https://github.com/dtpike/dotfiles.git /home/${USER}/dotfiles && \
    /home/${USER}/dotfiles/setup.sh

# Install my deprecated zsh plugin manager
RUN git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

WORKDIR /home/${USER}
CMD ["/usr/bin/zsh"]

