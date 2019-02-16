FROM centos:latest
MAINTAINER Sleeck

RUN yum install -y epel-release wget
RUN wget http://packages.ntop.org/centos/ntop.repo -O /etc/yum.repos.d/ntop.repo
RUN yum install -y ntopng
RUN yum clean all

RUN echo '#!/bin/bash' > /run.sh
RUN echo '/usr/bin/redis-server /etc/redis.conf&' >> /run.sh
RUN echo '/usr/local/bin/ntopng "$@"' >> /run.sh
RUN chmod +x /run.sh

EXPOSE 3000

ENTRYPOINT ["/run.sh"]
