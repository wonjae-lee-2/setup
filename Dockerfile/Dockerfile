FROM ubuntu:22.04

WORKDIR /

RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends sudo && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m ubuntu && \
    usermod -aG sudo ubuntu && \
    echo "ubuntu ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/ubuntu

USER ubuntu

WORKDIR /home/ubuntu

RUN mkdir /home/ubuntu/downloads

CMD ["/bin/bash"]
