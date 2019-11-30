#! /bin/bash
# @edt ASIX M06 2019-2020
# instal.lacio
# -------------------------------------

# Creació d'usuaris locals ------------------------------------------
useradd local1
useradd local2
useradd local3
echo "local1" | passwd --stdin local1
echo "local2" | passwd --stdin local2
echo "local3" | passwd --stdin local3
# -------------------------------------------------------------------

# Configuració client autenticació ldap =============================
bash /opt/docker/auth.sh
#cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
# ===================================================================


# SAMBA =============================================================
# Configuració shares Samba -----------------------------------------
mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
cp /opt/docker/* /var/lib/samba/public/.
mkdir /var/lib/samba/privat
#chmod 777 /var/lib/samba/privat
cp /opt/docker/*.md /var/lib/samba/privat/.
cp /opt/docker/smb.conf /etc/samba/smb.conf
# -------------------------------------------------------------------
# Creació d'usuaris unix + samba locals per a test samba ------------
useradd patipla
useradd roc
useradd lila
useradd pla
echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "roc\nroc" | smbpasswd -a roc
echo -e "lila\nlila" | smbpasswd -a lila
echo -e "pla\npla" | smbpasswd -a pla
# -------------------------------------------------------------------
# Creació dels comptes samba i directoris dels usuaris ldap ---------
# ha de ser un cop activat ldap/ nslcd...
#bash /opt/docker/ldapusers.sh
# ===================================================================

# Configuració NFS =================================================
cp /opt/docker/exports /etc/exports
mkdir /run/rpcbind 
touch /run/rpcbind/rpcbind.lock
# -------------------------------------------------------------------

