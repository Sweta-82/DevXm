FROM node:20-alpine AS frontend
COPY ./frontend /app
WORKDIR /app
RUN npm install
RUN npm run build