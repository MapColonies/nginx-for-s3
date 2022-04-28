FROM nginx:1.19.10-alpine

# using environment variables in nginx configuration
ADD ./templates /etc/nginx/templates

# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
RUN chgrp -R root /var/cache/nginx

ADD ./nginx.conf /etc/nginx/nginx.conf

RUN chmod -R g=u /etc/nginx/conf.d 

RUN addgroup nginx root
USER nginx
