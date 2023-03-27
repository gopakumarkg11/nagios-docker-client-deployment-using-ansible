FROM ubuntu:focal
ENV DEBIAN_FRONTEND noninteractive
ENV TZ="Asia/Kolkata"
RUN date
RUN apt update -y
RUN apt install -y \    
    autoconf \
    bc \
    gawk \
    dc \
    build-essential \
    gcc \
    libc6 \
    make \
    wget \
    unzip \
    apache2 \
    php \
    libapache2-mod-php \
    libgd-dev \
    libmcrypt-dev \
    make \
    libssl-dev \
    snmp \
    libnet-snmp-perl \
    gettext \
    mailutils \
    ssmtp 
COPY ssmtp.conf /etc/ssmtp
COPY ssl-nagios.conf /etc/apache2/sites-available
RUN apt update
RUN apt install -y openssh-server
RUN mkdir -p /etc/ssl/nagios-ssl
RUN a2enmod ssl
RUN a2ensite ssl-nagios.conf
COPY nagioscore-nagios /nagioscore-nagios
WORKDIR /nagioscore-nagios
RUN ./configure --with-httpd-conf=/etc/apache2/sites-enabled
RUN make all
RUN make install-groups-users
RUN usermod -a -G nagios www-data
RUN make install
RUN make install-daemoninit
RUN make install-commandmode
RUN make install-config
RUN make install-webconf
RUN a2enmod rewrite cgi
RUN apt install -y monitoring-plugins nagios-nrpe-plugin
RUN mkdir -p /usr/local/nagios/etc/servers
COPY nagios.cfg /usr/local/nagios/etc
COPY resource.cfg /usr/local/nagios/etc
COPY commands.cfg /usr/local/nagios/etc/objects
COPY contacts.cfg /usr/local/nagios/etc/objects
COPY htpasswd.users /usr/local/nagios/etc
RUN apt update -y 
RUN apt install -y nagios-nrpe-server monitoring-plugins
COPY nrpe.cfg /etc/nagios/
COPY nrpe_local.cfg /etc/nagios/
COPY check_mem /usr/lib/nagios/plugins
COPY check_mysql_connections /usr/lib/nagios/plugins
COPY start.sh /
RUN usermod -c "Nagios Alert env name " nagios
RUN chsh --shell /bin/bash  nagios
RUN mkdir -p /home/nagios/.ssh
WORKDIR /
ADD start.sh /
RUN chmod +x /start.sh
ENV container docker
RUN apt update -y
RUN apt-get install -y --no-install-recommends
RUN apt-get install -y systemd
RUN apt-get install -y systemd-sysv
RUN systemctl mask --   \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" , "/usr/local/nagios/etc/servers" , "/etc/ssl/nagios-ssl" , "/home/nagios/.ssh" ]
EXPOSE 80
EXPOSE 5666
EXPOSE 443
CMD [ "/sbin/init" , "/start.sh" ]


