```shell
#!/bin/sh

# 声明使用的配置文件
kubeconfig=/root/.kube/kubeconfig-lejian-daily.json 
#kubeconfig=/root/.kube/kubeconfig-lejian-huaweicloud.json 
namespace=daily
#namespace=goldnurse-uat
#namespace=goldnurse


# 选择要使用的配置文件
selected_kubeconfig=0
read -p "选择使用的配置文件
1：使用daily.json
2：使用huaweicloud.json
" selected_kubeconfig
selected_kubeconfig=0
if [ $selected_kubeconfig -eq 1 ]; then
	kubeconfig=/root/.kube/kubeconfig-lejian-daily.json 
elif [ $selected_kubeconfig -eq 2 ]; then
	kubeconfig=/root/.kube/kubeconfig-lejian-huaweicloud.json 
else
	kubeconfig=/root/.kube/kubeconfig-lejian-daily.json 
fi

# 选择要使用的命名空间
selected_namespace=0
read -p "选择使用的命名空间
1：使用daily
2：使用goldnurse-uat
3：使用goldnurse
" selected_namespace
selected_namespace=0
if [ $selected_namespace -eq 1 ]; then
	namespace=daily 
elif [ $selected_namespace -eq 2 ]; then
	namespace=goldnurse-uat
elif [ $selected_namespace -eq 3 ]; then
	namespace=goldnurse
else
	namespace=daily 
fi

# 声明一个变量
podName=""
# 第一条命令
read -p "输入pod名称：" podName
result=$(kubectl --kubeconfig=$kubeconfig  get pods -n $namespace | grep "$podName")

echo "$result"

num=
# 从结果中选择
read -p "选择第几个pod(1-n)：" num
# 选择第num个pod
selected_pod=$(kubectl --kubeconfig=$kubeconfig get pods -n $namespace | grep "$podName" |awk "NR==$num")
# 选择的pod
selected_pod=$(echo $selected_pod | awk '{print $1}')
echo "已选择pod：$selected_pod"
# 选择要执行的命令1输出pod日志2进入该pod
selected_shell=0
# 选择要执行的命令
read -p "1：实时输出pod日志
2：进入该pod
" selected_shell

if [ $selected_shell -eq 1 ]; then
	# 输出pod的日志
	kubectl --kubeconfig=$kubeconfig  logs -f --tail=30 -n $namespace "$selected_pod"
elif [ $selected_shell -eq 2 ]; then
	# 进入该pod
	kubectl --kubeconfig=$kubeconfig  exec -ti -n $namespace "$selected_pod"  -- bash
else
	echo '选择错误'
fi

```

