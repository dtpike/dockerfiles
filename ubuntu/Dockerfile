ARG BASE=ubuntu/xenial
FROM ${BASE}

ARG USER=user

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install developer dependencies
RUN apt-get update

RUN apt-get install -y man zsh unzip dialog wget sudo curl git unzip \
    iputils-ping locales vim-nox cmake build-essential python3-dev

# Install git-lfs for large file support
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install -y git-lfs

# Add a user to the system
RUN useradd --create-home --shell /bin/zsh -G sudo ${USER}
RUN echo "${USER}:ubuntu" | chpasswd

# Generate the locale
RUN locale-gen en_US.UTF-8  
# set the locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# Install essentials
# While we're root user install dev essentials
RUN GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone https://github.com/dtpike/setup_scripts.git /home/${USER}/setup_scripts
RUN chown ${USER}:${USER} /home/${USER}/setup_scripts
RUN /home/${USER}/setup_scripts/install_dev_essentials.sh

USER ${USER}
# Install dotfiles
RUN GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git clone https://github.com/dtpike/dotfiles.git /home/${USER}/dotfiles
RUN cd /home/${USER} && ./dotfiles/setup_dotfiles.sh

USER root
# Set temp password to expire
RUN passwd --expire ${USER}

USER ${USER}
WORKDIR /home/${USER}
CMD ["/usr/bin/zsh"]

