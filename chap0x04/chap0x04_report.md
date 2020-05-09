# 实验四：shell脚本编程基础
## 实验名称：shell脚本编程基础


## 实验要求：
- 任务一：用bash编写一个图片批处理脚本，实现以下功能：  
  
  支持命令行参数方式使用不同功能  
  支持对指定目录下所有支持格式的图片文件进行批处理  
  支持以下常见图片批处理功能的单独使用或组合使用  
  支持对jpeg格式图片进行图片质量压缩  
  支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率  
  支持对图片批量添加自定义文本水印  
  支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名)  
  支持将png/svg图片统一转换为jpg格式图片  
- 任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：  
  
  2014世界杯运动员数据  
  统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比  
  统计不同场上位置的球员数量、百分比  
  名字最长的球员是谁？名字最短的球员是谁？  
  年龄最大的球员是谁？年龄最小的球员是谁？  

  Web服务器访问日志  
  统计访问来源主机TOP 100和分别对应出现的总次数  
  统计访问来源主机TOP 100 IP和分别对应出现的总次数  
  统计最频繁被访问的URL TOP 100  
  统计不同响应状态码的出现次数和对应百分比  
  分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数  
  给定URL输出TOP 100访问来源主机  
***  

## 实验环境：
- Ubuntu 18.04.4 Server 64bit  
- mac os  
- imagemagick
***
## 实验步骤：
### 安装工具  
```json  
sudo apt-get update -q  
sudo apt-get install imagemagick  
sudo apt install ghostscript  
sudo apt install p7zip-full  
#检查是否安装成功
/usr/bin/shellcheck --version  
```  
### 下载文件  
```json 
#下载任务2-1需要使用的文件 
wget "https://c4pr1c3.github.io/LinuxSysAdmin/exp/chap0x04/worldcupplayerinfo.tsv"
#下载任务2-2需要使用的文件
wget "https://c4pr1c3.github.io/LinuxSysAdmin/exp/chap0x04/web_log.tsv.7z"
#解压任务2-2需要使用的文件
7z x web_log.tsv.7z
```  
### 上传需要处理的图片
![](img/上传图片.png)  
***
## 实验结果
### 任务一:  
* 帮助信息：  
```json 
  juanermei@rhe17:~/workspace/shell$ bash chap0x04.4-1.sh -h  
  -q [quality_num][dir]		对jpeg格式图片进行图片质量压缩  
  -r [percent][dir]		        对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率  
  -w [watermark_text][dir]    	批量添加自定义文本水印  
  -p [prefix_text][dir]		统一添加文件名前缀  
  -s [suffix_text][dir]		统一添加文件名后缀  
  -c [dir]		         	将png/svg图片统一转换为jpg格式图片  
  -h 				帮助文档  
```
* 执行结果：  
  ![](img/第一个任务执行结果.png) 

