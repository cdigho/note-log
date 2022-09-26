# 生成唯一标识

```mysql
select 
REPLACE(UUID(),'-','') 'uuid',
CONCAT(DATE_FORMAT(NOW(),'%Y%m%d%H%i%s'),round(rand() * 100000, 0)) 'snowflakeId',
CONCAT('ITEM',date_format( NOW(), '%Y%m%d' ),round(rand() * 100000, 0)) 'orderNo'
FROM DUAL;
```

