# 配置kubectl

[参考文档](https://www.cnblogs.com/shadow-yin/p/14843099.html)

[版本发布页面](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/README.md)

1.搜索cce

![image-20231006160349829](assets/image-20231006160349829.png)

2.下载kubectl配置文件

![image-20231006160606934](assets/image-20231006160606934.png)

3.可选配置

```
#指定配置文件的别名-乐荐kubectl 
vim ~/.bash_profile
alias ljkubectl="kubectl --kubeconfig=/Users/username/.kube/kubeconfig-lejian-huawei.json "
source ~/.bash_profile
```

# 常用命令

```
#查找某一个具体的pod的日志
kubectl get pods --all-namespaces|grep '<your-pod-name>'
kubectl  logs -f <your-pod-name> -n <your-namespace>
#--tail=n 最近n条日志
kubectl  logs -f --tail=1 <your-pod-name> -n <your-namespace>
#grep检索日志
kubectl  logs  <your-pod-name> -n <your-namespace>|grep 'search-str' -B 3
#进入pod
kubectl exec -ti <your-pod-name> -n <your-namespace>  -- /bin/sh
#win搭配gitbash 此处可在用户目录编写~/.bash_profile文件
#例如 alias prod="winpty kubectl --kubeconfig=/c/Users/wlyxt/.kube/config "
winpty kubectl exec -ti <your-pod-name> -n <your-namespace>  -- bash

#在 pod 外执行容器命令
kubectl exec -ti <your-pod-name> -n <your-namespace>  -- ls
kubectl exec -ti <your-pod-name> -n <your-namespace>  -- bash -c 'ls'

#删除重启pod
kubectl delete pod podname -n namespace
#滚动更新重启
kubectl rollout restart deployment $DEPLOYMENT -n $NAMESPACE

#拷贝文件
    #pod到主机
    kubectl cp -n namespace -c container  podName:filePath localFilePath
    例
    kubectl cp -n goldnurse -c work-goldnurse-open-api  work-goldnurse-open-api-784c897d64-xmpjm:opt/www/logs/goldnurse-open-api-starter/info.log info.log
    kubectl cp -n goldnurse work-goldnurse-open-api-784c897d64-xmpjm:opt/www/logs/goldnurse-open-api-starter/info.log info.log

    #主机到pod
    kubectl cp -n namespace -c container  localFilePath podName:filePath 
    例
    kubectl cp -n goldnurse -c work-goldnurse-open-api  a.txt work-goldnurse-open-api-784c897d64-xmpjm:opt/www/logs/goldnurse-open-api-starter/
    kubectl cp -n goldnurse a.txt work-goldnurse-open-api-784c897d64-xmpjm:opt/www/logs/goldnurse-open-api-starter/

podName冒号后省略"/" 否则报错
tar: removing leading ‘/’ from member names

#查看ingress配置（Nginx）
#根据域名查询ingress name
kubectl -n ${namespace} get ingress |grep ${domain}
#示例：
kubectl -n goldnurse get ingress |grep s.goldnurse.com

#查看inress详细配置
kubectl -n ${namespace} get ingress ${ingress_name} -o yaml
#示例：
kubectl -n goldnurse get ingress goldnurse-s -o yaml

kubectl get pods 
#查看Pod 的更多信息
kubectl get pods -o wide 
#查看pod 定义的详细信息
kubectl get pods -o yaml 
#查看pod 的命名空间
kubectl get pods -o yaml 
#查看所有名称空间下的pod 包含namespaces的展示
kubectl get pods --all-namespaces 
# 查看 daily 名称空间的 pod
kubectl get pod -n daily

#实时查看pod的日志
kubectl  logs -f $POD_NAME -n $NAMESPACE

#获取类型为services的资源列表
kubectl  get services -n $NAMESPACE|grep ''

#获取类型为Deployment的资源列表
kubectl get deployments $SERVICES -N $NAMESPACE

#获取类型为Pod的资源列表
kubectl get pods

#获取类型为Node的资源列表
kubectl get nodes


# 查看所有名称空间的 Deployment
kubectl get deployments -A
kubectl get deployments --all-namespaces
# 查看 daily 名称空间的 Deployment
kubectl get deployments -n daily
    
# 查看有哪些名称空间 
kubectl get ns

#获取类型为service(svc)的资源列表
kubectl get svc
kubectl get svc -n $NAMESPACE
kubectl get svc --all-namespaces
kubectl get svc --all-namespaces -o wide 


k8容器内连接MySQL
	方式一 mycli Python工具
		centos yum install pip && pip install mycli
		ubuntu install mycli -> apt-get update && apt-get install mycli
		mycli -h host -u username  -p pwd

	方式二 go-mysql-client golang工具
	git clone https://github.com/deveho/go-mysql-client.git
	go mod tidy && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build  cmd/gomysql/main.go && mv main mysql
		./mysql -h host -u username  -p pwd databaseName

```



# k8s unbutu内安装curl&telnet&ping

```
apt-get update && apt-get -y install curl openbsd-inetd telnet iputils-ping net-tools
安装rzsz
apt-get -y install lrzsz
```

# Alpine linux 

```
sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories                                                                    
apk update
apk add curl
apk add busybox-extras
```

