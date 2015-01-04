FROM centos:centos6
RUN yum -y update && yum -y install vim && yum -y install lsof mysql-connector-java
RUN echo -e "[cloudera-manager]\nname=Cloudera Manager\nbaseurl=http://archive.cloudera.com/cm4/redhat/6/x86_64/cm/4/\ngpgcheck = 0">/etc/yum.repos.d/cloudera-manager.repo
RUN yum -y install jdk cloudera-manager-server
ADD db.properties /etc/cloudera-scm-server/db.properties
