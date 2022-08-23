FROM tomcat:8
ADD target/bookstore-example-1.0-SNAPSHOT.war /usr/local/tomcat/webapps
CMD ["catlina.sh", "run"]
