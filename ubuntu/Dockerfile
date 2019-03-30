ARG BASE=ubuntu/xenial
FROM ${BASE}

ARG USER=dpike

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install developer dependencies
RUN apt-get update

RUN apt-get install -y man zsh unzip dialog wget sudo curl git gdb unzip \
    iputils-ping locales silversearcher-ag nmap openssh-server vim

RUN apt-get install -y \
    build-essential \
    software-properties-common \
    libtool \
    autoconf \
    cmake \
    gdb \
    ccache \
    ninja-build \
    python-pip \
    python-setuptools \
    python-defusedxml \
    python-netifaces

# Install git-lfs for large file support
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install -y git-lfs

# Add a user to the system
RUN useradd --create-home --shell /bin/zsh -G sudo ${USER}
RUN echo "${USER}:letmein" | chpasswd

# Generate the locale
RUN locale-gen en_US.UTF-8  
# set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Install dotfiles
USER ${USER}
RUN GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone https://github.com/dtpike/dotfiles.git /home/${USER}/dotfiles
# Dotfiles need to be ran from the home directory
RUN cd /home/${USER}/ && ./dotfiles/setup_dotfiles.sh

USER root
RUN passwd --expire ${USER}

USER ${USER}
WORKDIR /home/${USER}
CMD ["/usr/bin/zsh"]

