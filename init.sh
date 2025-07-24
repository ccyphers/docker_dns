#!/bin/bash

ifconfig lo:0 127.0.0.2

nohup dnss -enable_dns_to_https -https_upstream="https://9.9.9.11/dns-query" -enable_dns_to_https  -dns_listen_addr=127.0.0.2:53 &

#cd /usr/bin
#setcap = pihole-FTL
#./pihole-FTL
ip=`ifconfig eth0 | grep inet | awk -F"inet " '{print $2}' | awk '{print $1}'`
sed -i -e "s/listen-address=172.17.0.2/listen-address=$ip/g" /etc/dnsmasq.conf
sed -i -e "s/listen-address 127.0.0.1:8118/listen-address $ip:8118/g" /etc/privoxy/config
mv /tmp/privoxy /etc/privoxy/config
cp /tmp/dnsmasq.conf /etc/dnsmasq.conf
pihole restartdns
/etc/init.d/privoxy start
tail -f /var/log/pihole.log
