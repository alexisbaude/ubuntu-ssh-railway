FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    mkdir /var/run/sshd

RUN useradd -m -s /bin/bash alexis && \
    echo 'alexis:alexis' | chpasswd && \
    adduser alexis sudo

RUN sed -i 's/#Port 22/Port 2025/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 2025

CMD ["/usr/sbin/sshd", "-D"]
