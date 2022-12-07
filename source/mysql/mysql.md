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

