# @Transactional

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

