FROM nginx:1.17.6

RUN rm -f /etc/nginx/conf.d/*

COPY nginx.conf /etc/nginx/conf.d/workout_app.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf