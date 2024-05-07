# 计算方式

```java
    public int hashCode() {
        int h = hash;
        if (h == 0 && value.length > 0) {
            char val[] = value;

            for (int i = 0; i < value.length; i++) {
                h = 31 * h + val[i];
            }
            hash = h;
        }
        return h;
    }
```

# [引用答案](https://stackoverflow.org.cn/questions/299304)

根据 Joshua Bloch 的[Effective Java](https://rads.stackoverflow.com/amzn/click/com/0321356683)（这本书推荐得不够多，由于在 stackoverflow 上的不断提及，我买了这本书）：

> 选择值 31 是因为它是一个奇数素数。如果它是偶数并且乘法溢出，则信息将丢失，因为乘以 2 相当于移位。使用素数的优势不太明显，但它是传统的。31 的一个很好的属性是乘法可以用移位和减法代替以获得更好的性能：`31 * i == (i << 5) - i`. 现代虚拟机自动进行这种优化。

*（来自第 3 章第 9 项：覆盖等于时始终覆盖哈希码，第 48 页）*


 Goodrich 和 Tamassia 从超过 50,000 个英语单词（由两个 Unix 变体中提供的单词列表的并集）计算得出，使用常量 31、33、37、39 和 41 在每种情况下将产生少于 7 个冲突。这可能是许多 Java 实现选择此类常量的原因。

[请参阅Java](https://enos.itcollege.ee/~jpoial/algorithms/GT/Data Structures and Algorithms in Java Fourth Edition.pdf)中的数据结构和算法的第 9.2 节哈希表（第 522 页）。



  根据第一个的解答虽然有一定的道理，但是是相悖的，我们可以按照他的说法改造hashcode，结果如下：

```
    public int hashCode() {
        int h = hash;
        if (h == 0 && value.length > 0) {
            char val[] = value;

            for (int i = 0; i < value.length; i++) {
                h = ((h << 5) - h) + val[i];
            }
            hash = h;
        }
        return h;
    }
```

当我们改造后发现第一种利用现代虚拟机优化的说法不靠谱，我们可以直接编写最终的形式。所以这个31更多的是一个经过数据实验的使hash分布更为均匀，从而更好的避免冲突的做法。