FROM nginx:stable-alpine
EXPOSE 80

COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
