FROM node:24-bookworm-slim

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
        python3 \
        python3-pip \
        curl \
        ca-certificates \
        tini \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install \
    --break-system-packages \
    --no-cache-dir \
    yt-dlp

RUN npm install --global n8n@2.32.6 \
    && npm cache clean --force

RUN mkdir -p \
        /home/node/.n8n \
        /home/node/.n8n/youtube \
    && chown -R node:node /home/node

ENV N8N_PORT=5678
ENV N8N_LISTEN_ADDRESS=0.0.0.0
ENV N8N_USER_FOLDER=/home/node/.n8n
ENV GENERIC_TIMEZONE=America/Guayaquil
ENV TZ=America/Guayaquil

EXPOSE 5678

USER node

ENTRYPOINT ["tini", "--"]
CMD ["n8n", "start"]
