FROM n8nio/n8n:2.32.6

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
        python3 \
        python3-pip \
        curl \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install \
    --break-system-packages \
    --no-cache-dir \
    yt-dlp

RUN mkdir -p /home/node/.n8n/youtube \
    && chown -R node:node /home/node/.n8n

USER node
