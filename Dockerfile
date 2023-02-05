FROM nginx:1.19.3-alpine
# FROM yuchen168/myapp001


# FROM alpine:3.17

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi


COPY nginx.conf /etc/nginx/nginx.conf
COPY app.json /etc/uwsgi/app.json

COPY html.zip /usr/local/html.zip
WORKDIR /usr/local
RUN mkdir html
RUN unzip html.zip -d html

COPY uwsgi /tmp/uwsgi
RUN install -m 755 /tmp/uwsgi /usr/bin/uwsgi
RUN rm /tmp/uwsgi
# RUN /usr/bin/uwsgi -config=/etc/uwsgi/app.json


EXPOSE 10000

# CMD ["nginx", "-g", "daemon off;"]
# nginx -g 'daemon off;'

ADD app.sh /
RUN chmod +x /app.sh
CMD /app.sh
