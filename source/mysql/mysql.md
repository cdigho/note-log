# 锁表查询

```
-- 查看所有进程 
show processlist;
-- 查看所有进程的更多信息 
show full processlist;
-- 杀掉指定mysql连接的进程号
kill 18;
-- 查看正在进行中的事务
SELECT * FROM information_schema.INNODB_TRX
-- 查看正在锁的事务
SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCKS; 
-- 查看等待锁的事务
SELECT * FROM INFORMATION_SCHEMA.INNODB_LOCK_WAITS; 
-- 查询是否锁表
show OPEN TABLES where In_use > 0;
-- 查看最近死锁的日志
show engine innodb status
-- 查看服务器状态
show status like '%lock%';
-- 查看超时时间：
show variables like '%timeout%';
```



# like效率

- 问题

  当使用%searchName前置百分号的时候，因为索引排序的原因匹配前置内容将导致索引失效，效率低下

- 解决方案

  例如name等较短字符的可以使用全文索引可以利用MySQL自身解决，当是一些大文章字段需要配合es等文章检索工具

- 没有银弹
  
  经过实验尝试，数据量2000万，一些数据量较大的关键词效率和like相当，即在大数据量下索引量的臃肿，依然效率低下。
  
  ```
  1.需要检索中文，就需要做分词处理在创建索引时需要加入WITH PARSER `ngram`关键词
  ALTER TABLE `test`.`user_temp` ADD FULLTEXT INDEX `name_fulltext_index`(`name`) WITH PARSER `ngram`;
  2.检索单个汉字需要调整分词关键词大小，可以使用以下语法查询当前配置
  SHOW GLOBAL VARIABLES LIKE '%ft_m%';
  SHOW GLOBAL VARIABLES LIKE '%ngram_token_size%';
  3.修改分词大小,只支持从配置文件中修改,修改完成需要重启MySQL，并且重建索引
  当使用ngram分词解析器时，innodb_ft_min_token_size和innodb_ft_max_token_size 无效
  #最短的索引字符串
  ft_min_word_len=1
  #表示最小1个字符作为一个关键词，增大该值可减少全文索引的大小
  innodb_ft_min_token_size=1
  #表示1个字符作为内置分词解析器的一个关键词,当使用ngram分词解析器时需要修改配置
  ngram_token_size=1
  4.重启与重建索引
  ALTER TABLE `test`.`user_temp` DROP INDEX `name_fulltext_index`;
  ALTER TABLE `test`.`user_temp` ADD FULLTEXT INDEX `name_fulltext_index`(`name`) WITH PARSER `ngram`;
  5.查询使用
  #布尔模式  IN BOOLEAN MODE 搜索中，搜索项被转换成ngram短语搜索，只会搜索出包含“江”的记录
  SELECT*FROM `test`.user_temp WHERE MATCH (`name`) AGAINST ('江' IN BOOLEAN MODE); 
  #自然语言模式 IN natural language MODE 搜索项被转换为ngram值的并集，会拆分成 “江”，“浩”，“江浩”这样进行搜索获取结果
  SELECT*FROM `test`.user_temp WHERE MATCH (`name`) AGAINST ('江浩' IN NATURAL LANGUAGE MODE);
  ```

## 实验方式

### sql

