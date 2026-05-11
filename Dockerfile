FROM nikolaik/python-nodejs:python3.8-nodejs22-slim

WORKDIR /app

COPY b1-showinfo-docs/package*.json ./
COPY b1-showinfo-docs/data/requirements.txt ./

# 安装 git。
RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# 安装第三方包依赖。
RUN npm ci \
    && npm cache clean --force \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /root/.cache/pip

COPY . .
