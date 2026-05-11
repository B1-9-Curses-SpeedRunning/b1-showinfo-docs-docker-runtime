FROM nikolaik/python-nodejs:python3.8-nodejs22-slim

WORKDIR /app

COPY b1-showinfo-docs/package*.json ./
COPY b1-showinfo-docs/data/requirements.txt ./

RUN npm ci \
    && npm cache clean --force \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /root/.cache/pip

COPY . .
