#!/bin/sh
local_ip=`ip addr |grep eth0 | grep "inet"|awk '{print $2}'|awk -F"/" '{print $1}'|awk '{if(NR==1){print $0}}'`

ADDR=$Host
dns_ip=`ping -c1 ${ADDR}|awk -F'[(|)]' 'NR==1{print $2}'`

echo "replace {ZK_ADDRESSES} to ${ZK_ADDRESSES}"
eval sed -i -e 's/\{ZK_ADDRESSES\}/${ZK_ADDRESSES}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {ES_CLUSTER_NAME} to ${ES_CLUSTER_NAME}"
eval sed -i -e 's/\{ES_CLUSTER_NAME\}/${ES_CLUSTER_NAME}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {ES_ADDRESSES} to ${ES_ADDRESSES}"
eval sed -i -e 's/\{ES_ADDRESSES\}/${ES_ADDRESSES}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {BIND_HOST} to ${local_ip}"
eval sed -i -e 's/\{BIND_HOST\}/${local_ip}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {NAMING_BIND_HOST} to ${local_ip}"
eval sed -i -e 's/\{NAMING_BIND_HOST\}/${local_ip}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {NAMING_BIND_PORT} to ${NAMING_BIND_PORT}"
eval sed -i -e 's/\{NAMING_BIND_PORT\}/${NAMING_BIND_PORT}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {REMOTE_BIND_PORT} to ${REMOTE_BIND_PORT}"
eval sed -i -e 's/\{REMOTE_BIND_PORT\}/${REMOTE_BIND_PORT}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {AGENT_GRPC_BIND_PORT} to ${AGENT_GRPC_BIND_PORT}"
eval sed -i -e 's/\{AGENT_GRPC_BIND_PORT\}/${AGENT_GRPC_BIND_PORT}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {AGENT_JETTY_BIND_HOST} to ${local_ip}"
eval sed -i -e 's/\{AGENT_JETTY_BIND_HOST\}/${local_ip}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {AGENT_JETTY_BIND_PORT} to ${AGENT_JETTY_BIND_PORT}"
eval sed -i -e 's/\{AGENT_JETTY_BIND_PORT\}/${AGENT_JETTY_BIND_PORT}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {UI_JETTY_BIND_PORT} to ${UI_JETTY_BIND_PORT}"
eval sed -i -e 's/\{UI_JETTY_BIND_PORT\}/${UI_JETTY_BIND_PORT}/' /usr/local/skywalking-collector/config/application.yml

echo "replace {UI_JETTY_BIND_HOST} to ${local_ip}"
eval sed -i -e 's/\{UI_JETTY_BIND_HOST\}/${local_ip}/' /usr/local/skywalking-collector/config/application.yml



#替换nginxIP
echo "replace nginx to ${local_ip}"
eval sed -i -e 's/\{host_ip\}/${local_ip}/' /etc/nginx/nginx.conf
eval sed -i -e 's/\{dns_ip\}/${dns_ip}/' /etc/nginx/nginx.conf

echo "restart nginx"
service nginx restart

echo "start up"
cd /usr/local/skywalking-collector/bin
./startup.sh