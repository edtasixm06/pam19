#!/bin/bash
docker network create ldapnet
docker volume create homes

docker run --rm --name ldapserver -h ldapserver --net ldapnet -d edtasixm06/ldapserver19:latest

docker run --rm --name samba -h samba --net ldapnet -p 139:139 -p 445:445 -v homes:/tmp/home   --privileged   -it edtasixm06/samba19:pam
docker run --rm --name nfs -h nfs --net ldapnet -v homes:/tmp/home   --privileged   -it edtasixm06/nfs19:pam

docker run --rm --name pam -h pam --net ldapnet --privileged -it edtasixm06/hostpam19:samba /bin/bash


