```
docker常用命令
https://www.jianshu.com/p/41c4633e6edf

docker run -d -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=root  docker.io/mysql:latest

docker exec -it e1613723f99c /bin/sh 

alter user 'root'@'%' identified with mysql_native_password by 'root';


docker run -p 27017:27017 -v /opt/data/mongodb:/data/db --name mongodb -d mongo

docker run -p 27017:27017 -v /Users/yho/WorkFile/opt/data/mongodb:/data/db --name mongodb -d mongo

docker run -p 6379:6379 --name redis -v /Users/yho/WorkFile/opt/configs/redis.conf:/etc/redis/redis.conf -v /usr/local/docker/data:/data -d redis redis-server /etc/redis/redis.conf --appendonly yes

docker run -p 6379:6379 --name redis -v /Users/yho/WorkFile/opt/configs/redis.conf:/etc/redis/redis.conf  -v /Users/yho/WorkFile/opt/data/redis:/data -d redis redis-server /etc/redis/redis.conf --appendonly yes


docker run -d --hostname rabbit-host --name rabbitmq -e RABBITMQ_DEFAULT_USER=admin -e RABBITMQ_DEFAULT_PASS=admin -p 15672:15672 -p 5672:5672 rabbitmq:3-management

docker run -d --name zookeeper -p 2181:2181 -v /etc/localtime:/etc/localtime wurstmeister/zookeeper

docker run  -d --name kafka -p 9092:9092 -e KAFKA_BROKER_ID=0 -e KAFKA_ZOOKEEPER_CONNECT=192.168.124.3:2181 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.124.3:9092 -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 -t wurstmeister/kafka

docker run --name elasticsearch -p 9200:9200 -p 9300:9300 -e  "ES_JAVA_OPTS=-Xms512m -Xmx512m"  -e "discovery.type=single-node" -d  a6cbb6bace0e 


docker run -p 3306:3306 --name mysql01   -v /Users/yho/working/install/docker/mysql/data:/var/lib/mysql -v /Users/yho/working/install/docker/mysql/conf:/etc/mysql/conf.d  -e MYSQL_ROOT_PASSWORD=root  -d mysql  --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

```

