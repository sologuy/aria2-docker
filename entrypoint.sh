#!/bin/bash
sed -i "s/rpc-secret=/#rpc-secret=/g" /data/aria2/aria2.conf                                                                                                                               
sed -i "s/#rpc-user=/rpc-user=${user}/g" /data/aria2/aria2.conf
sed -i "s/#rpc-passwd=/rpc-passwd=${pass}/g" /data/aria2/aria2.conf

sed -i "s/username/${user}/g" /data/aria2/caddy.conf
sed -i "s/password/${pass}/g" /data/aria2/caddy.conf


cd /data/aria2
nohup aria2c --conf-path=/data/aria2/aria2.conf > /data/aria2/aria2.log 2>&1 &
caddy -conf="/data/aria2/caddy.conf"

