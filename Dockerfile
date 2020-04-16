FROM ubuntu:bionic

RUN set -x && apt-get update && \
    # install *.UTF-8 locales otherwise some apps get trouble
    apt-get -y install locales && locale-gen en_US.UTF-8 ja_JP.UTF-8 zh_CN.UTF-8 && update-locale LANG=en_US.UTF-8 && \
    # install other utilities
    apt-get -y install \
        apt-transport-https \
        bash-completion vim less man jq \
        lsof tree psmisc \
        net-tools iputils-ping iptables dnsutils \
        netcat curl wget nmap socat \
        p7zip-full \
        git && \
    #
    # enable bash-completeion for root user (other users works by default)
    (echo && echo '[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion') >> ~/.bashrc && \
    #
    # install sudo and create a sudoable user 'devuser'
    apt-get -y install sudo && \
        adduser --disabled-password --gecos "Developer" devuser && \
        adduser devuser sudo && \
        echo "devuser ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
        # generate .sudo_as_admin_successful to prevent sodu from showing guide message
        touch ~devuser/.sudo_as_admin_successful && \
        # allow devuser to install files to /usr/local without sudo prefix
        chown -R root:sudo /usr/local

USER devuser

WORKDIR /home/devuser

# set LANG=*.UTF-8 so that default file encoding will be UTF-8, otherwise any non-ASCII files may have trouble.
ENV LANG=en_US.UTF-8
