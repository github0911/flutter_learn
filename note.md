## git 操作
**GitHub历史版本回退**
1. git reset --hard commit id
2. git push -f -u origin master

## github chrome 插件
**Octotree 是一个 Chrome 扩展，用来显示 Github 项目的目录结构，它允许你直接从浏览器中浏览项目。通过使用Octotree，你可以减少花费在下载和搜索项目的时间，并且这适用于所有主流的浏览器。**

## 正则表达式
[入门教程](https://deerchao.cn/tutorials/regex/regex-1.htm)

## Mac OS X 安装protobuf
1. 下载protobuf 官网[downloads](https://developers.google.com/protocol-buffers/docs/downloads)
2. 解压下载的文件
3. cd到protobuf-x.x.x目录
4. ./configure
5. make
6. make check
7. sudo make install （需要接着输入密码）
8. which protoc
9. protoc --version

## Mac无法打开“XXXX”，因为Apple无法检查其是否包含恶意软件。”的解决办法
```
sudo spctl --master-disable
```