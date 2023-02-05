FROM yuchen168/uwsgi-nginx-unprivileged
# FROM yuchen168/myapp001


# EXPOSE 8000/tcp

# CMD ["nginx", "-g", "daemon off;"]
# nginx -g 'daemon off;'

ADD app.sh /
RUN chmod +x /app.sh

EXPOSE 8000/tcp

CMD /app.sh
