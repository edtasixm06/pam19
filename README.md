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

* **edtasixm06/hostpam19:auth** host pam amb autenticacio d'usuaris ldap usant nss-pam-ldapd. Usa el container 
  *edtasixm06/ldapserver19:latest*.

