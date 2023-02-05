#!/bin/sh

# run myapp
# notice: already "COPY app.json /etc/uwsgi/app.json" at Dockerfile
/usr/bin/uwsgi -config=/etc/uwsgi/app.json &

#run nginx
# CMD ["nginx", "-g", "daemon off;"]
nginx -g 'daemon off;'
# /usr/local/nginx/sbin/nginx -g 'daemon off;'

