FROM tomcat
COPY ./target/endtoend.war /usr/local/tomcat/webapps/
