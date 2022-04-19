# RocketMQ TLS 加密传输和单向认证的配置

1. 运行脚本 `gencerts.sh` 生成TLS相关的证书

2. 运行脚本 `genserverconf.sh` 生成 RocketMQ 服务端的配置文件

3. 将生成的配置文件 `rocketmq/tls.properties` 拷贝到 `%{ROCKETMQ_HOME}/conf` 目录下

4. 修改 `%{ROCKETMQ_HOME}/bin/runserver.sh` ， 增加 JVM 启动参数到 `JAVA_OPT` 属性

```
JAVA_OPT="${JAVA_OPT} -Dtls.config.file=${BASE_DIR}/conf/tls.properties"
``` 

5. 对 `%{ROCKETMQ_HOME}/bin/runbroker.sh` 做同样的修改

6. 客户端增加如下的JVM启动参数：

```
-Dtls.enable=true \
-Dtls.test.mode.enable=false \
-Dtls.client.authServer=true \
-Dtls.client.trustCertPath=[CA 证书路径]
```
