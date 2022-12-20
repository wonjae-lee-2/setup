FROM ubuntu:22.04

WORKDIR /

RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends sudo && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m ubuntu && \
    usermod -aG sudo ubuntu && \
    echo -e "ubuntu\tALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/ubuntu

COPY src/resources/prepare.sh /home/ubuntu/prepare.sh

WORKDIR /home/ubuntu

USER ubuntu

CMD ["/bin/bash"]
