# Centos 7 init

```
vim /etc/profile

##JDK
export JAVA_HOME=/opt/work/jdk1.8.0_11
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
##JDK

##MAVEN_HOME
export MAVEN_HOME=/opt/work/apache-maven-3.6.3
export MAVEN_REPO=/opt/work/apache-maven-3.6.3/repository
export PATH=$PATH:$MAVEN_HOME/bin
##MAVEN_HOME

source /etc/profile

#配置阿里yum源
cd /etc/yum.repos.d/
mv CentOS-Base.repo CentOS-Base-repo.bak
wget http://mirrors.aliyun.com/repo/Centos-7.repo
mv Centos-7.repo CentOS-Base.repo
yum clean all
yum makecache

#安装htop git
yum -y install epel-release htop git

#关闭防火墙
 systemctl stop firewalld
 systemctl disable firewalld.service
```

