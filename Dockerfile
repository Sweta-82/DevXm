# Build stage
FROM node:20-alpine AS backend
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["node", "server.js"]