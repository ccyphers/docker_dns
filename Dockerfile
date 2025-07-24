FROM debian:bookworm-slim


ADD init.sh /init.sh

ADD setupVars.conf /etc/pihole/setupVars.conf

ADD basic-install.sh /basic-install.sh

RUN apt update && \
    apt install -y vim dnss curl net-tools privoxy && \
    chmod 755 /init.sh /basic-install.sh && \
    cat /basic-install.sh | PIHOLE_SKIP_OS_CHECK=true bash /dev/stdin --unattended

COPY etc-pihole /etc/pihole

COPY dnsmasq.conf /etc/dnsmasq.conf

COPY etc-dnsmasq.d /etc/dnsmasq.d
    
EXPOSE 53/udp
WORKDIR /
CMD ["/init.sh"]
