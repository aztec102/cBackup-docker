FROM debian:stretch

RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt-get install -y --no-install-recommends \
        systemd      \
        systemd-sysv \
        cron         \
        anacron

RUN systemctl mask --   \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount

RUN rm -f           \
    /etc/machine-id \
    /var/lib/dbus/machine-id

ENV container docker

STOPSIGNAL SIGRTMIN+3

VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]

RUN apt-get -y install \
    git snmp default-jre wget openssh-server \
    php-gmp php-zip php-intl php-ssh2 php-snmp php-mbstring php-mcrypt php-bcmath php-cli php-curl \
    git apache2 php mysql-server php-mysql sudo rsyslog

RUN groupadd -r cbackup \
  && useradd -r -g cbackup -G www-data -d /opt/cbackup -s /bin/bash -c "cBackup System User" cbackup \
  && wget -q -O /tmp/cbackup.deb "http://cbackup.me/latest?package=deb" \
  && dpkg -i /tmp/cbackup.deb \
  && mv /opt/cbackup /opt/cbackup.orig \
  && mkdir /opt/cbackup \
  && chown www-data:www-data /opt/cbackup \
  && systemctl enable cbackup \
  && echo 'ServerName localhost' >> /etc/apache2/apache2.conf

EXPOSE 22 80 8437

ADD cbackup/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/sbin/init"]