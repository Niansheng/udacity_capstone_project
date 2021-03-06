FROM nginx:1.19
WORKDIR /www

COPY www /www
COPY www/site.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]