#!/bin/bash

yum -y install nagios
systemctl enable nagios
systemctl start nagios

chmod 775 /etc/nagios/servers
usermod -a -G root cng00006@seattlecentral.edu

setenforce 0
sed -i 's/SELINUX=enforceing/SELINUX=disabled/g' /etc/selinux/config

systemctl enable httpd
systemctl start httpd

yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe
yum -y install nagios-plugins-all
yum -y install nagios-plugins-nrpe

htpasswd -b /etc/nagios/passwd nagiosadmin nagiosadmin
sed -i 's,allowedhosts=127.0.0.1,allowed_hosts=127.0.0.1\,10.138.0.0\/20,g' /etc/nagios/nrpe.cfg


sed -i 's,dont_blame_nrpe=0,dont_blame_nrpe=1,g' /etc/nagios/nrpe.cfg




sed -i 's,#cfg_dir=/etc/nagios/servers,cfg_dir=/etc/nagios/servers,g' /etc/nagios/nagios.cfg
echo 'define command{
                                command_name check_nrpe
                                command_line /usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
                              }' >> /etc/nagios/objects/commands.cfg



yum -y install wget
cd /etc/nagios
wget https://raw.githubusercontent.com/nic-instruction/hello-nti-320/master/generate_config.sh













/usr/sbin/nagios -v /etc/nagios/nagios.cfg
