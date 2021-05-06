FROM nginx:1.19.10-alpine

# using environment variables in nginx configuration
ADD ./templates /etc/nginx/templates

# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
RUN chgrp -R root /var/cache/nginx

# users are not allowed to listen on priviliged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8080;/' /etc/nginx/conf.d/default.conf
EXPOSE 8080

# comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf
# load njs module
RUN sed -i.bak '1 i\load_module modules/ngx_http_js_module.so;' /etc/nginx/nginx.conf

RUN chmod -R g=u /etc/nginx/conf.d 

RUN addgroup nginx root
USER nginx
