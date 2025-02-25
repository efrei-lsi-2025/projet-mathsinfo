FROM --platform=${BUILDPLATFORM} node:20.18.0

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .