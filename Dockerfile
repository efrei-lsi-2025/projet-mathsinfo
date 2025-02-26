FROM --platform=${BUILDPLATFORM} node:20.18.0

WORKDIR /app

RUN apt-get update && apt-get install -y \
        build-essential \
        libcairo2-dev \
        libpango1.0-dev \
        libjpeg-dev \
        libgif-dev \
        librsvg2-dev \
        libtool \
        autoconf \
        automake \
        && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

COPY . .

RUN npm ci

RUN npm run db:generate

EXPOSE 3000