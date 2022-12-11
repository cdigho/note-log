# @Transactional

## 事务特性

- 原子性(Atomicity)：

  事务是数据库的逻辑工作单位，它对数据库的修改要么全部执行，要么全部不执行。

- 一致性(Consistemcy)：

  事务前后，数据库的状态都满足所有的完整性约束。

- 隔离性(Isolation)：

  ​		并发执行的事务是隔离的，一个不影响一个。如果有两个事务，运行在相同的时间内，执行相同的功能，事务的隔离性将确保每一事务在系统中认为只有该事务在使用系统。这种属性有时称为串行化，为了防止事务操作间的混淆，必须串行化或序列化请求，使得在同一时间仅有一个请求用于同一数据。通过设置数据库的隔离级别，可以达到不同的隔离效果。

- 持久性(Durability)：

  在事务完成以后，该事务所对数据库所作的更改便持久的保存在数据库之中，并不会被回滚。



## 事务问题

- 脏读

  当一个事务读取另一个事务尚未提交的修改数据时，产生脏读。

- 不可重复读

  同一查询在同一事务中多次进行，由于其他提交事务所做的修改(update)或删除(delete)，每次返回不同的结果集，此时发生不可重复读。

- 幻读

  同一查询在同一事务中多次进行，由于其他提交事务所做的插入(insert)操作，每次返回不同的结果集，此时发生幻读。


## 传播机制

在声明式事务中通过配置@Transactional主键实现事务，内参数可以配置传播机制

例如：    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)

| 传播机制                  | 说明                                                         |
| ------------------------- | ------------------------------------------------------------ |
| Propagation.REQUIRED      | 支持当前事务，如果当前没有事务，则新建一个事务。             |
| Propagation.SUPPORTS      | 支持当前事务，如果当前没有事务，就以非事务方式执行。         |
| Propagation.MANDATORY     | 支持当前事务，如果当前没有事务，就抛出异常。                 |
| Propagation.REQUIRES_NEW  | 新建事务，如果当前存在事务，把当前事务挂起。                 |
| Propagation.NOT_SUPPORTED | 以非事务方式执行操作，如果当前存在事务，就把当前事务挂起。   |
| Propagation.NEVER         | 以非事务方式执行，如果当前存在事务，则抛出异常。             |
| Propagation.NESTED        | 支持当前事务，如果当前事务存在，则执行一个嵌套事务，如果当前没有事务，就新建一个事务。 |

## 隔离级别

在声明式事务中通过配置@Transactional主键实现事务，内参数可以配置隔离级别

例如：    @Transactional(isolation = Isolation.DEFAULT, rollbackFor = Exception.class)

| 隔离级别                   | 名称     | 说明                                                         |
| -------------------------- | -------- | ------------------------------------------------------------ |
| Isolation.DEFAULT          | 默认     | DEFAULT为数据源（数据库）的默认隔离级别，以目前常用的MySQL为例，默认的隔离级别通常为REPEATABLE_READ。 |
| Isolation.READ_UNCOMMITTED | 读未提交 | 一个事务可以读取另一个未提交事务的数据，可能出现脏读、不可重复读、幻读。 |
| Isolation.READ_COMMITTED   | 读提交   | 此刻读取到的数据，在未提交之前可能受其它事务影响(update/delete)二次读取到的结果不一致。可以解决脏读问题，但不能解决不可重复读问题和幻读问题。 |
| Isolation.REPEATABLE_READ  | 可重复读 | 一个事务要等待另一个事务更新提交后才能读取数据。重复读可以解决不可重复读问题。但是可能还会有幻读问题。幻读问题对应的是插入insert操作。 |
| Isolation.SERIALIZABLE     | 串行化   | 所有事务按顺序执行                                           |

## 事务失效

```
参考文档 https://mp.weixin.qq.com/s/r388pF8-c6sPVyVGjLBjqg
```



![image-20221016173901140](assets/image-20221016173901140.png)

## 事务提交后执行

