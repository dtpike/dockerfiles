ARG BASE=ubuntu/focal
FROM ${BASE}

ARG USER=user

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
    zsh \
    silversearcher-ag \
    libeigen3-dev \
    libjsoncpp-dev \
    libtins-dev \
    libpcap-dev \
    python3-dev \
    python3-pip \
    python3-venv \
    pybind11-dev \
    python3-breathe \
    libglfw3-dev \
    libglew-dev \
    doxygen && \
    apt-get clean

# ouster_example dependencies
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y build-essential cmake libglfw3-dev libglew-dev libeigen3-dev \
    libjsoncpp-dev libtclap-dev && \
    apt-get clean

# Generate the locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

# set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Install cmake 3.21
RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-linux-x86_64.sh -P /tmp && \
    sh /tmp/cmake-3.21.1-linux-x86_64.sh --skip-license --prefix=/usr/local && \
    rm /tmp/cmake-3.21.1-linux-x86_64.sh

# Install clang
RUN wget https://apt.llvm.org/llvm.sh -P /tmp && chmod +x /tmp/llvm.sh && /tmp/llvm.sh 12 && \
    apt-get install -y clang-format-12 clang-tidy-12 libc++-12-dev libc++abi-12-dev && \
    apt-get clean

# Add a user to the system and give them sudo
RUN useradd --create-home --shell /bin/zsh -G sudo ${USER}
RUN addgroup ${USER} sudo && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}
# Install dotfiles
RUN GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" \
    git clone https://github.com/dtpike/dotfiles.git /home/${USER}/dotfiles
RUN cd /home/${USER} && ./dotfiles/setup_dotfiles.sh
# setup virtual environment
RUN python3 -m venv /home/${USER}/.venv
# Pull setup scripts
RUN GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" \
    git clone https://github.com/dtpike/setup_scripts.git /home/${USER}/setup_scripts

USER root
# Install vim8
RUN cd /tmp && /home/${USER}/setup_scripts/install_vim.sh

USER ${USER}
WORKDIR /home/${USER}
CMD ["/usr/bin/zsh"]

