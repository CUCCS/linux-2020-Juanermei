# 实验八：使用容器技术重构FTP、NFS、DHCP、DNS、Samba服务器的自动安装与自动配置  
## 实验环境：
- Ubuntu 18.04.4 Server 64bit  
- mac os  
- 工作主机：192.168.56.101 juanermei@cuc-server
- 目标主机：192.168.57.3 root@client
***
## 实验步骤：
### 配置工作主机到目标主机的远程SSH root用户登陆  
- 工作主机操作：
```json  
# 在工作主机生成ssh-key
ssh-keygen -b 4096
#工作主机通过ssh-copy-id方式导入ssh-key 
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.57.3  
```  
### 在目标主机上安装docker  
```json  
sudo apt updata
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"  
sudo apt install docker-ce
#查看docker版本
docker version
#修改/etc/dockers/daemon.json文件，添加以下内容
"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn/"]
#重启docker
sudo systemctl restart docker
```  
### FTP：vsftpd
* 下载镜像   
`docker pull fauria/vsftpd`  
* 运行docker镜像,创建Container  
```json
docker run -d -p 21:21 -p 20:20 -p 21100-21110:21100-21110 -v /data/docker/ftpFile:/home/vsftpd -e FTP_USER=Cara -e FTP_PASS=123456 -e PASV_ADDRESS=192.168.56.103 -e PASV_MIN_PORT=21100 -e PASV_MAX_PORT=21110 --name vsftpd --restart=always fauria/vsftpd
```
* 进入vsftpd镜像对应的container中,并在新用户目录下创建文件  
`docker exec -i -t vsftpd bash`  

### NFS  
* 下载镜像   
`docker pull itsthenetwork/nfs-server-alpine:latest`  
* 运行docker镜像,创建Container  
```json
docker run -d --name nfs --privileged -p 21:21 -v /tmp/test1:/home/nfs/on_r -e SHARED_DIRECTORY=/home/nfs/on_r -e NFS_EXPORT_DIR_1=/home/nfs/on_r -e NFS_EXPORT_DOMAIN_1=192.168.56.103 -e NFS_EXPORT_OPTIONS_1=ro,sync,no_subtree_check,fsid=1 -v /tmp/test2:/home/nfs/on_rw -e SHARED_DIRECTORY=/home/nfs/on_rw -e NFS_EXPORT_DIR_2=/home/nfs/on_rw -e NFS_EXPORT_DOMAIN_2=192.168.56.103 -e NFS_EXPORT_OPTIONS_2=rw,sync,no_subtree_check,fsid=2 itsthenetwork/nfs-server-alpine:latest
```

### DHCP
*  Host
      *  IP：192.168.56.101
      *  下载镜像  
        `sudo docker pull networkboot/dhcpd`
      *  创建data目录，创建dhcpd.conf文件
      ```json
          #在dhcpd.conf文件中添加以下内容
          subnet 192.168.57.3 netmask 255.255.255.0 {
          # client's ip address range
          range 192.168.57.3 192.168.57.254;
          default-lease-time 600;
          max-lease-time 7200;
          }
      ``` 
      *  修改`/etc/netplan/01-netcfg.yaml`文件  
      ```json
          #添加以下内容
          enp0s9:
            dhcp4: no
            dhcp6: no
            addresses: [192.168.57.1/24]
      ```  
      *  运行docker镜像,创建Container
        `docker run -it --rm --net=host -v "$(pwd)/data":/data --name dhcpd networkboot/dhcpd enp0s9`

*  Client
      *  IP：192.168.57.3
      *  修改`/etc/netplan/01-netcfg.yaml`文件  
      ```json
          #添加以下内容
          enp0s9:
          dhcp4: yes
          dhcp6: yes
        
          sudo netplan apply
      ```
### DNS
* 下载镜像   
`sudo docker pull jpillora/dnsmasq`  
* 修改配置文件/opt/dnsmasq.conf  
```json
# 解析日志
log-queries
no-resolv
# DNS解析服务器地址
server=192.168.56.104
# 定义主机与ip映射
address=/db.sec.com/192.168.56.104
```
* 运行docker镜像,创建Container  
```json
docker run \
--name dnsmasq \
-d \
-p 53:53/udp \
-p 8080:8080 \
-v /opt/dnsmasq.conf:/etc/dnsmasq.conf \
--log-opt "max-size=100m" \
-e "HTTP_USER=admin" \
-e "HTTP_PASS=admin" \
--restart always \
jpillora/dnsmasq
```

### Samba
* 下载镜像   
`docker pull dperson/samba`  
* 在主机建立共享文件夹，设置文件夹权限为0775(sharesA为指定用户文件夹，sharesB为匿名文件夹)  
```json
sudo chmod 0775 data/shares/sharesA
sudo chmod 0775 data/shares/sharesB
```
* 运行docker镜像,创建Container  
```json
docker run -it --name samba_docker -p 139:139 -p 445:445 -v /data/shares/sharesA:/home/shares/shareA -v /data/shares/sharesB:/home/shares/shareB -d dperson/samba -w "WORKGROUP" -u "userA;123456789" -s "shareA;/home/shares/shareA;yes;no;no;userA;userA;userA" -s "shareB;/home/shares/shareB;yes;yes;yes;"
```
***  
## 参考资料
 * [Docker快速搭建docker-nfs-server服务器](https://blog.csdn.net/Aria_Miazzy/article/details/85237758)
 * [用docker搭建samba服务器-2019-03-31](https://blog.csdn.net/lggirls/article/details/88937389)
 * [dhcpd.conf 详细说明以及使用 docker 启动 dhcpd 服务器](https://blog.csdn.net/kunyus/article/details/104419468?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.nonecase)
***
