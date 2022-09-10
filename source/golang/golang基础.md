# 编译

```sh
1.Mac
Mac下编译Linux, Windows平台的64位可执行程序：

CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build test.go
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build test.go

2.Linux
Linux下编译Mac, Windows平台的64位可执行程序：

CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build test.go
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build test.go

3.Windows
Windows下编译Mac, Linux平台的64位可执行程序：
SET CGO_ENABLED=0 SET GOOS=darwin3 SET GOARCH=amd64 go build main.go 
SET CGO_ENABLED=0 SET GOOS=linux SET GOARCH=amd64 go build main.go


gmod 项目 下载依赖
 go mod tidy
 
golang常用框架
gin，gorm，bigcache，goframe，grpc

```

