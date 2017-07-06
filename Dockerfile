FROM ubuntu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        bash-completion vim less man \
        lsof tree psmisc \
        net-tools iputils-ping iptables \
        netcat curl wget \
        p7zip-full \
        git && \
    # enable bash-completeion for current user(root)
    (echo && echo '[ -f /etc/bash_completion ] && ! shopt -oq posix && . /etc/bash_completion') >> ~/.bashrc
