#!/bin/bash
sed -i "s/collector.servers=127.0.0.1:10800/collector.servers=${COLLECTOR_SERVERS}/g" /usr/local/skywalking-agent/config/agent.config
sed -i "s/Your_ApplicationName/${App_Name}/g" /usr/local/skywalking-agent/config/agent.config
sed -i '2i\CATALINA_OPTS="$CATALINA_OPTS -javaagent:/usr/local/skywalking-agent/skywalking-agent.jar"; export CATALINA_OPTS' /usr/local/tomcat/bin/catalina.sh

${CATALINA_HOME}/bin/catalina.sh run