```java
package org.yho.mybatis.utils;


import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionSynchronizationAdapter;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.transaction.support.TransactionTemplate;

import java.util.function.Supplier;

/**
 * 事务处理器
 * created date 2021/11/11 9:50
 *
 * @author JiangYuhao
 */
@Slf4j
public class TransactionHolder<T> {

    /**
     * 执行事务安全的代码
     *
     * @param supplier
     * @return
     */
    public static <T> T executeTransactionTemplate(Supplier<T> supplier) {
        TransactionTemplate transactionTemplate = SpringContextHolder.getBean(TransactionTemplate.class);
        return transactionTemplate.execute((status -> {
            try {
                return supplier.get();
            } catch (Exception e) {
                status.setRollbackOnly();
                throw e;
            }
        }));
    }

    public static <T> T executeTransactionTemplate(Supplier<T> supplier, Runnable callback) {
        TransactionTemplate transactionTemplate = SpringContextHolder.getBean(TransactionTemplate.class);
        return transactionTemplate.execute((status -> {
            try {
                commitCallbackNotify(callback);
                return supplier.get();
            } catch (Exception e) {
                status.setRollbackOnly();
                throw e;
            }
        }));
    }

    /**
     * 执行事务安全的代码
     *
     * @param supplier
     * @return
     */
    public static <T> T execute(Supplier<T> supplier) {
        DataSourceTransactionManager dataSourceTransactionManager = SpringContextHolder.getBean(DataSourceTransactionManager.class);
        TransactionStatus transactionStatus = dataSourceTransactionManager.getTransaction(new DefaultTransactionDefinition());
        try {
            T t = supplier.get();
            dataSourceTransactionManager.commit(transactionStatus);
            return t;
        } catch (Exception e) {
            dataSourceTransactionManager.rollback(transactionStatus);
            throw e;
        }
    }

    public static <T> T execute(Supplier<T> supplier, Runnable callback) {
        DataSourceTransactionManager dataSourceTransactionManager = SpringContextHolder.getBean(DataSourceTransactionManager.class);
        TransactionStatus transactionStatus = dataSourceTransactionManager.getTransaction(new DefaultTransactionDefinition());
        try {
            commitCallbackNotify(callback);
            T t = supplier.get();
            dataSourceTransactionManager.commit(transactionStatus);
            return t;
        } catch (Exception e) {
            dataSourceTransactionManager.rollback(transactionStatus);
            throw e;
        }
    }

    static void commitCallbackNotify(Runnable callback) {
        if (TransactionSynchronizationManager.isActualTransactionActive()) {
            /**
             * https://www.cnblogs.com/kkkfff/p/13778692.html
             * 还可以使用event发布订阅方式
             */
            TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronizationAdapter() {
                @Override
                public void afterCommit() {
                    try {
                        //回调
                        callback.run();
                        //回调
                    } catch (Exception e) {
                        log.error("事务提交后回调失败", e);
                    }
                }
            });
        }
    }
}

```

# 可执行文件

- GraalVM
- springboot3.0
- [参考文档](https://blog.csdn.net/weixin_60223449/article/details/128120918)
- 配置插件
- [示例代码](https://gitee.com/deveho/springboot-graalvm.git)

```xml
    <build>
        <plugins>
            <plugin>
                <groupId>org.graalvm.buildtools</groupId>
                <artifactId>native-maven-plugin</artifactId>
                <extensions>true</extensions>
                <executions>
                    <execution>
                        <id>build-native</id>
                        <goals>
                            <goal>compile-no-fork</goal>
                        </goals>
                        <phase>package</phase>
                    </execution>
                    <execution>
                        <id>test-native</id>
                        <goals>
                            <goal>test</goal>
                        </goals>
                        <phase>test</phase>
                    </execution>
                </executions>
                <configuration>
                    <!-- 此处是入口类,必须与实际代码一致,否则无法打包成功-->
                    <mainClass>org.yho.graalvm.GraalVMApplication</mainClass>
                    <!--  生成的可执行文件名-->
                    <imageName>run</imageName>
                    <buildArgs>
                        <buildArg>--verbose</buildArg>
                    </buildArgs>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <excludes>
                        <exclude>
                            <groupId>org.projectlombok</groupId>
                            <artifactId>lombok</artifactId>
                        </exclude>
                    </excludes>
                </configuration>
            </plugin>
        </plugins>
    </build>
```

 - 执行打包命令

   - 可通过idea中maven插件执行

   - 直接通过命令

   - 运行可执行文件即可启动程序

     ```java
      mvn -Pnative -DskipTests clean package
      ./target/run
     ```

     

     ![image-20221211194248300](assets/image-20221211194248300.png)

