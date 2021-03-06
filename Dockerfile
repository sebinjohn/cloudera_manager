FROM centos:centos6

COPY cloudera-manager.repo /etc/yum.repos.d/cloudera-manager.repo

RUN yum -y update && yum groupinstall -y 'development tools' \
 && yum -y install tar vim wget lsof unzip dnsmasq mysql-connector-java jdk cloudera-manager-server openssl-devel \
    sqlite-devel bzip2-devel openssh-server openssh-clients && yum clean all
RUN wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz && \
  tar -zxvf Python-2.7.9.tgz && cd Python-2.7.9 &&./configure && make && make install

RUN wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz \
  && tar -xvf setuptools-1.4.2.tar.gz && cd setuptools-1.4.2 && python2.7 setup.py install

RUN wget https://dl.bintray.com/mitchellh/serf/0.6.3_linux_amd64.zip \
  && unzip -d /usr/local/bin 0.6.3_linux_amd64.zip

RUN curl https://raw.githubusercontent.com/pypa/pip/master/contrib/get-pip.py | python2.7 - && \
  easy_install supervisor

RUN echo 'root:toor' |  chpasswd

COPY supervisord.conf /etc/supervisord.conf

ADD config /etc

ADD serf /usr/local/serf

COPY db.properties /etc/cloudera-scm-server/db.properties

CMD ["/usr/local/bin/supervisord"]

EXPOSE 7180 7182 22
