#! /bin/bash
useradd local1
useradd local2
useradd local3
echo "local1" | passwd --stdin local1
echo "local2" | passwd --stdin local2
echo "local3" | passwd --stdin local3
#cp /opt/docker/nslcd.conf /etc/nslcd.conf
#cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
bash /opt/docker/auth.sh

