#FROM tomcat:7
#ADD target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps
#CMD ["catalina.sh", "run"]

FROM tomcat:8-jre11

RUN apt-get update && apt-get -y upgrade

WORKDIR /usr/local/tomcat/webapps

ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
ADD tomcat-users.xml /usr/local/tomcat/conf

RUN mv /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

VOLUME /var/log/tomcat

ADD target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps

CMD ["catalina.sh","run"]
