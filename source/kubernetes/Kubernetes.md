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
#删除pod
kubectl delete pod podname -n namespace
#拷贝文件
    #pod到主机
    kubectl cp -n namespace -c container  podName:filePath localFilePath
    例
    kubectl cp -n goldnurse -c work-goldnurse-open-api  work-goldnurse-open-api-784c897d64-xmpjm:opt/www/logs/goldnurse-open-api-starter/info.log info.log

    #主机到pod
    kubectl cp -n namespace -c container  localFilePath podName:filePath 
    例
    kubectl cp -n goldnurse -c work-goldnurse-open-api  a.txt work-goldnurse-open-api-784c897d64-xmpjm:opt/www/logs/goldnurse-open-api-starter/
podName冒号后省略"/" 否则报错
tar: removing leading ‘/’ from member names

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


#获取类型为Deployment的资源列表
kubectl get deployments

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
```

