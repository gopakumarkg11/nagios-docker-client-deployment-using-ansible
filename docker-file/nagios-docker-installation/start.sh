#!/bin/bash
systemctl restart apache2
systemctl restart nagios
systemctl enable nagios
systemctl restart nagios-nrpe-server
systemctl enable nagios-nrpe-server
systemctl restart sshd
systemctl enable  sshd
chown -R nagios:nagios /home/nagios/.ssh


# #Start Apache
# rm -rf /run/apache2/apache2.pid
# . /etc/apache2/envvars
# . /etc/default/apache-htcacheclean
# /usr/sbin/apache2 -DFOREGROUND



