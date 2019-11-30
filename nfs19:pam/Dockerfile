# Version: 0.0.1
# @edt M06 2019-2020
# NFS
# -------------------------------------
FROM fedora:27
LABEL author="@edt ASIX M06-ASO"
LABEL description="SAMBA server 2019-2020"
RUN dnf -y install procps samba samba-client passwd pam_mount nfs-utils nss-pam-ldapd procps authconfig vim nfs-utils
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/install.sh /opt/docker/startup.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]

