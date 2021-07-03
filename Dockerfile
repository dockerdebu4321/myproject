#From tomcat:8.0.51-jre8-alpine
#RUN rm -rf /usr/local/tomcat/webapps/*
#COPY ./target/endtoend.war /usr/local/tomcat/webapps/endtoend.war
#CMD ["catalina.sh","run"]


FROM centos
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.48/bin/apache-tomcat-9.0.48.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-9.0.48/* /opt/tomcat/.
RUN yum -y install java
RUN java -version
WORKDIR /opt/tomcat/webapps
COPY ./target/endtoend.war .
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
