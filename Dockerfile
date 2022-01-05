FROM ubuntu

# environment variables
ENV username admin
ENV password admin123

# 预装软件
RUN apt-get update
RUN apt-get -y install curl aria2 apt-utils unzip wget iptables

# prepare
RUN mkdir -p /data/aria2 \
    && mkdir -p /data/aria2/download \
    && touch /data/aria2/aria2.session

COPY aria2.conf /data/aria2
COPY caddy.conf /data/aria2
COPY aria2.sh /data/aria2

# 配置yaaw
COPY yaaw.zip /data/aria2
RUN cd /data/aria2 \
    && unzip yaaw.zip \
    && mv yaaw-master/* ./

# 配置canddy
COPY caddy /usr/bin/ 
RUN chmod +x /usr/bin/caddy

# 配置启动脚本
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# 开启端口
#RUN iptables -I INPUT -p tcp --dport 6080 -j ACCEPT \
#    && iptables -I INPUT -p tcp --dport 6800 -j ACCEPT \
#    && iptables -I INPUT -p tcp --dport 51413 -j ACCEPT \
#    && service iptables save \
#    && service iptables restart

# 清理
RUN rm -rf /data/aria2/*.zip \
    && rm -rf /data/aria2/*.tar.gz \
    && rm -rf /data/aria2/*.txt \
    && rm -rf /data/aria2/*.md \
    && rm -rf /data/aria2/yaaw-* 


EXPOSE 80 6800 

ENTRYPOINT ["entrypoint.sh"]