```mysql
CREATE TABLE `user_temp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name1` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  FULLTEXT KEY `name_fulltext_index` (`name1`) /*!50100 WITH PARSER `ngram` */ 
) ENGINE=InnoDB AUTO_INCREMENT=20000001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ALTER TABLE `test`.`user_temp` DROP INDEX `name_fulltext_index`;
-- ALTER TABLE `test`.`user_temp` ADD FULLTEXT INDEX `name_fulltext_index`(`name1`) WITH PARSER `ngram`;

SELECT COUNT(id) FROM user_temp ;
SELECT * FROM user_temp WHERE id<1000 AND `name1` LIKE '%江%';

#布尔模式  IN BOOLEAN MODE 搜索中，搜索项被转换成ngram短语搜索，只会搜索出包含“江”的记录
 SELECT*FROM `test`.user_temp WHERE id<1000 AND MATCH (`name1`) AGAINST ('江' IN BOOLEAN MODE); 
#自然语言模式 IN natural language MODE 搜索项被转换为ngram值的并集，会拆分成 “江”，“浩”，“江浩”这样进行搜索获取结果
SELECT*FROM `test`.user_temp WHERE MATCH (`name1`) AGAINST ('江浩' IN NATURAL LANGUAGE MODE);

SELECT LEFT(name1,1) FROM test.user_temp WHERE id=448952;


SELECT COUNT(id) FROM user_temp ;

SELECT*FROM `test`.user_temp WHERE `name1` LIKE '%王刚%'; 
SELECT*FROM `test`.user_temp WHERE MATCH (`name1`) AGAINST ('王刚' IN BOOLEAN MODE);
SELECT*FROM `test`.user_temp WHERE `name1` LIKE '%轩辕%'; 
SELECT*FROM `test`.user_temp WHERE MATCH (`name1`) AGAINST ('轩辕' IN BOOLEAN MODE);
SELECT*FROM `test`.user_temp WHERE `name1` LIKE '%辕善%'; 
SELECT*FROM `test`.user_temp WHERE MATCH (`name1`) AGAINST ('辕善' IN BOOLEAN MODE);


SELECT*FROM `test`.user_temp WHERE id< 1000 AND MATCH (`name1`) AGAINST ('公' IN BOOLEAN MODE) ORDER BY id DESC LIMIT 10;

SELECT * FROM (SELECT LEFT(name1,1) 'name',COUNT(id) 'num' FROM user_temp GROUP BY LEFT(name1,1))a ORDER BY num DESC;


show variables like '%token%';
```

### 脚本

