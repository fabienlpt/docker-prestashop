FROM nginx:alpine

RUN addgroup -g 1001 nginx-user && \
    adduser -D -s /bin/sh -u 1001 -G nginx-user nginx-user

RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx && \
    chown -R nginx-user:nginx-user /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d

RUN touch /var/run/nginx.pid && \
    chown nginx-user:nginx-user /var/run/nginx.pid

COPY --chown=nginx-user:nginx-user nginx.conf /etc/nginx/conf.d/default.conf

RUN sed -i 's/listen 80;/listen 8080;/' /etc/nginx/conf.d/default.conf

USER nginx-user

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]