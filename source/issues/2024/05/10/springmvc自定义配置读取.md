问题场景旧的springmvc项目不支持多环境的配置文件读取

- 配置配置文件读取器
- 重写PropertySourcesPlaceholderConfigurer的setLocation方法
- 通过获取虚拟机参数spring.profiles.active
- 判断spring.profiles.active的值读取不同的环境配置文件

[具体的实现](https://github.com/cdigho/springmvc-self-config.git)