```java
package org.yho.study.web.daily.data;

import cn.hutool.core.io.FileUtil;

import java.util.Random;

/**
 * @name: yho
 * @date 2022/12/04 15:00 周日
 * 随机大数据并保证内存不溢出，并将数据导入mysql
 * 技巧
 * 1.关闭二进制日志、 关闭事务自动提交
 * set sql_log_bin=off;
 * set autocommit=0;
 * 2.执行SQL脚本
 * source 文件.sql;
 * 3.提交
 * commit;
 * 4.改回配置
 * set sql_log_bin=on;
 * set autocommit=1;
 */
public class RandomBigData {

    static String familyName1 = "赵钱孙李周吴郑王冯陈褚卫蒋沈韩杨朱秦尤许何吕施张孔曹严华金魏陶姜戚谢邹喻水云苏潘葛奚范彭郎鲁韦昌马苗凤花方俞任袁柳鲍史唐费岑薛雷贺倪汤滕殷罗毕郝邬安常乐于时傅卞齐康伍余元卜顾孟平"
            + "黄和穆萧尹姚邵湛汪祁毛禹狄米贝明臧计成戴宋茅庞熊纪舒屈项祝董粱杜阮席季麻强贾路娄危江童颜郭梅盛林刁钟徐邱骆高夏蔡田胡凌霍万柯卢莫房缪干解应宗丁宣邓郁单杭洪包诸左石崔吉"
            + "龚程邢滑裴陆荣翁荀羊甄家封芮储靳邴松井富乌焦巴弓牧隗山谷车侯伊宁仇祖武符刘景詹束龙叶幸司韶黎乔苍双闻莘劳逄姬冉宰桂牛寿通边燕冀尚农温庄晏瞿茹习鱼容向古戈终居衡步都耿满弘国文东殴沃曾关红游盖益桓公晋楚闫";
    static String familyName2 = "欧阳太史端木上官司马东方独孤南宫万俟闻人夏侯诸葛尉迟公羊赫连澹台皇甫宗政濮阳公冶太叔申屠公孙慕容仲孙钟离长孙宇文司徒鲜于司空闾丘子车亓官司寇巫马公西颛孙壤驷公良漆雕乐正宰父谷梁拓跋夹谷轩辕令狐段干百里呼延东郭南门羊舌微生公户公玉公仪梁丘公仲公上公门公山公坚左丘公伯西门公祖第五公乘贯丘公皙南荣东里东宫仲长子书子桑即墨达奚褚师吴铭";
    static String girlName = "秀娟英华慧巧美娜静淑惠珠翠雅芝玉萍红娥玲芬芳燕彩春菊兰凤洁梅琳素云莲真环雪荣爱妹霞香月莺媛艳瑞凡佳嘉琼勤珍贞莉桂娣叶璧璐娅琦晶妍茜秋珊莎锦黛青倩婷姣婉娴瑾颖露瑶怡婵雁蓓纨仪荷丹蓉眉君琴蕊薇菁梦岚苑婕馨瑗琰韵融园艺咏卿聪澜纯毓悦昭冰爽琬茗羽希宁欣飘育滢馥筠柔竹霭凝晓欢霄枫芸菲寒伊亚宜可姬舒影荔枝思丽";
    static String boyName = "伟刚勇毅俊峰强军平保东文辉力明永健世广志义兴良海山仁波宁贵福生龙元全国胜学祥才发武新利清飞彬富顺信子杰涛昌成康星光天达安岩中茂进林有坚和彪博诚先敬震振壮会思群豪心邦承乐绍功松善厚庆磊民友裕河哲江超浩亮政谦亨奇固之轮翰朗伯宏言若鸣朋斌梁栋维启克伦翔旭鹏泽晨辰士以建家致树炎德行时泰盛雄琛钧冠策腾楠榕风航弘";

    /**
     * 功能：随机产生姓氏 * * @return
     */
    public static String getFamilyName() {

        String str = "";
        int randNum = new Random().nextInt(2) + 1;
        int strLen = randNum == 1 ? familyName1.length() : familyName2.length();
        int index = new Random().nextInt(strLen);
        if (randNum == 1) {

            str = String.valueOf(familyName1.charAt(index));
        } else {

            str = (index & 1) == 0 ? familyName2.substring(index, index + 2) :
                    familyName2.substring(index - 1, index + 1);
        }
        return str;
    }

    /**
     * 功能：随机产生性别 * * @return
     */
    public String getSex() {

        int randNum = new Random().nextInt(2) + 1;
        return randNum == 1 ? "男" : "女";
    }

    /**
     * 功能：传入性别参数，依据性别产生名字 * * @param sex * @return
     */
    public static String[] getNameAndSex(String sex) {

        String[] nameSex = new String[2];
        int randNum = new Random().nextInt(2) + 1;
        int strLen = sex.equals("男") ? boyName.length() : girlName.length();
        int index = (randNum & 1) == 0 ? new Random().nextInt(strLen - 1) :
                new Random().nextInt(strLen);
        nameSex[0] = sex.equals("男") ? boyName.substring(index, index + randNum) :
                girlName.substring(index, index + randNum);
        nameSex[1] = sex.equals("男") ? "男" : "女";
        return nameSex;
    }

    /**
     * 功能：随机产生18-21的整数 * * @return
     */
    public int getAge() {
        return new Random().nextInt(4) + 18;
    }

    //分割节点-一次输出N条SQL
    private static final Integer NODE = 10000;
    //节点数据量倍数-输出X*N条SQL
    private static final Integer MULTIPLE = 1000 * 20;
    private static int ID_INDEX = 0;

    public static int getId() {
        return ID_INDEX += 1;
    }

    public String add() {
        StringBuffer sqlList = new StringBuffer();
        while (true) {
            String[] nameSenx = getNameAndSex("男");
            String name = getFamilyName() + nameSenx[0];
            int id = getId();
            String sql = "INSERT INTO `test`.`user_temp`(`id`,`name`) VALUES (" + id + ",'" + name + "');\n";
            sqlList.append(sql);
            if (id % NODE == 0) {
                return sqlList.toString();
            }
        }
    }

    public static void main(String[] args) {
        final String path = "/Users/yho/Downloads/user_temp.sql";
        FileUtil.writeUtf8String("", path);
        for (int i = 1; i <= MULTIPLE; i++) {
            FileUtil.appendUtf8String(new RandomBigData().add(), path);
            System.out.println("已输出" + (NODE * i) + "数据");
        }
    }
}
```



# 导入SQL缓慢

```
关闭二进制日志,关闭事务自动提交
set sql_log_bin=off;
set autocommit=0;
开启事务
start transaction;
导入sql
source 文件.sql;
手动提交事务
commit;
改回配置
set sql_log_bin=on;
set autocommit=1;
```



# 生成唯一标识

```mysql
select 
REPLACE(UUID(),'-','') 'uuid',
CONCAT(DATE_FORMAT(NOW(),'%Y%m%d%H%i%s'),round(rand() * 100000, 0)) 'snowflakeId',
CONCAT('ITEM',date_format( NOW(), '%Y%m%d' ),round(rand() * 100000, 0)) 'orderNo'
FROM DUAL;
```

# 计算时间差

- datediff
  -  相差的天数 
  - DATEDIFF(date1,date2)
  - SELECT  datediff( date_add(NOW(), interval 10 DAY),NOW())
- TIMESTAMPDIFF
  -  timestampdiff（unit，begin，end）
  -  SELECT  TIMESTAMPDIFF(SECOND, NOW(), date_add(NOW(), interval 10 second))
  

| 单位 | MySQL(UNIT) | DB2(UNIT) |
| ---- | ----------- | --------- |
| 毫秒 |             | 1         |
| 秒   | second      | 2         |
| 分钟 | minute      | 4         |
| 小时 | hour        | 8         |
| 天   | day         | 16        |
| 周   | week        | 32        |
| 月   | month       | 64        |
| 季   | quarter     | 128       |
| 年   | year        | 256       |

# 时间戳

```mysql
SELECT
	unix_timestamp(now()),
	FROM_UNIXTIME( unix_timestamp( now()), '%Y-%m-%d %h:%i:%s' )
```

# 格式化时间

```mysql
SELECT 
DATE_FORMAT(NOW(),'%Y-%m-%d %h:%i:%s'),
DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s'),
DATE_FORMAT(NOW(),'%y-%m-%d %H:%i:%s')
```

# FIELD函数

```mysql
-- 需要在查询结果中根据某个字段的具体值来排序
SELECT
	order_no,
	create_time 
FROM
	`order` 
ORDER BY
	FIELD( order_no, 'JP2023020725232', 'JP2023020781747', 'JP2023020797629' ) DESC 
	LIMIT 100
```

# 聚合函数

聚合函数又叫组函数，通常是对表中的数据进行统计和计算，一般结合分组(group by)来使用，用于统计和计算分组数据。

```
常用的聚合函数:
count(col): 表示求指定列的总行数
max(col): 表示求指定列的最大值
min(col): 表示求指定列的最小值
sum(col): 表示求指定列的和
avg(col): 表示求指定列的平均值
```



# 窗口函数

[文章](http://events.jianshu.io/p/fd06605d6f48)

 窗口函数（window functions），也叫分析函数和OLAP函数，MySQL在8.0之后开始支持窗口函数。窗口函数可以用来对数据进行实时分析处理，和group by有类似之处，其区别在于窗口会对每个分组之后的数据按行进行分别操作，而group by一般对分组之后的函数使用聚合函数汇总，做不到对不同的group中的行数据进行分别操作。这就简单介绍几种常见的MySQL窗口函数。下表中列出了几种常见的窗口函数，并对其基本功能进行了描述。接下来我们会以一段示例，来展示MySQL中窗口函数的用途和效果。

| 序号 | 函数         | 描述                                   |
| ---- | ------------ | -------------------------------------- |
| 1    | ROW_NUMBER() | 当前行在其分区中的行号                 |
| 2    | RANK()       | 当前行在其分区内的序号，有间隙，不连续 |

```mysql
CREATE TABLE `players` (
	`pid` INT ( 2 ) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR ( 50 ) NOT NULL,
	`age` INT ( 2 ) NOT NULL,
	PRIMARY KEY ( `pid` ),
	UNIQUE KEY `name` ( `name` ) 
) ENGINE = INNODB DEFAULT CHARSET = latin1;
INSERT INTO `players` ( `pid`, `name`, `age` )
VALUES
	( 1, 'Samual', 25 ),
	( 2, 'Vino', 20 ),
	( 3, 'John', 20 ),
	( 4, 'Andy', 22 ),
	( 5, 'Brian', 21 ),
	( 6, 'Dew', 24 ),
	( 7, 'Kris', 25 ),
	( 8, 'William', 26 ),
	( 9, 'George', 23 ),
	( 10, 'Peter', 19 ),
	( 11, 'Tom', 20 ),
	( 12, 'Andre', 20 );
	
```

```mysql
-- RANK 相同的并列排序，将一样的数值放在了一起，也就是并列排名
SELECT NAME,age,RANK() OVER(ORDER BY age ASC) AS 'rank' FROM players; 
-- ROW_NUMBER 直接排序，将那些数值相同也按照顺序排序
SELECT NAME,age,ROW_NUMBER() OVER(ORDER BY age ASC) AS 'rank' FROM players; 
```



# 分组结果分割拼装

```mysql
GROUP_CONCAT(filed)
GROUP_CONCAT(filed SEPARATOR ';')
```

# 脱敏

```mysql
CONCAT(LEFT(idcard,3), ‘****’ ,RIGHT(idcard,4))
```

# 分页

```
limit (n-1)*m ,m
LIMIT ${(param.current-1)*param.size},${param.size}
```

# mybatis 不解析标签

```mysql
<![CDATA[
AND date_format( po.pay_time, '%Y-%m-%d' )>= #{startTime}
AND date_format( po.pay_time, '%Y-%m-%d' )<= #{endTime}
]]>
```

# update锁表与锁行

当关闭自动提交，where条件没有索引，更新一条语句，开启另一个连接更新将会锁表。

```
更新的目的是先找后更新 
更新就要保证原子性  那么保证原子性的方法就是锁
如果没有索引  先找要更新的记录    就要全表扫描  肯定锁表
如果有索引  可以直接找到记录锁行


如果有索引  也是先锁表 只不过有索引 找到那条记录很快 找到那条记录就把整张表给解锁  锁那条记录就OK了   是不是这样(有可能是直接锁表快速找到索引行，有可能直接锁行)
```



```mysql
CREATE TABLE `user`  (
  `id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

INSERT INTO `user` VALUES (1, '张三', 21);
INSERT INTO `user` VALUES (2, '李四', 23);
```



```mysql
# 连接1
SET @@autocommit=0;
SET @@autocommit=1;
SELECT @@autocommit;

UPDATE `user` SET `name`='张三' WHERE age=21;
UPDATE `user` SET `name`='张三1' WHERE id=1;

COMMIT;

# 连接2
SELECT @@autocommit;

ALTER TABLE `dev`.`user` ADD INDEX `index_age`(`age`) USING BTREE;
ALTER TABLE `dev`.`user` DROP INDEX `index_age`;

UPDATE `user` SET `name`='李四' WHERE age=23;
UPDATE `user` SET `name`='李四2' WHERE id=2;
```

# 悲观锁

高并发场景下对数据的准确行有很高的要求，可以使用for update

for update 仅适用于InnoDB，并且必须开启事务，在begin与commit之间才生效。

InnoDB默认是行级别的锁，当有明确指定的主键时候，是行级锁。否则是表级别。

```MySQL
-- 在Navicat开启两个窗口测试，后执行的将会等待第一个提交可执行

SET @@autocommit=0;
SELECT @@autocommit;

SELECT * FROM commodity WHERE id=1 FOR UPDATE;
UPDATE commodity SET `count`=`count`-1 WHERE id=1;

COMMIT;
```

# 乐观锁

[参考](https://blog.csdn.net/weixin_45433031/article/details/120838045)

更新前查询version字段，更新时候通过比较version字段是否相等进行更新

- version字段
- CAS 比较并交换
- 适用于读场景多竞争条件不激烈的场景，当写操作非常频繁时，更新失败的几率就越大，上层逻辑进行重试的次数也会增多，从而降低了系统的性能。

```
update task set value = newValue,version = version+1 where version = loadVersion;
```