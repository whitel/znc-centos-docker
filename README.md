znc-centos-docker
=================

A CentOS based ZNC docker image

Build command:

docker build -t="znc-centos-docker" .

Command to run the docker image:

docker run -d -p 6667:6667 -p 8080:8080 -p 6697:6697 -v /root/data/znc-centos-docker-data/:/znc-data znc-centos-docker