### 任务二  
* 帮助信息：  
```json 
  juanermei@rhe17:~/workspace/shell$ bash chap0x04.4-2.sh -h  
  usage:[options][]
   options:
   -a          统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比
   -b          统计不同场上位置的球员数量、百分比
   -c          名字最长的球员是谁？名字最短的球员是谁？
   -d          年龄最大的球员是谁？年龄最小的球员是谁？
   -h          查看帮助信息  
```
* 执行结果：
```json 
    20岁以下的球员有 9 个，占比： 1.223%  
    20-30岁的球员有 600 个，占比：81.522%  
    30岁以上的球员有127 个，占比： 17.255%  

    位于Midfielder场上的球员有268个，占比：36.413043%  
    位于Goalie场上的球员有96个，占比：13.043478%  
    位于Forward场上的球员有135个，占比：18.342391%  
    位于Défenseur场上的球员有1个，占比：0.135870%  
    位于Defender场上的球员有236个，占比：32.065217%  

    名字最长的球员是：  
    Francisco Javier Rodriguez  
    Lazaros Christodoulopoulos  
    Liassine Cadamuro-Bentaeba  
    名字最短的球员是：  
    Jô  

    最小年龄是18,年龄最小的队员是:  
    Fabrice Olinga  
    Luke Shaw  
    最大年龄是42,年龄最大的队员是:  
    Faryd Mondragon  
```
### 任务三    
* 帮助信息：  
```json 
  juanermei@rhe17:~/workspace/shell$ bash chap0x04.4-3.sh -h  
  usage:[options][]
  options:
  -a          统计访问来源主机TOP 100和分别对应出现的总次数
  -b          统计访问来源主机TOP 100 IP和分别对应出现的总次数
  -c          统计最频繁被访问的URL TOP 100
  -d          统计不同响应状态码的出现次数和对应百分比
  -e          分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
  -u [url]    给定URL输出TOP 100访问来源主机
  -h          查看帮助信息
```
* 执行结果：
```json 
     统计访问来源主机TOP 100和分别对应出现的总次数
     show_top100_host
     host_name:edams.ksc.nasa.gov            	6530	
     host_name:piweba4y.prodigy.com          	4846	
     host_name:163.206.89.4                  	4791	
     host_name:piweba5y.prodigy.com          	4607	
     host_name:piweba3y.prodigy.com          	4416	
     host_name:www-d1.proxy.aol.com          	3889	
     host_name:www-b2.proxy.aol.com          	3534	
     host_name:www-b3.proxy.aol.com          	3463	
     host_name:www-c5.proxy.aol.com          	3423	
     host_name:www-b5.proxy.aol.com          	3411	
     host_name:www-c2.proxy.aol.com          	3407	
     host_name:www-d2.proxy.aol.com          	3404	
     host_name:www-a2.proxy.aol.com          	3337	
     host_name:news.ti.com                   	3298	
     host_name:www-d3.proxy.aol.com          	3296	
     host_name:www-b4.proxy.aol.com          	3293	
     host_name:www-c3.proxy.aol.com          	3272	
     host_name:www-d4.proxy.aol.com          	3234	
     host_name:www-c1.proxy.aol.com          	3177	
     host_name:www-c4.proxy.aol.com          	3134	
     host_name:intgate.raleigh.ibm.com       	3123	
     host_name:www-c6.proxy.aol.com          	3088	
     host_name:www-a1.proxy.aol.com          	3041	
     host_name:mpngate1.ny.us.ibm.net        	3011	
     host_name:e659229.boeing.com            	2983	
     host_name:piweba1y.prodigy.com          	2957	
     host_name:webgate1.mot.com              	2906	
     host_name:www-relay.pa-x.dec.com        	2761	
     host_name:beta.xerox.com                	2318	
     host_name:poppy.hensa.ac.uk             	2311	
     host_name:vagrant.vf.mmc.com            	2237	
     host_name:palona1.cns.hp.com            	1910	
     host_name:www-proxy.crl.research.digital.com	1793	
     host_name:koriel.sun.com                	1762	
     host_name:derec                         	1681	
     host_name:trusty.lmsc.lockheed.com      	1637	
     host_name:gw2.att.com                   	1623	
     host_name:cliffy.lfwc.lockheed.com      	1563	
     host_name:inet2.tek.com                 	1503	
     host_name:disarray.demon.co.uk          	1485	
     host_name:gw1.att.com                   	1467	
     host_name:128.217.62.1                  	1435	
     host_name:interlock.turner.com          	1395	
     host_name:163.205.1.19                  	1360	
     host_name:sgigate.sgi.com               	1354	
     host_name:bocagate.bocaraton.ibm.com    	1336	
     host_name:piweba2y.prodigy.com          	1324	
     host_name:gw3.att.com                   	1311	
     host_name:keyhole.es.dupont.com         	1310	
     host_name:n1144637.ksc.nasa.gov         	1297	
     host_name:163.205.3.104                 	1292	
     host_name:163.205.156.16                	1256	
     host_name:163.205.19.20                 	1252	
     host_name:erigate.ericsson.se           	1216	
     host_name:gn2.getnet.com                	1211	
     host_name:gwa.ericsson.com              	1089	
     host_name:tiber.gsfc.nasa.gov           	1079	
     host_name:128.217.62.2                  	1054	
     host_name:bstfirewall.bst.bls.com       	1017	
     host_name:163.206.137.21                	1015	
     host_name:spider.tbe.com                	1013	
     host_name:gatekeeper.us.oracle.com      	1010	
     host_name:www-c8.proxy.aol.com          	995	
     host_name:whopkins.sso.az.honeywell.com 	984	
     host_name:news.dfrc.nasa.gov            	966	
     host_name:128.159.122.110               	949	
     host_name:proxy0.research.att.com       	940	
     host_name:proxy.austin.ibm.com          	925	
     host_name:www-c9.proxy.aol.com          	902	
     host_name:bbuig150.unisys.com           	901	
     host_name:corpgate.nt.com               	899	
     host_name:sahp315.sandia.gov            	890	
     host_name:amdext.amd.com                	869	
     host_name:128.159.132.56                	848	
     host_name:n1121796.ksc.nasa.gov         	830	
     host_name:igate.uswest.com              	825	
     host_name:gatekeeper.cca.rockwell.com   	819	
     host_name:wwwproxy.sanders.com          	815	
     host_name:gw4.att.com                   	814	
     host_name:goose.sms.fi                  	812	
     host_name:128.159.144.83                	808	
     host_name:jericho3.microsoft.com        	805	
     host_name:128.159.111.141               	798	
     host_name:jericho2.microsoft.com        	786	
     host_name:sdn_b6_f02_ip.dny.rockwell.com	782	
     host_name:lamar.d48.lilly.com           	778	
     host_name:163.205.11.31                 	776	
     host_name:heimdallp2.compaq.com         	772	
     host_name:stortek1.stortek.com          	771	
     host_name:163.205.16.75                 	762	
     host_name:mac998.kip.apple.com          	759	
     host_name:tia1.eskimo.com               	742	
     host_name:www-e1f.gnn.com               	733	
     host_name:www-b1.proxy.aol.com          	718	
     host_name:reddragon.ksc.nasa.gov        	715	
     host_name:128.159.122.137               	711	
     host_name:rmcg.cts.com                  	701	
     host_name:bambi.te.rl.ac.uk             	701	
     host_name:electron.mcc.com              	697	
     host_name:163.205.23.76                 	691	
     
     统计访问来源主机TOP 100 IP和分别对应出现的总次数
     ip:163.206.89.4                  	4791	
     ip:128.217.62.1                  	1435	
     ip:163.205.1.19                  	1360	
     ip:163.205.3.104                 	1292	
     ip:163.205.156.16                	1256	
     ip:163.205.19.20                 	1252	
     ip:128.217.62.2                  	1054	
     ip:163.206.137.21                	1015	
     ip:128.159.122.110               	949	
     ip:128.159.132.56                	848	
     ip:128.159.144.83                	808	
     ip:128.159.111.141               	798	
     ip:163.205.11.31                 	776	
     ip:163.205.16.75                 	762	
     ip:128.159.122.137               	711	
     ip:163.205.23.76                 	691	
     ip:206.27.25.1                   	672	
     ip:198.83.19.44                  	647	
     ip:199.1.50.225                  	641	
     ip:163.205.23.93                 	624	
     ip:139.169.174.102               	610	
     ip:163.205.121.3                 	600	
     ip:140.229.116.37                	598	
     ip:141.102.82.127                	591	
     ip:163.206.140.4                 	586	
     ip:163.206.104.34                	573	
     ip:204.62.245.32                 	567	
     ip:128.159.122.38                	565	
     ip:128.217.62.224                	563	
     ip:128.159.122.107               	563	
     ip:128.159.122.180               	553	
     ip:128.159.123.58                	549	
     ip:163.205.154.11                	544	
     ip:192.112.22.119                	532	
     ip:163.205.16.100                	518	
     ip:199.201.186.103               	503	
     ip:128.159.146.40                	503	
     ip:128.159.122.160               	494	
     ip:192.77.40.4                   	486	
     ip:193.143.192.106               	482	
     ip:152.163.192.5                 	480	
     ip:163.205.23.71                 	478	
     ip:139.169.30.50                 	475	
     ip:128.159.122.144               	469	
     ip:163.234.140.22                	466	
     ip:163.205.150.22                	463	
     ip:128.217.61.184                	457	
     ip:163.205.23.72                 	451	
     ip:198.83.19.40                  	448	
     ip:128.159.122.14                	446	
     ip:199.201.186.104               	443	
     ip:198.83.19.47                  	443	
     ip:128.217.61.15                 	443	
     ip:128.159.121.34                	441	
     ip:128.159.121.41                	438	
     ip:160.205.119.27                	435	
     ip:163.205.154.17                	432	
     ip:152.163.192.38                	432	
     ip:128.159.122.15                	432	
     ip:128.159.135.73                	423	
     ip:128.159.135.38                	423	
     ip:152.163.192.35                	421	
     ip:128.159.76.128                	415	
     ip:152.163.192.71                	413	
     ip:128.159.63.159                	412	
     ip:163.205.12.100                	409	
     ip:133.53.64.33                  	404	
     ip:152.163.192.70                	402	
     ip:128.159.121.64                	397	
     ip:129.239.68.160                	396	
     ip:152.163.192.36                	391	
     ip:163.205.16.90                 	389	
     ip:128.32.196.94                 	389	
     ip:163.205.1.18                  	385	
     ip:163.206.136.1                 	384	
     ip:147.147.191.43                	383	
     ip:163.205.16.104                	374	
     ip:152.163.192.69                	374	
     ip:193.178.53.180                	373	
     ip:128.217.63.27                 	371	
     ip:130.110.74.81                 	367	
     ip:204.69.0.27                   	366	
     ip:163.206.130.46                	365	
     ip:152.163.192.67                	359	
     ip:163.205.54.76                 	357	
     ip:152.163.192.7                 	356	
     ip:198.83.19.43                  	354	
     ip:128.159.137.43                	350	
     ip:147.74.110.61                 	348	
     ip:163.205.23.44                 	345	
     ip:128.159.168.162               	343	
     ip:158.27.59.88                  	336	
     ip:152.163.192.3                 	336	
     ip:163.205.166.15                	335	
     ip:128.159.145.21                	335	
     ip:163.205.2.180                 	332	
     ip:128.217.61.98                 	329	
     ip:152.163.192.66                	328	
     ip:163.205.3.38                  	324	
     ip:163.205.2.35                  	324  

     统计最频繁被访问的URL TOP 100
     show_top100_url
     url:/images/NASA-logosmall.gif                                  	97410	
     url:/images/KSC-logosmall.gif                                   	75337	
     url:/images/MOSAIC-logosmall.gif                                	67448	
     url:/images/USA-logosmall.gif                                   	67068	
     url:/images/WORLD-logosmall.gif                                 	66444	
     url:/images/ksclogo-medium.gif                                  	62778	
     url:/ksc.html                                                   	43687	
     url:/history/apollo/images/apollo-logo1.gif                     	37826	
     url:/images/launch-logo.gif                                     	35138	
     url:/                                                           	30346	
     url:/images/ksclogosmall.gif                                    	27810	
     url:/shuttle/missions/sts-69/mission-sts-69.html                	24606	
     url:/shuttle/countdown/                                         	24461	
     url:/shuttle/missions/sts-69/count69.gif                        	24383	
     url:/shuttle/missions/sts-69/sts-69-patch-small.gif             	23405	
     url:/shuttle/missions/missions.html                             	22453	
     url:/images/launchmedium.gif                                    	19877	
     url:/htbin/cdt_main.pl                                          	17247	
     url:/shuttle/countdown/images/countclock.gif                    	12160	
     url:/icons/menu.xbm                                             	12137	
     url:/icons/blank.xbm                                            	12057	
     url:/software/winvn/winvn.html                                  	10345	
     url:/icons/image.xbm                                            	10308	
     url:/history/history.html                                       	10134	
     url:/history/apollo/images/footprint-logo.gif                   	10126	
     url:/history/apollo/images/apollo-small.gif                     	9439	
     url:/history/apollo/images/footprint-small.gif                  	9230	
     url:/software/winvn/winvn.gif                                   	9037	
     url:/history/apollo/apollo.html                                 	8985	
     url:/software/winvn/wvsmall.gif                                 	8662	
     url:/software/winvn/bluemarb.gif                                	8610	
     url:/htbin/cdt_clock.pl                                         	8583	
     url:/shuttle/countdown/liftoff.html                             	7865	
     url:/shuttle/resources/orbiters/orbiters-logo.gif               	7389	
     url:/images/shuttle-patch-logo.gif                              	7261	
     url:/history/apollo/apollo-13/apollo-13.html                    	7177	
     url:/images/                                                    	7040	
     url:/shuttle/countdown/video/livevideo2.gif                     	7029	
     url:/images/kscmap-tiny.gif                                     	6615	
     url:/shuttle/technology/sts-newsref/stsref-toc.html             	6517	
     url:/history/apollo/apollo-13/apollo-13-patch-small.gif         	6309	
     url:/shuttle/missions/sts-71/sts-71-patch-small.gif             	5613	
     url:/shuttle/missions/sts-69/images/images.html                 	5264	
     url:/icons/text.xbm                                             	5248	
     url:/images/construct.gif                                       	5093	
     url:/images/shuttle-patch-small.gif                             	4869	
     url:/shuttle/missions/sts-69/movies/movies.html                 	4846	
     url:/shuttle/missions/sts-70/sts-70-patch-small.gif             	4791	
     url:/icons/unknown.xbm                                          	4785	
     url:/shuttle/missions/sts-69/liftoff.html                       	4559	
     url:/facilities/lc39a.html                                      	4464	
     url:/shuttle/resources/orbiters/endeavour.html                  	4434	
     url:/history/apollo/images/apollo-logo.gif                      	4365	
     url:/shuttle/missions/sts-70/mission-sts-70.html                	4066	
     url:/images/lc39a-logo.gif                                      	4024	
     url:/shuttle/resources/orbiters/endeavour-logo.gif              	3817	
     url:/shuttle/technology/sts-newsref/sts_asm.html                	3706	
     url:/shuttle/countdown/countdown.html                           	3518	
     url:/shuttle/missions/sts-71/movies/movies.html                 	3507	
     url:/shuttle/countdown/video/livevideo.jpeg                     	3377	
     url:/history/apollo/apollo-11/apollo-11.html                    	3140	
     url:/shuttle/missions/sts-71/mission-sts-71.html                	3130	
     url:/shuttle/missions/sts-70/images/images.html                 	3087	
     url:/shuttle/missions/sts-71/images/images.html                 	2945	
     url:/shuttle/missions/sts-73/mission-sts-73.html                	2939	
     url:/images/faq.gif                                             	2865	
     url:/shuttle/technology/images/srb_mod_compare_1-small.gif      	2864	
     url:/shuttle/technology/images/srb_mod_compare_3-small.gif      	2818	
     url:/shuttle/technology/images/srb_mod_compare_6-small.gif      	2715	
     url:/history/apollo/apollo-11/apollo-11-patch-small.gif         	2701	
     url:/elv/elvpage.htm                                            	2586	
     url:/shuttle/missions/sts-73/sts-73-patch-small.gif             	2544	
     url:/shuttle/countdown/video/sts-69-prelaunch-pad.gif           	2385	
     url:/shuttle/missions/51-l/mission-51-l.html                    	2343	
     url:/images/launch-small.gif                                    	2293	
     url:/facilities/tour.html                                       	2256	
     url:/shuttle/missions/51-l/51-l-patch-small.gif                 	2201	
     url:/images/kscmap-small.gif                                    	2172	
     url:/shuttle/resources/orbiters/challenger.html                 	2171	
     url:/shuttle/missions/sts-71/movies/sts-71-launch.mpg           	2159	
     url:/shuttle/technology/sts-newsref/sts-lcc.html                	2146	
     url:/htbin/wais.pl                                              	2133	
     url:/facts/about_ksc.html                                       	2120	
     url:/history/mercury/mercury.html                               	2107	
     url:/images/mercury-logo.gif                                    	2040	
     url:/elv/elvhead3.gif                                           	1991	
     url:/images/launchpalms-small.gif                               	1979	
     url:/images/whatsnew.gif                                        	1936	
     url:/history/apollo/apollo-spacecraft.txt                       	1929	
     url:/facilities/vab.html                                        	1915	
     url:/shuttle/resources/orbiters/columbia.html                   	1912	
     url:/shuttle/countdown/lps/fr.html                              	1908	
     url:/shuttle/resources/orbiters/challenger-logo.gif             	1904	
     url:/images/ksclogo.gif                                         	1892	
     url:/whats-new.html                                             	1891	
     url:/elv/endball.gif                                            	1874	
     url:/history/apollo/apollo-13/apollo-13-info.html               	1869	
     url:/shuttle/missions/sts-74/mission-sts-74.html                	1868	
     url:/elv/PEGASUS/minpeg1.gif                                    	1845	
     url:/elv/SCOUT/scout.gif                                        	1835	
 
     统计不同响应状态码的出现次数和对应百分比
     status:200	num:1398987	percentage:89.11392%	
     status:302	num:26497	percentage:1.68783%	
     status:304	num:134146	percentage:8.54495%	
     status:403	num:171	percentage:0.01089%	
     status:404	num:10055	percentage:0.64049%	
     status:500	num:3	percentage:0.00019%	
     status:501	num:27	percentage:0.00172%	
     
     分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
     403:
     url:/software/winvn/winvn.html/wvsmall.gif            	32	
     url:/software/winvn/winvn.html/winvn.gif              	32	
     url:/software/winvn/winvn.html/bluemarb.gif           	32	
     url:/ksc.html/images/ksclogo-medium.gif               	12	
     url:/ksc.html/images/WORLD-logosmall.gif              	10	
     url:/ksc.html/images/USA-logosmall.gif                	10	
     url:/ksc.html/images/NASA-logosmall.gif               	10	
     url:/ksc.html/images/MOSAIC-logosmall.gif             	10	
     url:/ksc.html/facts/about_ksc.html                    	5	
     url:/ksc.html/shuttle/missions/missions.html          	4	
     
     404:
     url:/pub/winvn/readme.txt                             	1337	
     url:/pub/winvn/release.txt                            	1185	
     url:/shuttle/missions/STS-69/mission-STS-69.html      	683	
     url:/images/nasa-logo.gif                             	319	
     url:/shuttle/missions/sts-68/ksc-upclose.gif          	253	
     url:/elv/DELTA/uncons.htm                             	209	
     url:/history/apollo/sa-1/sa-1-patch-small.gif         	200	
     url:/://spacelink.msfc.nasa.gov                       	166	
     url:/images/crawlerway-logo.gif                       	160	
     url:/history/apollo/a-001/a-001-patch-small.gif       	154
     
     给定URL输出TOP 100访问来源主机
     Input URL: /images/USA-logosmall.gif
     host:edams.ksc.nasa.gov            	    867	
     host:163.206.89.4                  	    237	
     host:n1144637.ksc.nasa.gov         	    213	
     host:163.205.19.20                 	    204	
     host:128.217.62.1                  	    198	
     host:163.205.3.104                 	    166	
     host:n1121796.ksc.nasa.gov         	    136	
     host:www-b2.proxy.aol.com          	    131	
     host:www-b3.proxy.aol.com          	    128	
     host:www-b4.proxy.aol.com          	    126	
     host:www-d3.proxy.aol.com          	    123	
     host:163.205.11.31                 	    122	
     host:piweba4y.prodigy.com          	    120	
     host:mpngate1.ny.us.ibm.net        	    120	
     host:www-d1.proxy.aol.com          	    117	
     host:www-b5.proxy.aol.com          	    116	
     host:piweba5y.prodigy.com          	    116	
     host:www-c6.proxy.aol.com          	    113	
     host:www-c5.proxy.aol.com          	    113	
     host:www-c2.proxy.aol.com          	    113	
     host:www-c1.proxy.aol.com          	    113	
     host:piweba3y.prodigy.com          	    113	
     host:www-d4.proxy.aol.com          	    111	
     host:www-d2.proxy.aol.com          	    111	
     host:www-a1.proxy.aol.com          	    111	
     host:163.205.23.76                 	    111	
     host:www-c4.proxy.aol.com          	    110	
     host:www-c3.proxy.aol.com          	    110	
     host:128.159.144.83                	    110	
     host:n1131455.ksc.nasa.gov         	    108	
     host:n1376232.ksc.nasa.gov         	    107	
     host:www-a2.proxy.aol.com          	    106	
     host:n1040681.ksc.nasa.gov         	    106	
     host:128.217.62.2                  	    106	
     host:163.205.16.75                 	    105	
     host:n1123413.ksc.nasa.gov         	    104	
     host:163.205.23.93                 	    104	
     host:n1123543.ksc.nasa.gov         	    101	
     host:163.205.121.3                 	    99	
     host:webgate1.mot.com              	    91	
     host:intgate.raleigh.ibm.com       	    91	
     host:128.159.132.56                	    91	
     host:derec                         	    89	
     host:163.206.104.34                	    89	
     host:n1144796.ksc.nasa.gov         	    88	
     host:poppy.hensa.ac.uk             	    87	
     host:163.205.154.11                	    87	
     host:n1142702.ksc.nasa.gov         	    86	
     host:n1031729.ksc.nasa.gov         	    84	
     host:163.205.16.100                	    84	
     host:n1031701.ksc.nasa.gov         	    82	
     host:n1123724.ksc.nasa.gov         	    79	
     host:n1123209.ksc.nasa.gov         	    79	
     host:n1121793.ksc.nasa.gov         	    79	
     host:piweba1y.prodigy.com          	    76	
     host:n167331.ksc.nasa.gov          	    76	
     host:n1031727.ksc.nasa.gov         	    75	
     host:128.217.61.15                 	    73	
     host:n1144636.ksc.nasa.gov         	    71	
     host:n1032026.ksc.nasa.gov         	    71	
     host:bensmtp.ksc.nasa.gov          	    71	
     host:news.ti.com                   	    70	
     host:n1031857.ksc.nasa.gov         	    70	
     host:163.206.140.4                 	    70	
     host:163.205.23.71                 	    70	
     host:128.159.135.73                	    70	
     host:n1028288.ksc.nasa.gov         	    69	
     host:n1031627.ksc.nasa.gov         	    68	
     host:n1028722.ksc.nasa.gov         	    68	
     host:163.205.12.100                	    67	
     host:pl01265.ksc.nasa.gov          	    66	
     host:163.205.23.72                 	    66	
     host:128.159.146.40                	    66	
     host:n167440.ksc.nasa.gov          	    65	
     host:128.159.122.14                	    65	
     host:163.205.16.90                 	    64	
     host:128.217.61.98                 	    64	
     host:128.159.63.159                	    64	
     host:www-proxy.crl.research.digital.com	63	
     host:192.77.40.4                   	    63	
     host:163.205.1.19                  	    63	
     host:128.159.135.38                	    63	
     host:palona1.cns.hp.com            	    61	
     host:n1032336.ksc.nasa.gov         	    61	
     host:n1123732.ksc.nasa.gov         	    60	
     host:waldtsvr.ksc.nasa.gov         	    59	
     host:bocagate.bocaraton.ibm.com    	    59	
     host:n868370.ksc.nasa.gov          	    58	
     host:128.159.168.162               	    57	
     host:128.159.121.41                	    57	
     host:vagrant.vf.mmc.com            	    56	
     host:n874797.ksc.nasa.gov          	    56	
     host:n1135966.ksc.nasa.gov         	    56	
     host:163.205.162.111               	    56	
     host:163.205.150.22                	    56	
     host:n1121869.ksc.nasa.gov         	    55	
     host:lahal.ksc.nasa.gov            	    55	
     host:192.112.22.119                	    55	
     host:128.159.123.58                	    55	
     host:n1121985.ksc.nasa.gov         	    54	
```
***  
## 遇到的问题及解决方案  
### 问题描述：
* 解压web_log.tsv.7z文件失败，Open ERROR: Can not open the file as [7z] archive
![](img/解压失败.png) 
### 解决方案：
通过ls -hl web*命令查看下载文件状态，得到以下四个文件，成功完整下载的是web_log.tsv.7z.3而不是web_log.tsv.7z，解压web_log.tsv.7z.3成功，问题解决。
![](img/解压成功.png) 
## 参考资料
* [linux-2020-xjh2811763956]https://github.com/CUCCS/linux-2020-xjh2811763956/pull/4/commits/5f9e8f67283f0803caf6e20856c2dc1d18070727  
* [linux-2020-Beautifullyl]https://github.com/CUCCS/linux-2020-Beautifullyl/pull/4/files?file-filters%5B%5D=.jpg&file-filters%5B%5D=.md&file-filters%5B%5D=.png&file-filters%5B%5D=.sh&file-filters%5B%5D=.yml&file-filters%5B%5D=dotfile  
* [linux-2020-xjh2811763956]https://github.com/CUCCS/linux-2020-xjh2811763956/pull/4/commits  
* [shell求两个数相除后的百分比]https://www.cnblogs.com/wowchky/archive/2012/10/18/2729075.html  
* [shell脚本中大于，大于等于，小于，小于等于、不等于的表示方法]https://blog.csdn.net/weixin_37998647/article/details/79718821  
* [一个很不错的bash脚本编写教程]https://blog.csdn.net/weixin_41918841/article/details/82666098  
***