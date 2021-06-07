FROM ubuntu:bionic

RUN set -x && apt-get update && \
    #
    # remove this file otherwise man pages of later installed tools will not be istalled
    #rm -f /etc/dpkg/dpkg.cfg.d/excludes && \
    #apt-get -y install manpages-dev manpages-posix && \
    # install all things of a normal ubuntu server.
    (echo y; echo y; echo y; echo y) | unminimize && \
    #
    # install *.UTF-8 locales otherwise some apps get trouble
    apt-get -y install locales && locale-gen en_US.UTF-8 ja_JP.UTF-8 zh_CN.UTF-8 && update-locale LANG=en_US.UTF-8 && \
    #
    # install other utilities
    apt-get -y install \
        apt-transport-https \
        bash-completion vim less man jq bc \
        lsof tree psmisc htop lshw sysstat dstat \
        iproute2 iputils-ping iptables dnsutils traceroute \
        netcat curl wget nmap socat netcat-openbsd rsync \
        p7zip-full \
        git tig \
        binutils acl pv \
        strace tcpdump \
    && \
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
ENV LANG=C.UTF-8
