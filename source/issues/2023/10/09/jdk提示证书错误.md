##### 问题场景

- 通过一个URL图片保存到本地文件提示报错unable to find valid certification path to requested target

##### 运行环境

```
服务器k8s容器内
Dockerfile内容
FROM swr.cn-east-3.myhuaweicloud.com/lejian-system/java:ubuntu-jdk1.8.0_60
COPY goldnurse-modules-channel-server/target/goldnurse-modules-channel-server-0.0.3-SNAPSHOT.jar /app.jar
ENV JAVA_OPTS="-Xms128m -Xmx256m"
EXPOSE 8080 8090
CMD ["/bin/bash", "-c", "java ${JAVA_OPTS} -jar /app.jar"]
```

##### 具体报错代码

```java
Caused by: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
	at sun.security.validator.PKIXValidator.doBuild(PKIXValidator.java:387) ~[?:1.8.0_60]
	at sun.security.validator.PKIXValidator.engineValidate(PKIXValidator.java:292) ~[?:1.8.0_60]
	at sun.security.validator.Validator.validate(Validator.java:260) ~[?:1.8.0_60]
	at sun.security.ssl.X509TrustManagerImpl.validate(X509TrustManagerImpl.java:324) ~[?:1.8.0_60]
	at sun.security.ssl.X509TrustManagerImpl.checkTrusted(X509TrustManagerImpl.java:229) ~[?:1.8.0_60]
	at sun.security.ssl.X509TrustManagerImpl.checkServerTrusted(X509TrustManagerImpl.java:124) ~[?:1.8.0_60]
	at sun.security.ssl.ClientHandshaker.serverCertificate(ClientHandshaker.java:1488) ~[?:1.8.0_60]
	... 70 more
Caused by: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
	at sun.security.provider.certpath.SunCertPathBuilder.build(SunCertPathBuilder.java:146) ~[?:1.8.0_60]
	at sun.security.provider.certpath.SunCertPathBuilder.engineBuild(SunCertPathBuilder.java:131) ~[?:1.8.0_60]
	at java.security.cert.CertPathBuilder.build(CertPathBuilder.java:280) ~[?:1.8.0_60]
	at sun.security.validator.PKIXValidator.doBuild(PKIXValidator.java:382) ~[?:1.8.0_60]
	at sun.security.validator.PKIXValidator.engineValidate(PKIXValidator.java:292) ~[?:1.8.0_60]
	at sun.security.validator.Validator.validate(Validator.java:260) ~[?:1.8.0_60]
	at sun.security.ssl.X509TrustManagerImpl.validate(X509TrustManagerImpl.java:324) ~[?:1.8.0_60]
	at sun.security.ssl.X509TrustManagerImpl.checkTrusted(X509TrustManagerImpl.java:229) ~[?:1.8.0_60]
	at sun.security.ssl.X509TrustManagerImpl.checkServerTrusted(X509TrustManagerImpl.java:124) ~[?:1.8.0_60]
	at sun.security.ssl.ClientHandshaker.serverCertificate(ClientHandshaker.java:1488) ~[?:1.8.0_60]
```

##### 执行代码逻辑

```java
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.UUID;

public class Main {

    public static void main(String[] args) throws Exception {
        String url = "";
        String fileTempPath = null;
        URLConnection openConnection = new URL(url).openConnection();
        InputStream inputStream = openConnection.getInputStream();
        String baseDir = System.getProperty("user.dir");
        String fileSuffix = url.substring(url.lastIndexOf("."), url.length());
        fileTempPath = baseDir + File.separator + UUID.randomUUID().toString().replaceAll("-", "") + fileSuffix;
        System.out.println(fileTempPath);
        byte[] data = new byte[1024];
        int len;
        FileOutputStream output = new FileOutputStream(fileTempPath);
        while ((len = inputStream.read(data)) != -1) {
            output.write(data, 0, len);
        }
        output.close();
        inputStream.close();
    }
}
```

##### 问题沟通

因证书提供自华为云，经过沟通华为反馈如下

```
您好，当前旧根可以使用到2026年4月15号，后续您再续费的时候，您提前提单联系我们，我们第一时间给CA反馈，还是使用旧根跟您签发。
后续您也可以进行业务优化，兼容新根DigiCert Global Root G2，旧根使用的SHA1算法，新的使用SHA256
https://support.huaweicloud.com/bulletin-ccm/ccm_01_0139.html#ccm_01_0139__table4642135144618
```

![1696842575513](D:\me\note-log\source\issues\2023\10\09\1696842575513.png)

##### 问题结论

大概意思为，新提供的根证书，未在jdk根证书中不信任问题。当时服务器jdk版本为1.8.0_60，开发本地版本为1.8.0_202，猜测jdk的版本不信任华为云新颁发的根证书。这个猜测还没有验证。