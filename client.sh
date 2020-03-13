#!/bin/bash

echo "*.info;mail.none;authpriv.none;cron.none   @rsyslog-server2" >> /etc/rsyslog.conf && systemctl restart rsyslog.service
#Important: this should be the internal not external IP of the server or the dns name of your server.
#logsrv is what I named it to avoid complications

apt-get update
export DEBIAN_FRONTEND=noninteractive
apt -y install libnss-ldap libpam-ldap ldap-utils
unset DEBIAN_FRONTEND

sed -i 's/passwd:         compat systemd/passwd:         compat systemd ldap/g' /etc/nsswitch.conf
sed -i 's/group:          compat systemd/group:          compat systemd ldap/g' /etc/nsswitch.conf
sed -i 's/password        \[success=1 user_unknown=ignore default=die\]     pam_ldap.so use_authtok try_first_pass/password        \[success=1 user_unknown=ignore default=die\]     pam_ldap.so try_first_pass/g' /etc/pam.d/common-password
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/base dc=example,dc=net/base dc=nti310,cd=local/g' /etc/ldap.conf
sed -i 's,uri ldapi:///,uri ldap://ldap,g' /etc/ldap.conf
sed -i 's/rootbinddn cn=manager,dc=example,dc=net/rootbinddn cn=ldapadm,dc=nti310,dc=local/g' /etc/ldap.conf
sed -i "s/#nss_base_group.[ \t]*ou=Group,dc=padl,dc=com?one/nss_base_group          ou=Group,dc=nti310,dc=local/g" /etc/ldap.conf
sed -i 's/#nss_base_passwd.[ \t]*ou=People,dc=padl,dc=com?one/nss_base_passwd        ou=People,dc=nti310,dc=local/g' /etc/ldap.conf
sed -i 's/#nss_base_shadow.[ \t]*ou=People,dc=padl,dc=com?one/nss_base_shadow        ou=People,dc=nti310,dc=local/g' /etc/ldap.conf
systemctl restart sshd
echo "OPxTy6TC" > /etc/ldap.secret
chmod 0600 /etc/ldap.secret
systemctl restart libnss-ldap
apt -y install debconf-utils

echo "ldap-auth-config        ldap-auth-config/rootbindpw     password
ldap-auth-config        ldap-auth-config/bindpw password
ldap-auth-config        ldap-auth-config/dbrootlogin    boolean true
ldap-auth-config        ldap-auth-config/ldapns/ldap-server     string  ldap://ldap
ldap-auth-config        ldap-auth-config/dblogin        boolean false
ldap-auth-config        ldap-auth-config/binddn string  cn=proxyuser,dc=example,dc=net
ldap-auth-config        ldap-auth-config/pam_password   select  md5
ldap-auth-config        ldap-auth-config/override       boolean true
ldap-auth-config        ldap-auth-config/ldapns/base-dn string  dc=nti310,dc=local
ldap-auth-config        ldap-auth-config/ldapns/ldap_version    select  3
ldap-auth-config        ldap-auth-config/move-to-debconf        boolean true
ldap-auth-config        ldap-auth-config/rootbinddn     string  cn=ldapadm,dc=nti310,dclocal" > /tmp/ldap_debconf

while read line; do echo "$line" | debconf-set-selections; done < /tmp/ldap_debconf

apt-get install nfs-client

showmount -e $ipaddress # where #ip address is the ip of your nfs server
mkdir /mnt/test
#internal IP of NFS Server
echo "10.128.0.35:/var/nfsshare/testing    /mnt/test     nfs   defaults 0 0" >> /etc/fstab
mount -a
