FROM debian:bookworm-slim


ADD init.sh /init.sh


RUN apt update && \
    apt install -y dnss ca-certificates    && \
    chmod 755 /init.sh

EXPOSE 53/udp
WORKDIR /
CMD ["/init.sh"]
