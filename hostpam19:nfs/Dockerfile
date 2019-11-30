FROM fedora:27
LABEL version="1.0"
LABEL author="@edt ASIX-M06"
LABEL subject="hostpam"
RUN dnf -y install vim passwd nss-pam-ldapd authconfig samba-client cifs-utils pam_mount nfs-utils 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh
WORKDIR /opt/docker
CMD /opt/docker/startup.sh


