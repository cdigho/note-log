- 配置开机启动文件

  ```bash
  vim /etc/systemd/system/dwzscript.service
  
  [Unit]
  Description=My Custom Script
  After=network.target
  
  [Service]
  Type=forking
  User=root  
  ExecStart=/opt/work/java/start-boot-dwz/restart.sh
  Restart=always  
  
  [Install]
  WantedBy=multi-user.target
  ```

- 执行权限

  ```bash
  chmod +x /opt/work/java/start-boot-dwz/restart.sh
  chown root:root /opt/work/java/start-boot-dwz/restart.sh
  ```

- 启动

  ```bash
  #验证语法
  systemd-analyze verify dwzscript.service
  #重新加载systemd的配置
  systemctl daemon-reload
  systemctl start dwzscript.service
  systemctl status dwzscript.service
  #设置开机启动
  systemctl enable dwzscript.service
  #查看日志
  journalctl -u dwzscript.service
  
  #查询所有已启用的服务
  systemctl list-unit-files --type=service --state=enabled
  #查询特定服务的启动状态
  systemctl is-enabled dwzscript.service
  #查看所有活动服务的状态
  systemctl
  ```

  

