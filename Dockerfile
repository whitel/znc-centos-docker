# This is a docker image for a ZNC IRC bouncer service
FROM centos:centos6
MAINTAINER Jeremy Brown <jeremy@tenfourty.com>

# install the EPEL repository
RUN su -c 'rpm -Uvh http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'

# install ansible
RUN yum -y install ansible; yum clean all;

# add our inventory file to the local machine
ADD ansible-inventory /etc/ansible/hosts

# use ansible to install znc
ADD znc-playbook.yml /tmp/znc-playbook.yml
RUN ansible-playbook /tmp/znc-playbook.yml -c local
RUN rm /tmp/znc-playbook.yml

ADD znc.conf /tmp/znc.conf
ADD znc.pem /tmp/znc.pem
ADD run-znc.sh /run-znc.sh
RUN chown znc:znc /tmp/znc.conf /tmp/znc.pem /run-znc.sh

# user is znc and ports
USER 	znc
EXPOSE 	8080 6667 6697
VOLUME	["/znc-data"]

# this command starts znc and points it at the mounted volume for it's config
CMD /run-znc.sh

