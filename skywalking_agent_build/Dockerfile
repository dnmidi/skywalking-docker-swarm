FROM tomcat:8.5

WORKDIR /usr/local
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/examples
ADD ROOT.war /usr/local/tomcat/webapps/ROOT.war
ADD skywalking-agent /usr/local/skywalking-agent
ADD configure-agent.sh /
RUN chmod a+x /configure-agent.sh
ENTRYPOINT ["/configure-agent.sh"]
