需要配置环境变量，才能使用keytool生成密钥库
[flutter 官方打包流程](https://flutter-io.cn/docs/deployment/android)
# 错误示范
java keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
# keystore
keytool -genkey -v -keystore key.keystore -alias xinyan -keyalg RSA -validity 10000
# jks
keytool -genkey -v -keystore E:/project/beenest/android/app/key.jks -keyalg RSA -keysize 2048 -validity 30000


```
-certreq            生成证书请求
 -changealias        更改条目的别名
 -delete             删除条目
 -exportcert         导出证书
 -genkeypair         生成密钥对
 -genseckey          生成密钥
 -gencert            根据证书请求生成证书
 -importcert         导入证书或证书链
 -importpass         导入口令
 -importkeystore     从其他密钥库导入一个或所有条目
 -keypasswd          更改条目的密钥口令
 -list               列出密钥库中的条目
 -printcert          打印证书内容
 -printcertreq       打印证书请求的内容
 -printcrl           打印 CRL 文件的内容
 -storepasswd        更改密钥库的存储口令
```
 