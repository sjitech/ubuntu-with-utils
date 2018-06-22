# ubuntu-with-utils

A docker image with basic development and diagnostic tools:

- `bash-completion`
- `vim` `less` `man` `jq`
- `lsof` `tree` `pstree`
- `ping` `netstat` `ss` `arp` `nslookup` `dig` `host` `iptables`
- `nc` `ncat` `socat` `nmap`
- `curl` `wget`
- `7z`
- `sudo`
- `git`
- _further develop tool such as `python`, `node` ... are **NOT** included_

By default this docker container runs as a sudo-able user `devuser`
so can work with some anti-root tools.

#### Usage

- start a interactive `bash` shell

    ```
    docker run -it osexp2000/ubuntu-with-utils
    ```
    screenshot:
    ```    
    devuser@446f84fa0d63:~$ id; pwd
    uid=1000(devuser) gid=1000(devuser) groups=1000(devuser),27(sudo)
    /home/devuser
    devuser@446f84fa0d63:~$ sudo apt update && sudo apt -y install python3
    ```

- run command directly 

    ```
    $ docker run -it osexp2000/ubuntu-with-utils COMMAND ARGS...
    ```

#### Notes

- `the input device is not a TTY`

    When this error happens, please remove the `t` option (allocate tty).

    - NG
        ```
        $ echo "echo OK" | docker -it osexp2000/ubuntu-with-utils
        the input device is not a TTY
        ```
    - OK 
        ```
        $ echo "echo OK" | docker -i osexp2000/ubuntu-with-utils
        OK
        ``` 

- `sudo: unable to resolve host HOSTNAME`

    This warning happens when the container is started with `--net host`.
    Please add option `--add-host HOSTNAME:127.0.0.1`

    - NG
        ```
        $ docker run -it --net host osexp2000/ubuntu-with-utils sudo echo OK
        sudo: unable to resolve host HOSTNAME
        OK
        ```
    - OK 
        ```
        $ docker run -it --net host --add-host HOSTNAME:127.0.0.1 osexp2000/ubuntu-with-utils sudo echo OK
        OK
        ```
        if the hostname is non-deterministic, you can fix hostname(for the container) with `--hostname HOSTNAME`. 
        ```
        $ docker run -it --net host --add-host HOSTNAME:127.0.0.1 --hostname HOSTNAME osexp2000/ubuntu-with-utils sudo echo OK
        OK
        ``` 
