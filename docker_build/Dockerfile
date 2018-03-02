FROM skywalking/skywalking-collector

#setup nginx
RUN apt-get -y update && apt-get install -y nginx
ADD nginx.conf /etc/nginx/nginx.conf

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh