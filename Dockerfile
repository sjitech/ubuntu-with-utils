FROM ubuntu:xenial

RUN apt-get update && \
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
