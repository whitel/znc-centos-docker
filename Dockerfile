# This is a docker image for a ZNC IRC bouncer service
FROM centos:centos7
MAINTAINER Jeremy Brown <jeremy@tenfourty.com>

# let things know they are running in a container
ENV container docker

# run a full update
RUN yum -y update; yum clean all

# install the EPEL repository
RUN su -c 'rpm -Uvh http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/beta/7/x86_64/epel-release-7-0.2.noarch.rpm'

# install ZNC
RUN yum -y install znc znc-extra; yum clean all;

# setup the znc data dir for the configs
RUN mkdir /znc-data
RUN chown znc:znc /znc-data
RUN chmod 777 /znc-data

# user is znc and ports
USER 	znc
EXPOSE 	8080 6667 6697
VOLUME	["/znc-data"]

# this command starts znc and points it at the mounted volume for it's config
CMD znc -f -d /znc-data
