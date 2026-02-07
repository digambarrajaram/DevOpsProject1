FROM tomcat:9.0

RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

COPY webapp.war /usr/local/tomcat/webapps/
