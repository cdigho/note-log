# 安装配置

```
1.下载
https://github.com/graalvm/graalvm-ce-builds/releases/
2.配置java_home
JAVA_HOME_GRAALVM_17=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.3.0/Contents/Home
3.source .bash_profile
4.java -version 输出GraalVM 即可
openjdk version "17.0.5" 2022-10-18
OpenJDK Runtime Environment GraalVM CE 22.3.0 (build 17.0.5+8-jvmci-22.3-b08)
OpenJDK 64-Bit Server VM GraalVM CE 22.3.0 (build 17.0.5+8-jvmci-22.3-b08, mixed mode, sharing)
```

# GraalVM Native Image

​		GraalVM Native Image是由Oracle Labs开发的一种AOT编译器，支持基于JVM的高级语言，如Java, Scala, Clojure, Kotlin。Native Image以Java bytecode作为输入，将所有应用所需的class依赖项及runtime库打包编译生成一个单独可执行文件。具有高效的startup及较小的运行时内存开销的优势。

​		与传统的Java虚拟机不同，Native Image是封闭式的静态分析和编译，不支持class的动态加载，程序运行所需要的多有依赖项均在静态分析阶段完成。此外GraalVM Native Image运行在一个名为SubstrateVM的轻量级的虚拟机之上。虽说是轻量级虚拟机，SubstrateVM却拥有运行Java程序所必需的所有组件，包括deoptimizer、gc及thread scheduling等。

- 安装

  ```
  安装配置完成GraalVM后
  gu install native-image
  此命令在MacOS Monterey12.4中不支持执行，报出非root用户执行
  此时需要切换的root用户
  su - 或者 su root
  切换用户后在绝对路径中执行，因为配置的环境变量在非root用户中
  ./Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.3.0/Contents/Home/bin/gu install native-image
  ```

  