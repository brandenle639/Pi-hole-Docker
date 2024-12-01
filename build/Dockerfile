FROM debian:bookworm-slim
COPY corefiles /corefiles
RUN chmod +x -R /corefiles && apt-get update && mkdir /etc/pihole && cp /corefiles/setupVarsdefault.conf /etc/pihole/setupVars.conf && /corefiles/basic-install-{Version Number}.sh --unattended || true
RUN rm -R /etc/pihole/* /etc/dnsmasq.d/*
RUN echo "Cmnd_Alias USER_SERVICES = /usr/sbin/service pihole-FTL start, /usr/sbin/service pihole-FTL stop, /usr/sbin/service pihole-FTL status, /usr/sbin/service lighttpd start, /usr/sbin/service lighttpd stop, /usr/sbin/service lighttpd status, /usr/local/bin/pihole, /etc/pihole, /bin/chmod 777 /etc/pihole/setupVars.conf, /usr/bin/pihole-FTL, /opt/pihole/*, /etc/pihole/*, /etc/dnsmasq.d/*" >> /etc/sudoers
RUN echo "pih ALL=(ALL) NOPASSWD:USER_SERVICES" >> /etc/sudoers
RUN useradd -s /bin/bash -d /home/pih -m pih && mkdir -p /home/pih && chown pih:pih /home/pih && usermod -aG pihole pih
USER pih
ENTRYPOINT /corefiles/entrypoint.sh	
EXPOSE 53 67 80
