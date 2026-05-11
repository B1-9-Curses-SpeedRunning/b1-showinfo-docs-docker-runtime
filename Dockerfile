FROM nikolaik/python-nodejs:python3.8-nodejs22-slim

WORKDIR /app

COPY b1-showinfo-docs/package*.json ./
COPY b1-showinfo-docs/data/requirements.txt ./

RUN npm config set registry https://registry.npmmirror.com \
    && npm ci \
    && npm cache clean --force \
    && pip install --no-cache-dir \
       -i https://pypi.tuna.tsinghua.edu.cn/simple \
       -r requirements.txt \
    && rm -rf /root/.cache/pip

COPY . .
