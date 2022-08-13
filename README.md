#  Java

[Java基础](code/java/Java基础.md)

[springboot](code/java/springboot.md)

# Python

# Golang

# 环境搭建

[rocketmq](create-env/rocketmq.md)

[seata](create-env/seata.md)

[canal](create-env/canal.md)

# 静态网页

## 方案

[docsify](https://docsify.js.org/#/zh-cn/)

## 部署

根目录编写index.html

```html
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <meta charset="UTF-8">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4/themes/vue.css" />
</head>
<body>
  <div id="app"></div>
  <script>
    window.$docsify = {
      //...
    }
  </script>
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
</body>
</html>
```

