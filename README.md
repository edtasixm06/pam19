# pam

## @edt ASIX M06 2019-2020


Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)

ASIX M06-ASO Escola del treball de barcelona

### Imatges:

* **edtasixm06/hostpam19:base** host pam per practicar *PAM* amb chfn i system-auth. Es tranquen els types
  auth i session amb chfn practicant el significat de optional, sufficient, required i requisite. El type
  password amb pwquality. El type account amb pam_time.so. El type sessions amb pam_mkhomedir.so i 
  pam_mount.so. Es practica pam_mount.so amb un muntatge tmpfs i un de nfs4.

  Atenció, cal usar en el container --privileged per poder fer els muntatges nfs.

  ```$ docker run --rm --name pam --hostname pam --privileged -it edtasixm06/hostpam19:base /bin/bash ```

* **edtasixm06/hostpam19:auth** host pam amb autenticacio d'usuaris ldap usant nss-pam-ldapd. Usa el container 
  *edtasixm06/ldapserver19:latest*.

  Atenció: cal usar una xarxa 'ldapnet' per assegurar-se que els dos containers s'identifiquen.

  ```
  $ docker network create ldapnet
  $ docker run --rm --name ldapserver -h ldapserver --net ldapnet -d edtasixm06/ldapserver:latest
  $ docker run --rm --name pam --hostname pam --privileged --net ldapserver -it edtasixm06/hostpam19:base /bin/bash
  ```

* **edtasixm06/hostpam19:scratch** host pam fet de nou i activant la configuració amb authconfig. Ara ja no cal copiar 
  manualment els fitxers nscd.conf nslcd.conf i nsswitch.conf, ja que authconfig els configura automàticament.

* **edtasixm06/hostpam19:samba** host pam amb usuaris locals i usuaris de ldap. Als usuaris ldap se'ls munta el home 
  via samba en un directori dins del seu home.

  Per poder posar-ho tot  en marxa cal el servidor ldap, el servidor samba i el host pam. podem per exemple:
  
  ```
  #!/bin/bash
  docker network create ldapnet
  docker volume create homes
  docker run --rm --name ldapserver -h ldapserver --net ldapnet -d edtasixm06/ldapserver19:latest
  docker run --rm --name samba -h samba --net ldapnet -p 139:139 -p 445:445 -v homes:/tmp/home   --privileged   -d edtasixm06/samba19:pam
  docker run --rm --name nfs -h nfs --net ldapnet -v homes:/tmp/home   --privileged   -d edtasixm06/nfs19:pam
  docker run --rm --name pam -h pam --net ldapnet --privileged -it edtasixm06/hostpam19:nfs 
  docker exec -it pam /bin/bash
  ```

  O bé podem generar un fitxer docker-compose.yml i amb docker-compose instal·lat fer:
  
  ```
  version: "2"
  services:
    ldap:
      image: edtasixm06/ldapserver19:latest
      container_name: ldapserver
      hostname: ldapserver
      ports: 
        - "389:389"
      networks:
       - mynet
    samba:
      image: edtasixm06/samba19:pam
      container_name: samba
      hostname: samba
      volumes:
        - "homes:/tmp/home"
      ports:
        - "139:139"
        - "445:445"
      networks:
        - mynet
    nfs:
      image: edtasixm06/nfs19:pam
      container_name: nfs
      hostname: nfs
      volumes:
        - "homes:/tmp/home"
          #    ports:
          #- "111:111"
          #- "2049:2049"
      privileged: true
      networks:
       - mynet
    pam:
      image: edtasixm06/hostpam19:nfs
      container_name: pam
      hostname: pam
      networks:
       - mynet
      privileged: true
  networks:
    mynet:
  volumes:
  homes:
  ```
