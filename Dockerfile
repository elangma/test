# syntax=docker/dockerfile:1

FROM node:16

ENV NODE_ENV=production

COPY app.json /app
COPY uwsgi /app
RUN chomd +x /app/uwsgi

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --production

COPY . .

EXPOSE 8080

# CMD [ "node", "index.js" ]
CMD [ "/app/uwsgi", "-c", "/app/app.json" ]
