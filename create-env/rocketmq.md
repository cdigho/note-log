# 编译



```
该版本通过修改rocketmq开源版本源码实现了自定义消息延迟级别
通过修改conf/broker.conf的messageDelayLevel的配置实现自定义参数消息延迟级别
#messageDelayLevel自定义参数消息延迟级别
messageDelayLevel=1s 5s 10s 30s 1m 2m 3m 4m 5m 6m 7m 8m 9m 10m 20m 30m 1h 2h 7s
```



## 打包

```
git clone https://gitee.com/wlyxtx/rocketmq.git
git checkout -b yho-release-4.7.1 origin/yho-release-4.7.1
mvn -Prelease-all -DskipTests clean install -U
cp -r distribution/target/rocketmq-4.7.1 /data/work/
cd /data/work/rocketmq-4.7.1/bin

git clone https://gitee.com/wlyxtx/rocketmq-console.git
mvn clean package -Dmaven.test.skip=true
cp target/rocketmq-console-ng-1.0.0.jar /data/work/rocketmq-4.7.1/lib
```



## 启动脚本

```
vim start.sh

# 启动Name Server
# 启动Broker
#启动控制台
cd /data/work/rocketmq-4.7.1/bin
nohup sh mqnamesrv  >/dev/null 2>&1 &
nohup sh mqbroker -c /data/work/rocketmq-4.7.1/conf/broker.conf -n localhost:9876  >/dev/null 2>&1 &
nohup java -jar /data/work/rocketmq-4.7.1/lib/rocketmq-console-ng-1.0.0.jar  >/dev/null 2>&1 & 
```



## 停止脚本

```
vim shutdown.sh

ps aux|grep rocket | awk '{print $2}' | xargs kill -9
```



# docker

## rmqnamesrv

```
docker run -d \
--name rmqnamesrv \
-p 9876:9876 \
-v /Users/yho/working/install/rocketmq/namesrv/logs:/root/logs \
-v /Users/yho/working/install/rocketmq/namesrv/store:/root/store \
rocketmqinc/rocketmq \
sh mqnamesrv 

vim /Users/yho/working/install/rocketmq/conf/broker.conf

# 所属集群名称，如果节点较多可以配置多个

brokerClusterName = DefaultCluster
#broker名称，master和slave使用相同的名称，表明他们的主从关系
brokerName = broker-a
#0表示Master，大于0表示不同的slave
brokerId = 0
#表示几点做消息删除动作，默认是凌晨4点
deleteWhen = 04
#在磁盘上保留消息的时长，单位是小时
fileReservedTime = 48
#有三个值：SYNC_MASTER，ASYNC_MASTER，SLAVE；同步和异步表示Master和Slave之间同步数据的机制；
brokerRole = ASYNC_MASTER
#刷盘策略，取值为：ASYNC_FLUSH，SYNC_FLUSH表示同步刷盘和异步刷盘；SYNC_FLUSH消息写入磁盘后才返回成功状态，ASYNC_FLUSH不需要；
flushDiskType = ASYNC_FLUSH

# 设置broker节点所在服务器的外网ip地址

brokerIP1 = 127.0.0.1	
```



## rmqbroker

```
docker run -d  \
--name rmqbroker \
--link rmqnamesrv:namesrv \
-p 10911:10911 \
-p 10909:10909 \
-v  /Users/yho/working/install/rocketmq/broker/logs:/root/logs \
-v  /Users/yho/working/install/rocketmq/broker/store:/root/store \
-v /Users/yho/working/install/rocketmq/conf/broker.conf:/opt/rocketmq-4.4.0/conf/broker.conf \
-e "NAMESRV_ADDR=namesrv:9876" \
rocketmqinc/rocketmq \
sh mqbroker -c /opt/rocketmq-4.4.0/conf/broker.conf 
```

## rocketmq-console

```
docker run -d \
--name rmqadmin \
-e "JAVA_OPTS=-Drocketmq.namesrv.addr=172.17.0.7:9876  \
 -Dcom.rocketmq.sendMessageWithVIPChannel=false \
-Duser.timezone='Asia/Shanghai \
-DautoCreateTopicEnable=true \
-Dcom.rocketmq.sendMessageWithVIPChannel=false" \
-p 18080:8080 \
-v /etc/localtime:/etc/localtime \
pangliang/rocketmq-console-ng
```



