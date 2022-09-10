根目录创建文件
重启系统 command+R 
关闭sip csrutil disable
重新挂载磁盘  sudo mount -uw /
创建软连接 ln -s /opt /data

挂载目录(可行)编辑文件 重启
sudo vim /etc/synthetic.conf
data /opt (文件内容中间空格为tab)



内网穿透（&后台运行）
cd /Users/yho/WorkFile/install/IOEE
nohup ./client_darwin_amd64 -s jp.cdjxt.net -p 5993 -k d05b5f2caa5f4830a5236f30348d795a -ssl true 
nohup ./client_darwin_amd64 -s jp.cdjxt.net -p 5993 -k d05b5f2caa5f4830a5236f30348d795a -ssl true &

内网穿透nps
https://blog.csdn.net/hnjb5873/article/details/110481107
mac 客户端下载https://hub.fastgit.org/ehang-io/nps/releases/download/v0.26.10/darwin_amd64_client.tar.gz
nohup ./npc -server=180.76.140.42:8024 -vkey=4glcldictvz677gw -type=tcp > nps.log 2>&1 &

item2 脚本登录
https://www.jianshu.com/p/4d79c4a4946c

brew（homeBrew）https://zhuanlan.zhihu.com/p/111014448
安装脚本：
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
卸载脚本：
/bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/HomebrewUn
brew search **  //查找某个软件包
brew list  //列出已经安装的软件的包
brew install ** //安装某个软件包,默认安装的是稳定版本
brew uninstall **//卸载某个软件的包
brew upgrade ** //更新某个软件包
brew info ** //查看指定软件包的说明
brew cache clean //清理缓存
主程序目录 /usr/local/Cellar/software
程序运行数据
the configuration file (/usr/local/etc/software.conf)
the log directory path (/usr/local/var/log/software)
the data directory path (/usr/local/var/software)
nginx html /usr/local/var/www

重启之后刷新一下 source .bash_profile

启动mysql mysql.server start
关闭mysql mysql.server stop

启动redis brew services start redis@3.2
关闭redis redis-cli shutdown
杀死redis sudo pkill redis-server

启动rabbitmq brew services start rabbitmq
关闭rabbitmq brew services stop rabbitmq

brew tap mongodb/brew
brew install mongodb-community@4.2
brew services start mongodb-community@4.2

Kafka安装与启动
    https://www.jianshu.com/p/b7e0428ac36e
    /usr/local/Cellar/kafka/2.6.0/bin/zookeeper-server-start /usr/local/etc/kafka/zookeeper.properties 
    /usr/local/Cellar/kafka/2.6.0/bin/kafka-server-start /usr/local/etc/kafka/server.properties 
minio 文件服务器
程序运行变量
export MINIO_ACCESS_KEY=IVEPLRXL2XEELK6NTZ7A
export MINIO_SECRET_KEY=R1HL697jWdbHQOkhHM077RLOX6l+53f3ADizlvMr
nohup minio server /Users/yho/WorkFile/install/minio/data > /Users/yho/WorkFile/install/minio/logs/minio.log 2>&1 &

开启ssh服务
开启：sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
关闭：sudo launchctl unload -w /System/Library/LaunchDaemons/ssh.plist
是否启动：sudo launchctl list | grep ssh
成功结果：- 0 com.openssh.sshd

默认root不允许ssh登陆
以root身份 vi /etc/ssh/sshd_config
PermitRootLogin 的默认是 prohibit-password ，改成 yes

nslookup 域名查询命令
	nslookup baidu.com

curl 返回json格式化 
	curl https://news-at.zhihu.com/api/4/news/latest | python -m json.tool
	curl https://news-at.zhihu.com/api/4/news/latest -s | json

更改文件所有者和文件所在组
chgrp  用户名    文件名  -R
chown 用户名   文件名  -R

chmod 777 file
R:4,w:2,x:1

Finder 显示与隐藏文件
defaults write com.apple.finder AppleShowAllFiles -boolean true;killall Finder
defaults write com.apple.finder AppleShowAllFiles -boolean false;killall Finder

Finder 显示路径与文件夹名
显示路径：defaults write com.apple.finder _FXShowPosixPathInTitle -bool TRUE;killall Finder
还原：defaults delete com.apple.finder _FXShowPosixPathInTitle;killall Finder

idea. 激活码 
wlyxtx@163.com
rezvoq-kivnY9-vuqcif

jar启动 
https://www.cnblogs.com/guduershi/p/12144565.html
https://blog.csdn.net/qq_40680190/article/details/103755476
nohup java -jar xxx.jar > xxx.log &


sshpass -p pass ssh -p 22 root@127.0.0.1
-f  读取文件密码
-p 明文密码


export SSHPASS='1340'
sshpass -e ssh -p 22 root@127.0.0.1

python 通过pip安装第三方库
pip install xlwt --user


.k780(最为详细)
http://api.k780.com:88/?app=phone.get&phone=17560308198&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4
身份证
http://api.k780.com:88/?app=idcard.get&idcard=511423199003240017&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json

配置https
https://www.jianshu.com/p/092049445f15

Mac微信备份目录
/Users/yho/Library/Containers/com.tencent.xinWeChat/Data/Library/Application Support/com.tencent.xinWeChat/2.0b4.0.9/Backup/b89c46364c217c6af883a44345b12387/863535045601334

xcode开发工具(使用最新版本用以兼容最新版本的brew)
sudo rm -rf /Library/Developer/CommandLineTools
sudo xcode-select --install
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer/
xcodebuild -version