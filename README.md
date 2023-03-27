Nagios Docker 
To properly configure our system, we need to mount three volumes: rummy passion, servers, and .ssh. The rummy passion volume contains the SSL certificate necessary for secure communication, while the volume of the server holds the client configurations. The .ssh volume stores the SSH configuration details for the Nagios user, which are necessary for using the check_by_ssh command in Nagios. By mounting these volumes, we can ensure that our system has access to the necessary files and configurations.




URL : localhost/nagios or domain/nagios
Username : nagiosadmin
Password : admin@123