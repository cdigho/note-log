date:2022-06-15

[TOC]



# ID生成器服务-单机版

> 该服务职能：根据type返回单调递增的id



## 实现简介

ID生成器服务维护了16384个slot，每个slot取出的id是单调递增的，按照type mod 16384进行路由，保证了相同type的请求始终使用同一个slot生成id。



![](http://192.168.6.101:4999/server/index.php?s=/api/attachment/visitFile&sign=a6a04360bb8d7c5c21c8b812093b1424)




## 提供接口

```java
include "aphead.thrift"
include "vrv.thrift"
namespace java com.vrv.im.service
namespace cpp com.vrv.im.service

exception IdGeneratorException{
	/**
	 *1:不支持的type 
	 *2:没有合法id提供
	 *3:size超过最大限制
	 */
    1: optional i32 code;
    2: optional string msg;
}

/**
 * ID生成器服务
 */
service IdGeneratorService extends vrv.VRVService {
	
	/**
	 * 根据type获取id
	 * 参数：
	 * 		type 类型
	 *			-1：获取appId
	 *			-2：获取userId
	 *			-3：获取groupId
	 *			>0：获取单调递增的id
	 * 返回：
	 *		相同的type返回的id是单调递增的
	 */
	i64 getId(1:i64 type) throws (1:IdGeneratorException idGeneratorException);
	
	/**
	 * 根据type批量获取id（获取个数为size）
	 * 参数：
	 * 		type 类型
	 *			-1：获取appId
	 *			-2：获取userId
	 *			-3：获取groupId
	 *			>0：获取单调递增的id
	 *		size 个数
	 * 返回：
	 *		相同的type返回的id是单调递增的，这里会返回一个id从小到大的有序集合。
	 */
	list<i64> listIds(1:i64 type, 2:i32 size) throws (1:IdGeneratorException idGeneratorException);
}
```



## type

由于应用/用户/群组的id，是根据特定算法（entId移位）算出来的，取值范围是一个区间，比较特殊，所以需要约定几个type用于处理这几个id的生成。

| type          | 注释                           |
| ------------- | ------------------------------ |
| -1            | 应用id：appId                  |
| -2            | 用户id：userId                 |
| -3            | 群组id：groupId                |
| other(正整数) | 同一个type产生的id是单调递增的 |



## 老数据迁移

### 现存表结构

#### IM_TIMESTAMP_IDTYPE（id%5）

```sql
CREATE TABLE `IM_TIMESTAMP_IDTYPE_0` (
	`ID` BIGINT(20) NOT NULL,
	`type` BIGINT(20) NOT NULL COMMENT '1: 个人基本信息, 2: 个人设置信息, 3: 个人验证请求信息, 4: 个人验响应信息, 5: 好友组信息, 6: 群列表信息, 7: 好友推荐, 8: 群邀请信息, 9: 群验证信息, 10: 群响应信息, 12:企业列表时间戳, 13：企业时间戳(企业应用)',
	`timestamp` BIGINT(20) NOT NULL,
	PRIMARY KEY (`ID`, `type`) USING BTREE
)
COLLATE='utf8_bin'
ENGINE=InnoDB
;
```

#### IM_TIMESTAMP_PAGE（id%5）

```sql
CREATE TABLE `IM_TIMESTAMP_PAGE_0` (
	`ID` BIGINT(20) NOT NULL,
	`type` BIGINT(20) NOT NULL COMMENT '1:好友页码,2:表情页码',
	`subid` BIGINT(20) NOT NULL,
	`timestamp` BIGINT(20) NOT NULL,
	PRIMARY KEY (`ID`, `type`, `subid`) USING BTREE
)
COLLATE='utf8_bin'
ENGINE=InnoDB
;
```

#### IM_TIMESTAMP_TYPE（单表）

```sql
CREATE TABLE `IM_TIMESTAMP_TYPE` (
	`type` BIGINT(20) NOT NULL COMMENT '1:公告,2:新闻 等',
	`timestamp` BIGINT(20) NOT NULL,
	PRIMARY KEY (`type`) USING BTREE
)
COLLATE='utf8_bin'
ENGINE=InnoDB
;
```



### 新建表结构

#### IM_ID_SLOT（单表）

| 字段        | 类型       | 注释                 |
| ----------- | ---------- | -------------------- |
| slot_id     | BIGINT(20) | 槽位                 |
| max_id      | BIGINT(20) | 此槽位当前可用最大id |
| create_time | BIGINT(20) | 创建时间             |
| update_time | BIGINT(20) | 更新时间             |



#### 建表语句

```sql
CREATE TABLE `IM_ID_SLOT` (
	`slot_id` BIGINT(20) NOT NULL COMMENT '槽位',
	`max_id` BIGINT(20) NOT NULL COMMENT '此槽位当前可用最大id',
	`create_time` BIGINT(20) NOT NULL COMMENT '创建时间',
	`update_time` BIGINT(20) NOT NULL COMMENT '更新时间',
	PRIMARY KEY (`slot_id`) USING BTREE
)
COMMENT='ID生成器表'
COLLATE='utf8_bin'
ENGINE=InnoDB
;
```



#### 数据源配置

```sql
INSERT INTO `IM_DBCONFIG_APPTABLE` (`appTableID`, `appServerID`, `appServerVersion`, `tableName`, `tableShardType`) VALUES (1893, 'idGeneratorServer', '1.0', 'IM_ID_SLOT', '%1');
INSERT INTO `IM_DBCONFIG_TABLEDS` (`tableDSID`, `appTableID`, `tableSegName`, `dataSourceID`) VALUES (1807, 1893, 'IM_ID_SLOT', 'IM_TIMESTAMP');
```



### 如何迁移

1. 特定类型的时间戳（应用/用户/群组的id）如何处理？

   这三种类型的时间戳，存储在IM_TIMESTAMP_TYPE表中，示例数据如下：

| type | timestamp | 注释            |
| ---- | --------- | --------------- |
| 218  | 1000      | 应用id：appId   |
| 228  | 2000      | 用户id：userId  |
| 203  | 3000      | 群组id：groupId |

答：对于这些特定类型的时间戳是需要保留下来。

存为下面这样：

| slot_id | max_id | create_time | update_time | 注释            |
| ------- | ------ | ----------- | ----------- | --------------- |
| -1      | 1000   | 当前时间    | 当前时间    | 应用id：appId   |
| -2      | 2000   | 当前时间    | 当前时间    | 用户id：userId  |
| -3      | 3000   | 当前时间    | 当前时间    | 群组id：groupId |



2. 其他类型的时间戳，如何处理？

答：其他类型的时间戳， 统一刷成三张表中最大的那个时间戳（排除特性类型时间戳），这样能保证不管什么类型的type过来，都会返回比之前大的时间戳。

存为下面这样：

| slot_id | max_id       | create_time | update_time |
| ------- | ------------ | ----------- | ----------- |
| 0       | maxTimestamp | 当前时间    | 当前时间    |
| 1       | maxTimestamp | 当前时间    | 当前时间    |
| 2       | maxTimestamp | 当前时间    | 当前时间    |
| ...     | maxTimestamp | 当前时间    | 当前时间    |
| 16383   | maxTimestamp | 当前时间    | 当前时间    |

附相关sql：

IM_TIMESTAMP_IDTYPE 表中最大 timestamp

```sql
SELECT MAX(timestamp) FROM
(SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_IDTYPE_0 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_IDTYPE_1 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_IDTYPE_2 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_IDTYPE_3 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_IDTYPE_4) AS IM_TIMESTAMP_IDTYPE;
```

IM_TIMESTAMP_PAGE 表中最大 timestamp

```sql
SELECT MAX(timestamp) FROM
(SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_PAGE_0 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_PAGE_1 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_PAGE_2 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_PAGE_3 UNION
SELECT MAX(TIMESTAMP) AS timestamp FROM IM_TIMESTAMP.IM_TIMESTAMP_PAGE_4) AS IM_TIMESTAMP_PAGE;
```

IM_TIMESTAMP_TYPE

```sql
SELECT MAX(timestamp) FROM IM_TIMESTAMP.IM_TIMESTAMP_TYPE WHERE type <> 218 AND type <> 228 AND type <> 203;
SELECT * FROM IM_TIMESTAMP.IM_TIMESTAMP_TYPE WHERE TYPE = 218 or TYPE = 228 or TYPE = 203;
```



## 新装环境初始化

新装环境不用初始化IM_ID_SLOT表数据，ID生成器服务会完成初始化。（普通槽位起始值：10万）



## 何时刷新本地槽（slot）

1. 启动（暂时不预热）
2. 接口调用（发现没有可用/使用达到阈值）

![](http://192.168.6.101:4999/server/index.php?s=/api/attachment/visitFile&sign=33e208890c23e685f73282e3d7a54381)



## 如何刷新本地槽（slot）

![](http://192.168.6.101:4999/server/index.php?s=/api/attachment/visitFile&sign=0bd4de8e2f169c5d06d923369686a4f9)





# ID生成器服务-集群版

> 该服务职能：根据type返回单调递增的id



## 单机版存在哪些单点问题

### 1. 槽位维护在节点本地

#### 分析过程

1. ID生成器服务内部维护的是一个一个**本地槽位**。

槽位结构，如下：

```java
/**
 * 槽 (curId,maxId]
 * 
 * @author chenlong
 * @date 2022-04-19 19:52:28
 */
@Data
public class Slot {

	/**
	 * 槽位编号
	 */
	private int slotId;

	/**
	 * 当前已发出去的最大id
	 */
	private AtomicLong curId;

	/**
	 * 可产生的最大id
	 */
	private AtomicLong maxId;

}
```



2. 槽位如何产生一个id？

核心逻辑如下：

```java
if (slot.getMaxId().get() > slot.getCurId().get()) {// maxId > curId
	long id = slot.getCurId().incrementAndGet();// id = curId+1
    return id;
}
```



3. 集群后为什么有问题？

答：如果集群部署的话，由于槽位是本地数据，无法共享，各自在自己本地做+1操作，所以就会出现产生错误id的情况，比如：不同的节点，产生了相同的id。



4. 那么如何解决这个问题呢？

答：将本地槽数据共享，这里我们采用redis，来做数据共享。



5. 将槽位的哪些属性存进redis，也就是需要将槽位的哪些数据共享出去？

答：Slot.curId，这样槽位在需要生成一个id的时候，直接redis里面+1就可以了，由于redis数据是共享的且+1操作是线程安全的，所以不会产生重复的id。



6. redis结构是什么样？

| KEY                 | VALUE   |
| ------------------- | ------- |
| slot:{slotId}:curid | {curId} |



## 何时刷新槽位（slot）

1. 启动（暂时不预热）
2. 接口调用（id <= initValue || 新curId/step > 老curId/step）

![](http://192.168.6.101:4999/server/index.php?s=/api/attachment/visitFile&sign=9639fe6c3a44eba160946374be5ec1e9)



## 如何刷新槽位（slot）

刷新槽位简易流程图：

![](http://192.168.6.101:4999/server/index.php?s=/api/attachment/visitFile&sign=a75f705e538035660d16da54830f0e2a)



## 脚本

### 老环境升级

升级集群版时，一定会刷到单机版的数据迁移脚本，本次集群版没有新增的脚本。

### 新装环境

新装环境不用初始化IM_ID_SLOT表数据，ID生成器服务会完成初始化。（普通槽位起始值100万）



# 时间戳存储服务

1. 本服务自己不产生id，id全部由调用ID生成器服务获取。

2. 类似分页时间戳这种，需要进行查询操作的，由时间戳存储服务获取完id以后，在本服务完成存储，ID生成器服务是不提供类似查询的。

# 性能测试（ant）

## 机器配置（4核 32G）

| 发压机:192.168.6.81 | 服务:192.168.6.81                |
| ------------------- | -------------------------------- |
|                     | 内存：32G                        |
|                     | CPU：4核                         |
|                     | server-idgenerator配置内存：128M |

### getId(1)

#### 单机版

```shell
# 400携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 400 -d 30 -r idgenerator-getId 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  400 goroutine(s) running concurrently
656659 requests in 30.00sec
         success:656659
         failed:0
Requests/sec(TPS):      21888.63
Avg Req Time:           18.28ms
Fastest Request:        0.23ms
Slowest Request:        3064.67ms

TP50:   15.67ms
TP90:   32.06ms
TP99:   53.94ms

# 500携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 500 -d 30 -r idgenerator-getId 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  500 goroutine(s) running concurrently
702670 requests in 30.00sec
         success:702670
         failed:0
Requests/sec(TPS):      23422.33
Avg Req Time:           21.34ms
Fastest Request:        0.23ms
Slowest Request:        7046.01ms

TP50:   18.60ms
TP90:   36.66ms
TP99:   60.60ms
```



#### 集群版

```shell
# 200携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 200 -d 30 -r idgenerator-getId 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  200 goroutine(s) running concurrently
317997 requests in 30.00sec
         success:317996
         failed:1
Requests/sec(TPS):      10599.90
Avg Req Time:           18.87ms
Fastest Request:        0.85ms
Slowest Request:        3026.71ms

TP50:   17.69ms
TP90:   25.82ms
TP99:   38.79ms

# 300携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 300 -d 30 -r idgenerator-getId 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  300 goroutine(s) running concurrently
320966 requests in 30.00sec
         success:320966
         failed:0
Requests/sec(TPS):      10698.87
Avg Req Time:           28.04ms
Fastest Request:        0.52ms
Slowest Request:        7048.16ms

TP50:   26.38ms
TP90:   36.32ms
TP99:   51.77ms
```



### listIds(1,100)

#### 单机版

```shell
# 400携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 400 -d 30 -r idgenerator-listIds 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  400 goroutine(s) running concurrently
364672 requests in 30.00sec
         success:364672
         failed:0
Requests/sec(TPS):      12155.73
Avg Req Time:           32.89ms
Fastest Request:        0.24ms
Slowest Request:        3113.49ms

TP50:   27.92ms
TP90:   55.94ms
TP99:   114.57ms

# 500携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 500 -d 30 -r idgenerator-listIds 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  500 goroutine(s) running concurrently
365008 requests in 30.00sec
         success:365008
         failed:0
Requests/sec(TPS):      12166.93
Avg Req Time:           41.09ms
Fastest Request:        0.25ms
Slowest Request:        7090.00ms

TP50:   34.70ms
TP90:   66.91ms
TP99:   148.52ms
```

#### 集群版

```shell
# 900携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 900 -d 30 -r idgenerator-listIds 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  900 goroutine(s) running concurrently
255780 requests in 30.00sec
         success:255780
         failed:0
Requests/sec(TPS):      8526.00
Avg Req Time:           105.58ms
Fastest Request:        1.33ms
Slowest Request:        4174.17ms

TP50:   102.65ms
TP90:   122.98ms
TP99:   149.49ms

# 1000携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 1000 -d 30 -r idgenerator-listIds 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  1000 goroutine(s) running concurrently
255615 requests in 30.00sec
         success:255510
         failed:105
Requests/sec(TPS):      8520.50
Avg Req Time:           117.49ms
Fastest Request:        3.88ms
Slowest Request:        7147.91ms

TP50:   111.91ms
TP90:   136.03ms
TP99:   185.63ms
```



### redis+1

```shell
# 300携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 300 -d 30 -r idgenerator-getId 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  300 goroutine(s) running concurrently
317623 requests in 30.00sec
         success:317623
         failed:0
Requests/sec(TPS):      10587.43
Avg Req Time:           28.34ms
Fastest Request:        1.23ms
Slowest Request:        3049.65ms

TP50:   27.24ms
TP90:   36.54ms
TP99:   48.65ms

# 500携程 执行 30 秒
[linkdood@localhost jmh]$ ./ant -c 500 -d 30 -r idgenerator-getId 192.168.6.81:11251
Running 30s of  test @ 192.168.6.81:11251
  500 goroutine(s) running concurrently
316899 requests in 30.00sec
         success:316899
         failed:0
Requests/sec(TPS):      10563.30
Avg Req Time:           47.34ms
Fastest Request:        7.35ms
Slowest Request:        3091.33ms

TP50:   45.51ms
TP90:   57.17ms
TP99:   76.99ms
```



### 测试结果

| getId(1)          | listIds(1,100)    | redis+1   |
| ----------------- | ----------------- | --------- |
| 单机版：21888 tps | 单机版：12155 tps | 10563 tps |
| 集群版：10599 tps | 集群版：8526 tps  |           |



## 机器配置（48核 128G）

| 发压机:192.168.6.142 | 服务:192.168.6.190             |
| -------------------- | ------------------------------ |
|                      | 内存：128G                     |
|                      | CPU：48核                      |
|                      | server-idgenerator配置内存：1G |



### getId(携程号)

#### 集群版

```shell
# 500携程 执行 30 秒
[linkdood@localhost ant-chenlong]$ ./ant -c 500 -d 30 -r idgenerator-getId 192.168.6.190:11251
Running 30s of  test @ 192.168.6.190:11251
  500 goroutine(s) running concurrently
3168693 requests in 30.00sec
         success:3168693
         failed:0
Requests/sec(TPS):      105623.10
Avg Req Time:           4.73ms
Fastest Request:        0.56ms
Slowest Request:        1024.31ms

TP50:   4.58ms
TP90:   5.11ms
TP99:   8.34ms
```



### listIds(携程号,100)

#### 集群版

```shell
# 500携程 执行 30 秒
[linkdood@localhost ant-chenlong]$ ./ant -c 500 -d 30 -r idgenerator-listIds 192.168.6.190:11251
Running 30s of  test @ 192.168.6.190:11251
  500 goroutine(s) running concurrently
2928423 requests in 30.00sec
         success:2928423
         failed:0
Requests/sec(TPS):      97614.10
Avg Req Time:           5.12ms
Fastest Request:        0.72ms
Slowest Request:        1027.99ms

TP50:   4.75ms
TP90:   5.35ms
TP99:   16.03ms
```



### 测试结果

| getId(携程号)      | listIds(携程号,100) |
| ------------------ | ------------------- |
| 集群版：105623 tps | 集群版：97614 tps   |

