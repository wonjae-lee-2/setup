FROM ubuntu:22.04

WORKDIR /

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    sudo && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m ubuntu && \
    usermod -aG sudo ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/ubuntu

USER ubuntu

WORKDIR /home/ubuntu

RUN mkdir /home/ubuntu/downloads && \
    echo "export LANG=C.UTF-8" >> /home/ubuntu/.profile && \
    echo "export LC_ALL=C.UTF-8" >> /home/ubuntu/.profile

CMD [ "/bin/sh", "-c", "while sleep 1000; do :; done" ]
