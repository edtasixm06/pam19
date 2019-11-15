FROM fedora:27
LABEL version="1.0"
LABEL author="@edt ASIX-M06"
LABEL subject="hotpam"
RUN dnf -y install vim procps iproute nmap util-linux-user finger passwd pam_mount
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker

