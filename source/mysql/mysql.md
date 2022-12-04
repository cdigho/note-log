# like效率

- 问题

  当使用%searchName前置百分号的时候，因为索引排序的原因匹配前置内容将导致索引失效，效率低下

- 解决方案

  例如name等较短字符的可以使用全文索引可以利用MySQL自身解决，当是一些大文章字段需要配合es等文章检索工具

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

# 格式化时间戳

```mysql
SELECT UNIX_TIMESTAMP(NOW())
```

# 格式化时间

```mysql
SELECT 
DATE_FORMAT(NOW(),'%Y-%m-%d %h:%i:%s'),
DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s'),
DATE_FORMAT(NOW(),'%y-%m-%d %H:%i:%s')
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

