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
    (echo && echo '[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion') >> ~/.bashrc
