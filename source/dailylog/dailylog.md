```
虚拟机 
	快照一 NAT 模式 192.168.184.0
elasticsearch，FastDFS，nginx，docker
redis，MySQL，maven，Java
全部开机自启，以上软件防火墙端口放开
es需要手动启动  es不能用root启动使用admin用户
su  admin  admin
/opt/elasticsearch-6.3.0/bin
./elasticsearch

 systemctl start firewalld

 systemctl stop firewalld
 禁止开机启动
 systemctl disable firewalld.service
 查看防火墙状态
 service firewalld status 
 放行端口7
 firewall-cmd --zone=public --add-port=9000/tcp --permanent
 放行端口5.4
 /sbin/iptables -I INPUT -p tcp --dport 8084 -j ACCEPT
 /sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT 
 /etc/rc.d/init.d/iptables save
 关闭端口
 firewall-cmd --zone=public --remove-port=9000/tcp --permanent
 firewall-cmd --reload     
 firewall-cmd --list-ports
 重启网卡 systemctl restart network
 Windows启动redis  redis-server.exe redis.windows.conf
 查看已经安装的CentOS版本信息  cat /etc/redhat-release

Linux查看并杀死被占用的端口

iftop
查看实时带宽流量情况

以M为单位显示文件大小
		ls -l --block-size=M
tail -f catalina.out
查找最新的一百行中与多个字匹配的行
tail -1000f ms-content-api.log |grep -E 'SpringCacheConfig|ResponseBodyWrapHandler|publishListByTitleName'
cat catalina.out | grep '6602012020110112024017'
匹配多个关键字
cat catalina.out | grep '6602012020110112024017'  | grep '6602012020110112024017' 
cat error.log | grep -C 5 'nick' 显示file文件里匹配foo字串那行以及上下5行
cat error.log | grep -B 5 'nick' 显示foo及前5行
cat error.log | grep -A 5 'nick' 显示foo及后5行

头部N条数据
cat A/ms-content-api/ms-content-api.log |grep -E 'ApiAspect' -C 10|head -10

尾部N条数据
cat A/ms-content-api/ms-content-api.log |grep -E 'ApiAspect' -C 10|tail -10

more +n 从n行开始
more 进入后 /字符串 搜索字符串
1. 打包压缩
tar -zcvf pack.tar.gz pack/  #打包压缩为一个.gz格式的压缩包
tar -jcvf pack.tar.bz2 pack/ #打包压缩为一个.bz2格式的压缩包
tar -Jcvf pack.tar.xz pack/  #打包压缩为一个.xz格式的压缩包
2. 解包解压
tar -zxvf pack.tar.gz /pack  #解包解压.gz格式的压缩包到pack文件夹
tar -jxvf pack.tar.bz2 /pack #解包解压.bz2格式的压缩包到pack文件夹
tar -Jxvf pack.tar.xz /pack  #解包解压.xz格式的压缩包到pack文件夹


追加方式压缩当前目录
zip -r xxx.zip ./*

压缩文件到zip -r 目录
zip filname.zip filename

解压zip文件到当前目录
unzip filename.zip

jdk的一条命令查看运行参数
jps -mlv
查看运行的java进程;
jinfo <pid>
查看 jvm 配置参数
java 进程重启时间
ps axo pid,ppid,comm,pmem,lstart | grep java
arthas导出堆文件
heapdump /mnt/temp/dump.hprof
jdk导出堆文件 不想触发 FGC去掉live
jmap -dump:format=b,file=/mnt/temp/dump.hprof 7114
jmap -dump:live,format=b,file=/path/to/heap.hprof 7114
分析堆 dump 文件，可以使用 JDK 自带的 jvisualvm 工具，命令行中直接输入即可：
jvisualvm(还有Memory Analyzer (MAT) )

优化java应用内存配置(优化jvm配置参数)
查看gc记录
jstat -gcutil 30616 5s 10
查看内存使用情况
jmap -heap 30616
-Xms512m -Xmx3000m -XX:NewSize=512m -XX:MaxNewSize=1000m -XX:NewRatio=3
Xms 初始堆容量
Xmx 最大堆容量
XX:NewSize    新生代初始化内存的大小(注意：该值需要小于-Xms的值)
XX:MaxnewSize 新生代可被分配的内存的最大上限(注意：该值需要小于-Xmx的值)
XX:NewRatio   年老代和新生代相对的比例


登录本地虚拟机
ssh root@192.168.184.7
sftp
sftp root@192.168.184.7
put  file  上传
put -r files  递归上传
get  file  下载
get -r files  递归下载
加 l 表示本地命令 例如 lpwd 显示本地路径
ssh上传下载
本地文件复制到远程
scp /data/WEBLOG/htjf-wechat-cms-provider/htjf-wechat-cms-provider.log  root@172.16.198.102:~/
本地文件夹复制到远程
scp -r /data/WEBLOG/htjf-wechat-cms-provider/  root@172.16.198.102:~/



scp D:/maliceIp307.txt root@192.168.184.7:/root/
scp root@192.168.184.7:/root/.bash_history d:/.bash_history

windows 端口占用
netstat -aon|findstr "8099"
tskill 4


java  环境变量
 .bash_profile 当前用户的环境变量配置文件在 当前用户的根目录下 刷新使用source .bash_profile
 /etc/profile root 用户 source /etc/profile
 
pwdx 12610  进程目录

所有端口的进程以及安装目录
pwdx `netstat -lntp | grep -v Proto|awk '{print $7}'| awk -F/ '{print $1}'`
指定端口的进程以及安装目录
pwdx `netstat -lntp | grep -v Proto|grep 9500|awk '{print $7}'| awk -F/ '{print $1}'`

chmod u+x *.sh // 为所有sh文件执行权限
打印时间 date "+%Y-%m-%d %H:%M:%S"

netstat -nap | grep 20859      指定进程的端口号
sudo apt-get install lsof 　　//安装lsof
sudo lsof -i:端口号　　　　　　//查找对应的进程号
sudo pwdx:进程号  				//进程对应目录
sudo kill -9 进程号　　　　　　//杀死对应的进程
命令用于查找文件,原始代码、二进制文件，或是帮助文件。查找程序安装目录  whereis  python

CPU 信息
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c

系统版本信息
lsb_release -a

ll -lht fiel.name  文件大小
du -h 以M为单位但排序有问题
查看文件或者文件夹大小
du -sh fileName/filePath | sort -h
目录占用大小从大到小排序
du -ah --max-depth=1 /data/ | sort -rn
当前目录所有文件文件夹大小并倒叙排序
du -sh * |sort -rn
当前目录所有文件文件夹大小并排除某个目录
du -sh --exclude="proc" /*
df -hl 磁盘信息
文件系统              容量 已用 可用 已用% 挂载点　
Filesystem            Size Used Avail Use% Mounted on

检查登录日志 who /var/log/wtmp
账号登录干了些什么 切换到username下输入 history
删除文件时排除某个文件 
rm -rf `ls |egrep -v '(a.txt|c.txt)'`



内存使用情况 
	free -m
	  真正已经用的内存数：used-(buffers+cached)的值。
      真正未用到的内存数：free+buffers+cached  的值。

安装htop
yum install -y epel-release
yum install -y htop


 1、淘宝网（(精确到省份）
API地址： 
http://tcc.taobao.com/cc/json/mobile_tel_segment.htm?tel=17560308198

2、百度(精确到地市)
API地址：
http://mobsec-dianhua.baidu.com/dianhua_api/open/location?tel=17560308198

3.k780(最为详细)
http://api.k780.com:88/?app=phone.get&phone=17560308198&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4
身份证
http://api.k780.com:88/?app=idcard.get&idcard=511423199003240017&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json

获取公网ip
curl -L ip.tool.lu


 后台运行jar 
	nohup java -jar test.jar &
find /data/WEBLOG -type d -iname "*pof*"
查找文件忽略文件名
sudo find /data/project/ -name '*.jar' |sed 's#.*/##'

kill -s 9 xxx 杀死进程 
ps  aux|grep  redis 查看进程
ps -ef | grep ms-content
ef 标准格式 aux BSD格式
ll /proc/pid  查看进程目录
软连接 ln -s 源文件 目标文件
redis-cli -h 39.106.107.216 -p port -a password
win终止进程 
	netstat -aon|findstr "80"  查找端口的进程号
	tasklist|findstr "2132"    查找进程号的进程
	taskkill /f /t /im nginx.exe  杀掉进程
	taskkill /f /pid pid  杀掉进程
	
 Vim编辑器 
	 显示行号 set nu 
	 跳转行 100gg  &  100G
	 gg 第一行 G 最后一行
tomcat 日志 logs 目录下 tail -f catalina.out
MongoDB  E:\install\mongodb\bin 
mongod --config E:\install\mongodb\mongo.config 
cmd  mysql
		mysql -h9.1.120.87 -uwestore -p123456

mysql常用		
SHOW TABLE STATUS WHERE comment='view';
SHOW  TABLES;
SHOW  TRIGGERS;
SHOW  CREATE TRIGGER updatexilei;
SHOW  CREATE TABLE account;
SHOW  CREATE VIEW view_users;

http://localhost:27017/
修改文件时间
 touch -d "2020-06-05 15:09:56" RedissonSpikeServiceDasImpl.class
git 切换分支
	git checkout 分支名
git 切换版本
	git reflog
	git reset --hard 版本号
git 切换分支
	查看本地分支：      git branch
	查看远程分支      git branch -a 
	更新的新代码想提交到development分支上
	git checkout -b development origin/development
TAPD git统计
在Git平台 Commit代码时，备注中输入以下关键字即可关联TAPD的需求、缺陷、任务。
需求描述：--story=[story id] --user=[usernick]
缺陷描述：--bug=[bug id] --user=[usernick]
任务描述：--task=[task id] --user=[usernick]
例：--story=500629523 --user=JiangYuhao 
git 统计提交次数
git log --oneline --author="JiangYuhao" | wc -l
git 统计提交行数
git log --author="JiangYuhao" --since=2020-01-01 --until=2025-01-01 --pretty=tformat: --numstat | awk '{add += 2; loc += 2} END {printf "added lines:%s removed lines:%s total lines: %s\n", add,subs,loc}'

git 分支命名规则
产品分支 master
开发分支 develop
功能分支 feature
补丁分支 hotfix
版本分支 release

指定账号拉取
git clone  https://item-dev:item-dev98@gitee.com/mtjk/mx-goldnurse.git

docker run -d --name myredis -p 6379:6379 redis --requirepass "redis"
idea乱码  
	在服务器配置和idea64.exe.vmoptions文件中写入
	-Dfile.encoding=UTF8
mvn 打包本地jar
mvn install:install-file -Dfile=org.mozilla.javascript-1.7.2.jar -DgroupId=org.mozilla.javascript -DartifactId=javascript -Dversion=1.7.2 -Dpackaging=jar
mvn 打包指定pom跳过测试lib输出
mvn clean package -f /Users/yho/WorkFile/code/start-boot/start-boot-web/pom.xml -Dmaven.test.skip=true  dependency:copy-dependencies -DoutputDirectory=/data/data/maven/lib
后台部署jar指定输出
nohup java -jar /data/work/ms-content-api/ms-content-api-0.0.2-SNAPSHOT.jar --spring.profiles.active=test > /data/WEBLOG/ms-content-api/ms-content-api.log & 
不输出日志
nohup java -jar goldnurse-platform-1.0.0-RELEASE.jar   >/dev/null 2>&1 &
批量杀死所有java进程
jps | awk '{print $1}' |xargs kill
java查看字节码信息格式化的,并生成文本信息
javac class.java
javap -c class >> class.txt
 微信小程序
	3451105769@qq.com qazplm98
	AppID(小程序ID)			wxccda3b6f059c87fb
	AppSecret(小程序密钥)	e8d8519ec123beb818fd280816547abf
	威豆自由保 wx67f8e4aa355f388d wx908f213c7987039d

 select sal,
         row_number() over(order by sal desc) rank1,
         rank() over(order by sal desc) rank,
         dense_rank() over(order by sal desc) drank
 from emp
 
 解压打包jar
 jar -xvf X.jar
 jar -cvf X.jar ./
 
maven 编译本地jar
mvn install:install-file -DgroupId=com -DartifactId=js-14 -Dversion=1.0.0.1 -Dpackaging=jar -Dfile=js-14-1.0.0.1.jar
mvn install:install-file -DgroupId=com -DartifactId=js -Dversion=1.0.0.1 -Dpackaging=jar -Dfile=js-1.0.0.1.jar
HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

Tomcat 内存调优
在catalina.sh
增加 JAVA_OPTS="$JAVA_OPTS -server -Xms2048m -Xmx2048m -XX:PermSize=1024M -XX:MaxPermSize=512m" 
-vmargs 说明后面是VM的参数，所以后面的其实都是JVM的参数了
-Xms256m JVM初始分配的堆内存
-Xmx512m JVM最大允许分配的堆内存，按需分配
-XX:PermSize=256M JVM初始分配的非堆内存
-XX:MaxPermSize=512M JVM最大允许分配的非堆内存，按需分配


$.ajax({
         type: "GET",
         url: "test.json",
         data: {username:$("#username").val(), content:$("#content").val()},
         dataType: "json",
         success: function(data){
                    console.log(data);
                  }
        });
	
	
SpringCloud分布式开发五大组件
服务发现——Netflix Eureka

客服端负载均衡——Netflix Ribbon

断路器——Netflix Hystrix

服务网关——Netflix Zuul

分布式配置——Spring Cloud Config	

```

