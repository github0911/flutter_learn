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

## flutter 切换版本
**历史版本**
[release](https://flutter.dev/docs/development/tools/sdk/releases?tab=macos)
1. flutter channel 显示当前版本
2. flutter channel stable 切换版本到stable / 1.9.1+hotfix.3 版本号
3. flutter channel 1.9.1+hotfix.3 

## mac 进程kill 
```
kill -9 999 (999为进程id)
```

## Charles cannot configure your proxy settings while it is on a read-only volume. Perhaps you are running Charles from the disk image? If so, please copy Charles to the Applications folder and run it again. Otherwise please ensure that Charles is running on a volume that is read-write and try again
sudo chown -R root "/Applications/Charles.app/Contents/Resources"
sudo chmod -R u+s "/Applications/Charles.app/Contents/Resources"

## macos 查看本地ip地址
**ifconfig可以显示网络接口的网络参数，但是直接输入的话会显示一堆我们并不需要的数据，所以用grep进行过滤。**
```
ifconfig | grep "inet " | grep -v 127.0.0.1
```

## Charles 功能介绍和使用教程
[传送门](https://juejin.im/post/5b8350b96fb9a019d9246c4c)

## 安装zsh之后，打开终端（命令行）需要执行source ~/.bash_profile配置环境变量才生效
* 发现zsh加载的是 ~/.zshrc文件，而 ‘.zshrc’ 文件中并没有定义任务环境变量。
* 在~/.zshrc文件最后，增加一行：`source ~/.bash_profile`