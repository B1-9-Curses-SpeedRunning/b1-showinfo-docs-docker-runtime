FROM nikolaik/python-nodejs:python3.8-nodejs22-slim

# 设置 pnpm 的安装目录。
ENV PNPM_HOME="/pnpm"
# 将 pnpm 目录加入系统 PATH，方便直接使用 pnpm 命令。
ENV PATH="$PNPM_HOME:$PATH"

WORKDIR /app

COPY b1-showinfo-docs/package.json ./
COPY b1-showinfo-docs/pnpm-*.yaml ./
COPY b1-showinfo-docs/data/requirements.txt ./

# 安装 git。
RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

# 启用 Corepack。Node.js 22 已内置 Corepack，可自动管理 pnpm 版本。
RUN corepack enable

# 安装第三方依赖库。
RUN pnpm install --frozen-lockfile \
    && pnpm store prune \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /root/.cache/pip

COPY . .
