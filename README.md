# Aria2-Docker
## 简介
这是一个在Linux x64系统上自动部署Aria2 + YAAW + FileManager(Caddy)的镜像。

* [Aria2](https://github.com/aria2/aria2)是一个支持多种协议的下载工具
* [YAAW](https://github.com/binux/yaaw)是纯HTML/CSS/JS编写的Aria2前端
* [FileManager](https://github.com/hacdias/filemanager)是个可以在线管理文件的Caddy插件

## 依赖
- YAAW  来自于https://github.com/helloxz/yaaw/archive/master.zip
- Caddy 来自于 http://soft.xiaoz.org/linux/caddy.filemanager

## 使用
1. 在Linux x64系统上[安装Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)
2. 拉取本项目仓库
```bash
git clone https://github.com/sologuy/aria2-docker.git
```
3. 构建镜像
```bash
cd aria2-docker 
docker build -t aria2 .
```
4. 启动容器
```bash
docker run -d --name aria2 -e user=admin -e pass=admin123 -p 8099:80 -p 6800:6800 -v /root/downloads:/data/aria2/download aria2
```
5. 浏览器打开`http://[服务器域名或IP]:8099`，在YAAW的设置里把`JSON-RPC Path`改为`http://admin:admin123@服务器域名或IP:6800/jsonrpc`即可使用YAAW管理Aria2
6. 浏览器打开`http://[服务器域名或IP]:8099/admin/files/download/`即可查看、管理下载的文件

## 参数释义
* `--name aria2`: 容器的名字，可省略
* `-e user=admin`: Web访问的用户名，省略则使用默认值admin
* `-e pass=admin123`: Web访问的密码，省略则使用默认值admin123
* `-p 8099:80`: 把主机8099端口映射到容器80端口供Web访问
* `-p 6800:6800`: 把主机6800端口映射到容器6800端口供RPC调用
* `-v /root/downloads:/data/aria2/download`: 把主机`/root/downloads`目录挂载到容器`/data/aria2/download`目录用来存放下载的文件

## 参考项目
* [Aria2-Docker](https://github.com/zyfworks/aria2-docker) 另一个yaaw的docker项目，但是其中有一个下载链接是私有的，无法直接使用
* [LACY](https://github.com/helloxz/aria2) 一个aria2+yaaw+caddy的一键安装脚本
