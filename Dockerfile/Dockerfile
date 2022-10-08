FROM ubuntu:22.04

ARG GCLOUD_VERSION
ARG GCLOUD_FOLDER=/root/gcloud

WORKDIR /root

RUN mkdir downloads && \
    apt update && \
    apt upgrade -y && \
    apt install -y \
        curl \
        wget \
        sudo \
        lsb-release && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
    mkdir ${GCLOUD_FOLDER} && \
    tar -x -f google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz -C ${GCLOUD_FOLDER} --strip-components=1 && \
    ${GCLOUD_FOLDER}/install.sh --quiet --command-completion True --path-update True && \
    ln -fs ${GCLOUD_FOLDER}/bin/gcloud /usr/local/bin/gcloud && \
    rm google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz

EXPOSE 8888

CMD ["bash"]
