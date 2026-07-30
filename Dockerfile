FROM docker.n8n.io/n8nio/n8n:2.32.6

USER root

RUN apk add --no-cache \
    ffmpeg \
    python3 \
    py3-pip \
    curl \
    ca-certificates

RUN python3 -m pip install --upgrade pip

RUN pip3 install \
    --break-system-packages \
    --no-cache-dir \
    yt-dlp

RUN mkdir -p /home/node/.n8n-files/youtube \
    && chown -R node:node /home/node/.n8n-files

USER node
