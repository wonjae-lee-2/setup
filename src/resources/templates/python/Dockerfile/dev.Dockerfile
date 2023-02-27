FROM python:3.11

RUN apt update && \
    apt install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -u 1000 -m ubuntu
    
WORKDIR /home/ubuntu
USER ubuntu

RUN curl -sSL https://install.python-poetry.org | python3 -

CMD [ "/bin/bash" ]
