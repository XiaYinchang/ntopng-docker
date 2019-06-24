FROM centos:latest

RUN yum install -y epel-release wget
RUN wget http://packages.ntop.org/centos/ntop.repo -O /etc/yum.repos.d/ntop.repo
RUN yum install -y ntopng
RUN yum clean all

COPY s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C /
ADD redis-run.sh /etc/services.d/redis/run
ADD ntopng-run.sh /etc/services.d/ntopng/run

EXPOSE 3000

ENTRYPOINT ["/init"]
