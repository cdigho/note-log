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

