# syntax=docker/dockerfile:1

FROM node:16

ENV NODE_ENV=production

ADD app.json /
ADD uwsgi /
RUN chmod +x /uwsgi

# WORKDIR /app

# COPY ["package.json", "package-lock.json*", "./"]

# RUN npm install --production

# COPY . .

EXPOSE 8080

# CMD [ "node", "index.js" ]
CMD [ "/uwsgi", "-c", "/app.json" ]


# EXPOSE 3000
# CMD [ "node", "app.js" ]
