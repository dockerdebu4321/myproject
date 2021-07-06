
FROM centos
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.50/bin/apache-tomcat-9.0.50.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-9.0.50/* /opt/tomcat/.
RUN yum -y install java
RUN java -version
WORKDIR /opt/tomcat/webapps
COPY ./target/endtoend.war .
EXPOSE 8085
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

