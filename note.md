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
[传送门](https://flutter.cn/docs/development/tools/sdk/upgrading)
1. flutter channel 显示当前版本
2. flutter channel stable 切换版本到stable / 1.9.1+hotfix.3 版本号
3. ~~flutter channel 1.9.1+hotfix.3 ()~~
4. flutter version //查看版本
5. flutter version 1.9.1+hotfix.3 // 切换到指定版本

## mac 进程kill 
```
ps -ef | grep flutter(进程命令)
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

## App 在macOS Catalina下提示已损坏无法打开解决办法：

打开终端；
输入以下命令，回车；
sudo xattr -d com.apple.quarantine /Applications/xxxx.app
注意：/Applications/xxxx.app 换成你的App路径（推荐直接将.app文件拖入终端中自动生成路径，以防空格等转义字符手动复制或输入出现错误）
重启App即可。

## MAC外接显示器导致无声问题
* 系统偏好设置->声音->输出->耳机

## git 查看提交日志 
```
git log --since="2020-01-17" --pretty=format:"%s"
```

## Android Q 10 视频显示缩略图
https://developer.android.google.cn/reference/android/media/ThumbnailUtils

git log --since="2020-04-20" --pretty=format:"%s"



getFileFromMemory

getFileFromCache

## ssh 拷贝文件
Copy single file from remote to local.
scp admin@192.168.2.76:~/build_mac_for_windows.sh ~/Desktop/jiagu
Copy single file from local to remote.
scp myfile.txt remoteuser@remoteserver:/remote/folder/

## android 粘贴板无法获取内容
需要进行延时获取


1、下载安装jetbrains软件，按照提示完成安装，这里以IntelliJ IDEA为例

2、把下载的jar包放在idea的安装目录下（bin）

3、修改idea安装目录下文件，可以以记事本方式打开

idea.exe.vmoptions
idea64.exe.vmoptions

4、添加 -javaagent:jar包路径
# -javaagent:../bin/JetbrainsCrack.jar
5、重启idea即可

如需要激活先勾选“Activate”，然后勾选“Activation code”，在下面的方框里输入注册码即可

第二步：复制补丁到软件安装目录
将JetbrainsCrack-4.2-release.jar文件安装目录bin文件下

第三步：修改安装目录下bin的两个文件WebStorm.exe.vmoptions 和WebStorm64.exe.vmoptions
在这两个文件末尾添加这行代码

-javaagent: 绝对路径、破解补丁名称（注意：补丁路径要正确，否则软件无法打开）

示例一：安装目录D:\Program Files\情况下
-javaagent:D:\Program Files\JetBrains\WebStorm\bin\JetbrainsCrack-4.2-release.jar

示例二：安装目录D:\sofeware\情况下
-javaagent:D:\sofeware\JetBrains\WebStorm\bin\JetbrainsCrack-4.2-release.jar
修改后，保存文件。确保补丁能够被读取到，破解才能生效。

第四步：启动WebStorm软件，选择activation code，复制下面代码进去。

### Git 提交规则
```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

- type: 本次 commit 的类型，诸如 bugfix docs style等
- scope: 本次 commit 波及的范围，可选
- subject: 简明扼要的阐述下本次 commit 的主旨，在原文中特意强调了几点 1. 使用祈使句，是不是很熟悉又陌生的一个词，来传送门在此 祈使句 2. 首字母不要大写 3. 结尾无需添加标点
- body: 同样使用祈使句，在主体内容中我们需要把本次 commit 详细的描述一下，比如此次变更的动机，如需换行，则使用 |
- footer: 描述下与之关联的 issue 或 break change，详见案例

#### Type的类别说明：
- feat: 添加新特性/新功能
- fix: 修复bug
- docs: 仅仅修改了文档
- style: 仅仅修改了空格、格式缩进、都好等等，不改变代码逻辑
- refactor: 代码重构，没有加新功能或者修复bug
- perf: 增加代码进行性能测试
- test: 增加测试用例
- chore: 改变构建流程、或者增加依赖库、工具等

```
fix:语音频道权限同步异常
feat:举报功能
```

#### 参考文章
* [GitHub](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines)
* [SegmentFault](https://segmentfault.com/a/1190000009048911)
* [倔金](https://juejin.im/post/5b4328bbf265da0fa21a6820)
* [Commit message 和 Change log 编写指南](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)

### Git 分支管理
- master/live（主分支）
- develop（开发）
- feature （功能）
- release/new（预发布）
- fixbug（修复bug）

### 提交模版
```
<类型>: (类型的值见下面描述) <主题> (最多50个字)
解释为什么要做这些改动
|<----  请限制每行最多72个字   ---->|
提供相关文章和其它资源的链接和关键字
例如: Github issue #23
--- 提交 结束 ---

# 类型值包含
# feat: 添加新特性/新功能
# fix: 修复bug
# docs: 仅仅修改了文档
# style: 仅仅修改了空格、格式缩进、都好等等，不改变代码逻辑
# refactor: 代码重构，没有加新功能或者修复bug
# perf: 增加代码进行性能测试
# test: 增加测试用例
# chore: 改变构建流程、或者增加依赖库、工具等
# --------------------
# 注意
# 主题和内容以一个空行分隔
# 主题限制为最大50个字
# 主题行大写
# 主题行结束不用标点
# 主题行使用祈使名
# 内容每行72个字
# 内容用于解释为什么和是什么,而不是怎么做
# 内容多行时以'-'分隔
# --------------------
```

* [参考文章](https://fiissh.tech/2019/git-commit-template.html)

## MVVM
### 参考文章
* (An Introduction to MVVM in Flutter)[https://medium.com/better-programming/mvvm-in-flutter-edd212fd767a]
* (Use Model-View-ViewModel to make your code cleaner in Flutter with Dart Streams)[https://medium.com/free-code-camp/app-architecture-mvvm-in-flutter-using-dart-streams-26f6bd6ae4b6]
* (fast_mvvm github)[https://github.com/StrangerKjq/fast_mvvm]
* (fast_mvvm csdn)[https://blog.csdn.net/q948182974/article/details/106613565]

### 长连接，短连接
网络请求都是使用的httpClient 
* webSocket `websocket_impl.dart`使用的是`httpClient.openUrl("GET")`
* dio `dio.dart` method `_dispatchRequest`
* `io_adapter.dart`的`DefaultHttpClientAdapter`使用`httpClient.openUrl(options.method, options.uri)`;
长连接会出现连接超时，导致短连接发送请求之后会出现超时

### CocoaPods not installed or not in valid state
[传送门](https://github.com/flutter/flutter/issues/54962)