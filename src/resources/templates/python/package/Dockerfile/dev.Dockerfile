FROM python:3.11

WORKDIR /root

RUN useradd -u 1000 -m ubuntu && \
    apt update && \
    apt install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /home/ubuntu
USER ubuntu

COPY poetry.lock poetry.lock
COPY pyproject.toml pyproject.toml
RUN python -m venv /home/ubuntu/venv && \
    . /home/ubuntu/venv/bin/activate && \
    curl -sSL https://install.python-poetry.org | python - && \
    /home/ubuntu/.local/share/pypoetry/venv/bin/poetry install --no-root && \
    rm poetry.lock pyproject.toml && \
    mkdir -p /home/ubuntu/.vscode-server/data/Machine && \
    echo '{ "python.defaultInterpreterPath": "/home/ubuntu/venv/bin/python" }' > /home/ubuntu/.vscode-server/data/Machine/settings.json

CMD [ "/bin/sh", "-c", "while sleep 1000; do :; done" ]
