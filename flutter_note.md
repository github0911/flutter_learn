## [Windows 安装flutter]("https://flutterchina.club/setup-windows/")
[Windows 安装flutter](https://flutterchina.club/setup-windows/)
### 使用外部包的操作流程：
编辑pubspec.yaml 在dependencies中加入所需要引入的package  
pubspec文件管理Flutter应用程序的assets(资源，如图片、package等)。  
在Android Studio的编辑器视图中查看pubspec时，单击右上角的 Packages get，这会将依赖包安装到您的项目。（类似gradle sync）
**Widget**
>@immutable 注解，这意味着控件不可被修改，只能被重新创建
* 1、StatelessWidget 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
* 2、StatefulWidget 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
    一个 StatefulWidget类。
    一个 State类。 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在.

提示: 在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新  
提示: 某些widget属性需要单个widget（child），而其它一些属性，如action，需要一组widgets(children），用方括号[]表示。  
### [语法]("https://www.jianshu.com/p/3d927a7bf020")
变量声明
--
1. var  可以接收任何类型的变量，但是赋值之后类型就会确定，不能再改变其类型。
2. dynamic, Object 是Dart所有对象的根基类，也就是说所有类型都是Object的子类。任何类型都可以赋值给Object，dynamic与var都是关键词，声明的变量可以赋值任意对象。而dynamic与Object相同之处在于他们声明的变量可以在后期改变赋值类型。dynamic与Object不同的是，dynamic声明的对象编译器会提供所有可能的组合，而Object声明只能使用Object的属性与方法。否则编译器会报错。
3. final和const 如果从未打算更改一个变量，那么使用final或const。一个final变量只能被设置一次，两者区别在于const变量是一个编译时常量，final变量在第一次使用时被初始化。被final或const修饰的变量，变量类型可以省略。

函数  
--
Dart是一种真正的面向对象的语言，所以即使是函数也是对象，并且有一个类型Function。这意味着函数可以赋值给变量或作为参数传递给其他函数，这是函数式编程的典型特征。  
可选的位置参数，[]标记为可选的位置参数。  
可选的命名参数，定义函数，使用{param1, param2,}，用于指定命名参数

异步支持
--
Dart类库有非常多的返回`Future`或者`Stream`对象的函数。 这些函数被称为**异步函数**：它们只会在设置好一些耗时操作之后返回，比如像 IO操作。而不是等到这个操作完成。  
`async`和`await`关键词支持了异步编程，允许您写出和同步代码很像的异步代码。  

**Future**  
Future与JavaScript中的Promise非常相似，表示一个异步操作的最终完成（或失败）及其结果值的表示。简单来说，它就是用于处理异步操作的，异步处理成功了就执行成功的操作，异步处理失败了就捕获错误或者停止后续操作。一个Future只会对应一个结果，要么成功，要么失败。

由于本身功能较多，这里我们只介绍其常用的API及特性。还有，请记住，Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用。  
**Future.wait**  
有些时候，我们需要等待多个异步任务都执行结束后才进行一些操作，比如我们有一个界面，需要先分别从两个网络接口获取数据，获取成功后，我们需要将两个接口数据进行特定的处理后再显示到UI界面上，应该怎么做？答案是`Future.wait`，它接受一个`Future数组参数`，只有数组中所有Future都执行成功后，才会触发then的成功回调，只要有一个Future执行失败，就会触发错误回调。下面，我们通过模拟Future.delayed 来模拟两个数据获取的异步任务，等两个异步任务都执行成功时  
**async/await**  
如果代码中有大量异步逻辑，并且出现大量异步任务依赖其它异步任务的结果时，必然会出现Future.then回调中套回调情况。举个例子，比如现在有个需求场景是用户先登录，登录成功后会获得用户ID，然后通过用户ID，再去请求用户个人信息，获取到用户个人信息后，为了使用方便，我们需要将其缓存在本地文件系统，代码如下：
```dart
    //先分别定义各个异步任务
    Future<String> login(String userName, String pwd){
        ...
        //用户登录
    };
    Future<String> getUserInfo(String id){
        ...
        //获取用户信息 
    };
    Future saveUserInfo(String userInfo){
        ...
        // 保存用户信息 
    };

```

接下来，执行整个任务流：  
```dart
    login("alice","******").then((id){
         //登录成功后通过，id获取用户信息    
     getUserInfo(id).then((userInfo){
            //获取用户信息后保存 
        saveUserInfo(userInfo).then((){
               //保存用户信息，接下来执行其它操作
            ...
        });
      });
    })
```
**使用Future消除Callback Hell**
```dart
    login("alice","******").then((id){
          return getUserInfo(id);
    }).then((userInfo){
        return saveUserInfo(userInfo);
    }).then((e){
       //执行接下来的操作 
    }).catchError((e){
      //错误处理  
      print(e);
    });
```

正如上文所述， “Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用” ，如果在then中返回的是一个Future的话，该future会执行，执行结束后会触发后面的then回调，这样依次向下，就避免了层层嵌套。

**使用async/await消除callback hell**  
通过Future回调中再返回Future的方式虽然能避免层层嵌套，但是还是有一层回调，有没有一种方式能够让我们可以像写同步代码那样来执行异步任务而不使用回调的方式？答案是肯定的，这就要使用async/await了，下面我们先直接看代码，然后再解释，代码如下：
```dart
task() async {
       try{
        String id = await login("alice","******");
        String userInfo = await getUserInfo(id);
        await saveUserInfo(userInfo);
        //执行接下来的操作   
       } catch(e){
        //错误处理   
        print(e);   
       }  
    }
```
- async用来表示函数是异步的，定义的函数会返回一个Future对象，可以使用then方法添加回调函数。
- await 后面是一个Future，表示等待该异步任务完成，异步完成后才会往下走；await必须出现在 async 函数内部。

可以看到，我们通过async/await将一个异步流用同步的代码表示出来了。
>其实，无论是在JavaScript还是Dart中，async/await都只是一个语法糖，编译器或解释器最终都会将其转化为一个Promise（Future）的调用链。

**stream**  
[api&doc](https://dart.dev/tutorials/language/streams)
[全面深入理解Stream](https://juejin.im/post/5cc2acf86fb9a0321f042041)

Flutter所使用的Dart语言，没有类似Java的publice protect private，以_开头的变量、函数和类，意味着它仅在库中是可视的  
在Dart中，当你不需要去改变一个变量的时候，应该使用final或者const，而不是使用var去声明一个变量。  
一个final变量只允许被赋值一次，必须在定义时或者构造函数参数表中将其初始化。  
const所修饰的是编译时常量，我们在编译时就已经知道了它的值，它的值是不可改变的。  
dart 中类 implements 不需要重写父类的构造方法  
Dart 语言并没有提供 interface 关键字，但是每一个类都隐式地定义了一个接口。

如何更新 Widget
--
在 Android 中，你可以直接操作更新 View。然而在 Flutter 中，Widget 是不可变的， 无法被直接更新，你需要操作 Widget 的状态。  
这就是有状态 (Stateful) 和无状态 (Stateless) Widget 概念的来源。  
这里需要着重注意的是，无状态和有状态的 Widget 本质上是行为一致的。它们每一帧都会重建，不同之处 在于 StatefulWidget 有一个跨帧存储和恢复状态数据的 State 对象。
如果一个 Widget 会变化（例如由于用户交互），它是有状态的。 然而，如果一个 Widget 响应变化，它的父 Widget 只要本身不响应变化，就依然是无状态的。 

在函数式编程中，你可以做到：
--
1. 将函数当做参数进行传递
2. 将函数直接赋值给变量
3. 对函数进行解构，只传递给函数一部分参数来调用它，让它返回一个函数去处理剩下的参数（也被称为柯里化）
4. 创建一个可以被当作为常量的匿名函数（也被称为 lambda 表达式，在 Java 的 JDK 8 release 中支持了 lambda 表达式）

Dart 支持所有的这些特性，在 Dart 中，每个函数都是一个对象，并且每个函数都有它的类型 Function，这意味着所有函数都可以支持赋值操作，以及都可以作为参数传递给其他的函数。你可以将实例化 Dart 类当做一个函数的调用行为，类似于这个例子。

为了允许一个类具有多个构造方法，Dart 支持命名构造方法：  
Button
为什么给 onPressed 字段传递空代码块
如果传递 null ，或不包含这一字段（默认值是 null ），这些按钮会被禁用。它们会没有触摸反馈，我们也无法得知其可用时的表现。传递空代码块来让它们不被禁用。

**标高（Elevation）的注意点：**
- 在 Material Design 里，所有的界面，组件都有自己的标高值；
- 在不同标高表面的边缘会有分割线来区别他们谁更"高"；
- 不同表面之间的高度差可以使用暗淡的背景，增亮的背景或阴影来表示；
- 标高较高的表面往往意味着内容也相对较为重要。

除 FlatButton 和 RaisedButton 之外，还有 OutlineButton ， FloatingActionButton ， IconButton ，等等。

**控件说明**  
Column 一个children属性，包含多个子项。垂直控件多个，但是不能滚动
ListView 一个children属性，包含多个子项。垂直控件多个，可以滚动
Row 水平控件多个
Align,Center,Container 只能存放一个控件

**对齐方式**  
+ crossAxisAlignment 横轴（横向，水平）方向
+ MainAxisAlignment 主轴（垂直）方向

**stack**  
类似于Android layout的FrameLayout。  
```dart
Stack(
        this.alignment = AlignmentDirectional.topStart,
        this.textDirection,
        this.fit = StackFit.loose,
        this.overflow = Overflow.clip,
        List<Widget> children = const <Widget>[],
    )
```

### Positioned 
- A widget that controls where a child of a [Stack] is positioned.
- 用于stack布局控制的widget

#### 容器类Widget和布局类Widget都作用于其子Widget，不同的是：
- 布局类Widget一般都需要接收一个widget数组（children），他们直接或间接继承自（或包含）MultiChildRenderObjectWidget ；而容器类Widget一般只需要接收一个子Widget（child），他们直接或间接继承自（或包含）SingleChildRenderObjectWidget。
- 布局类Widget是按照一定的排列方式来对其子Widget进行排列；而容器类Widget一般只是包装其子Widget，对其添加一些修饰（补白或背景色等）、变换(旋转或剪裁等)、或限制(大小等)。

## Padding
Padding可以给其子节点添加补白（填充），我们在前面很多示例中都已经使用过它了，现在来看看它的定义：

```dart
Padding({
  ...
  EdgeInsetsGeometry padding,
  Widget child,
})
```

EdgeInsetsGeometry是一个抽象类，开发中，我们一般都使用EdgeInsets，它是EdgeInsetsGeometry的一个子类，定义了一些设置补白的便捷方法。

### EdgeInsets

我们看看EdgeInsets提供的便捷方法：

- `fromLTRB(double left, double top, double right, double bottom) `：分别指定四个方向的补白。
- `all(double value)` : 所有方向均使用相同数值的补白。
- `only({left, top, right ,bottom })`：可以设置具体某个方向的补白(可以同时指定多个方向)。
- `symmetric({  vertical, horizontal })`：用于设置对称方向的补白，vertical指top和bottom，horizontal指left和right。

## ConstrainedBox和SizedBox 布局限制
ConstrainedBox和SizedBox都是通过RenderConstrainedBox来渲染的。SizedBox只是ConstrainedBox的一个定制

### ConstrainedBox
ConstrainedBox用于对子widget添加额外的约束。例如，如果你想让子widget的最小高度是80像素，你可以使用`const BoxConstraints(minHeight: 80.0)`作为子widget的约束。

#### BoxConstraints
BoxConstraints用于设置限制条件，它的定义如下：
```dart
const BoxConstraints({
  this.minWidth = 0.0, //最小宽度
  this.maxWidth = double.infinity, //最大宽度
  this.minHeight = 0.0, //最小高度
  this.maxHeight = double.infinity //最大高度
})
```
### SizedBox
SizedBox用于给子widget指定固定的宽高
```dart
SizedBox(
  width: 80.0,
  height: 80.0,
  child: redBox
)
```
### BoxDecoration
我们通常会直接使用BoxDecoration，它是一个Decoration的子类，实现了常用的装饰元素的绘制。
```dart
BoxDecoration({
  Color color, //颜色
  DecorationImage image,//图片
  BoxBorder border, //边框
  BorderRadiusGeometry borderRadius, //圆角
  List<BoxShadow> boxShadow, //阴影,可以指定多个
  Gradient gradient, //渐变
  BlendMode backgroundBlendMode, //背景混合模式
  BoxShape shape = BoxShape.rectangle, //形状
})
```
### Expanded
`Expanded widgets must be placed directly inside Flex widgets.`
- Expanded只能作为flex及其子类widget中。

### 导航返回拦截WillPopScope
```dart
const WillPopScope({
  ...
  @required WillPopCallback onWillPop,
  @required Widget child
})
```
onWillPop是一个回调函数，当用户点击返回按钮时调用（包括导航返回按钮及Android物理返回按钮），
该回调需要返回一个Future对象，如果返回的Future最终值为false时，则当前路由不出栈(不会返回)，
最终值为true时，当前路由出栈退出。我们需要提供这个回调来决定是否退出。

### 页面跳转
```dart
Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
  return new ScaffoldWidget();
}));

```

### Transform变换

#### 平移
`Transform.translate`接收一个offset参数，可以在绘制时沿x、y轴对子widget平移指定的距离。
```dart
DecoratedBox(
  decoration:BoxDecoration(color: Colors.red),
  //默认原点为左上角，左移20像素，向上平移5像素  
  child: Transform.translate(
    offset: Offset(-20.0, -5.0),
    child: Text("Hello world"),
  ),
)
```
#### 旋转
`Transform.rotate`可以对子widget进行旋转变换。
```dart
DecoratedBox(
  decoration:BoxDecoration(color: Colors.red),
  child: Transform.rotate(
    //旋转90度
    angle:math.pi/2 ,
    child: Text("Hello world"),
  ),
)
```
#### 缩放
`Transform.scale`可以对子Widget进行缩小或放大。
```dart
DecoratedBox(
  decoration:BoxDecoration(color: Colors.red),
  child: Transform.scale(
      scale: 1.5, //放大到1.5倍
      child: Text("Hello world")
  )
)
```
+ Transform的变换是应用在绘制阶段，而并不是应用在布局(layout)阶段，所以无论对子widget应用何种变化，其占用空间的大小和在屏幕上的位置都是固定不变的，因为这些是在布局阶段就确定的。
```dart
 Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    DecoratedBox(
      decoration:BoxDecoration(color: Colors.red),
      child: Transform.scale(scale: 1.5,
          child: Text("Hello world")
      )
    ),
    Text("你好", style: TextStyle(color: Colors.green, fontSize: 18.0),)
  ],
)
```

**本地图片加载配置与实现**  
在pubspec.yaml 文件中flutter: 节点增加  
    
    flutter: 
      assets:
      # 这样是assets目录下所有文件
      # 如果是assets/ic_launcher.png 指定某个文件
        - assets/
    
**嵌套行和列**  
为了最大限度地减少高度嵌套的布局代码可能导致的视觉混乱，可以在变量和函数中实现 UI 的各个部分。  

### 点击事件处理

注意： 当同时监听onTap和onDoubleTap事件时，当用户触发tap事件时，会有200毫秒左右的延时，
这是因为当用户点击完之后很可能会再次点击以触发双击事件，所以GestureDetector会等一段时间来确定是否为双击事件。
如果用户只监听了onTap（没有监听onDoubleTap）事件时，则没有延时。

### 动画通知

我们可以通过Animation来监听动画的帧和状态变化：

- addListener()可以给Animation添加帧监听器，在每一帧都会被调用。帧监听器中最常见的行为是改变状态后调用setState()来触发UI重建。
- addStatusListener()可以给Animation添加“动画状态改变”监听器；动画开始、结束、正向或反向（见AnimationStatus定义）时会调用StatusListener。

**代码块**

    void main() {
        printf("Hello, Flutter.");
    }

plugins
--
接入plugin三步走：  
1. 修改pubspec.yaml 在dependencies加入对应的插件版本信息
2. 在Android Studio的编辑器视图中查看pubspec时，单击右上角的 Packages get，这会将依赖包安装到您的项目。（类似gradle sync）
3. 在需要使用的文件中导入依赖

更新依赖包
==
当你在添加一个包后首次运行（IntelliJ中的’Packages Get’）flutter packages get，Flutter将找到包的版本保存在pubspec.lock。
这确保了如果您或您的团队中的其他开发人员运行flutter packages get后回获取相同版本的包。

如果要升级到软件包的新版本，例如使用该软件包中的新功能，请运行flutter packages upgrade（在IntelliJ中点击Upgrade dependencies）。 
这将根据您在pubspec.yaml中指定的版本约束下载所允许的最高可用版本。

### Building and installing the Flutter app
- cd $FLUTTER_ROOT/examples/flutter_gallery
- flutter pub get
- flutter run --release

The flutter run --release command both builds and installs the Flutter app.

[Add Flutter to existing apps]("https://www.jianshu.com/p/7c1a2dc27a80")
[Add Flutter to existing apps]("https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps")

1. 在 Android 原生的项目基础中，如何集成 Flutter

打开你的项目，找到 Terminal，输入终端命令：flutter channel

如果输出如下：

1、我们需要切换到 master 分支，继续输入终端命令：flutter channel master，
2、等待执行完毕之后，我们就成功的切换到了 master 分支。为什么要切换到 master 分支？
3、因为我们在安装 Flutter 的时候，默认安装的是 beta 版本。
4、该版本，目前是不支持在现有项目中集成 Flutter Module 模块功能的。
5、如果在 beta 版本中，执行了创建 Module 命令：flutter create -t module 你要创建的库的名字，
6、它会提示你 “module” is not an allowed value for option “template” 。

执行终端命令，创建你的 Flutter Library：flutter create -t module flutter_library

等待执行，创建成功后，会如下所示：

注意：命令中的 flutter_library, 是我对 Flutter Library 的命名。你可以替换为你的命名。

将 flutter_library 添加到 Android 工程

找到 Project 层 setting.gradle 文件并打开，添加如下代码：

编译通过后，在 app 目录下的 build.gradle，添加依赖：

[oktoast]("https://www.kikt.top/posts/flutter/toast/oktoast/#%E6%96%87%E6%9C%AC-toast")  
[oktoast接入官方示例]("https://pub.dev/packages/oktoast#-example-tab-")  
默认圆角为10，显示时长为2.3s。

[Notebook]("https://github.com/OpenFlutter/Flutter-Notebook")  
[Flutter快速上车之Widget]("https://www.yuque.com/xytech/flutter/hc0xq7")  
[Flutter入门总结]("https://www.yuque.com/chenshier/chuyi/wtoyoq#43c760ef")
[Flutter_Project]("https://github.com/CarGuo/GSYGithubAppFlutter")

## flutter 示例工程项目
- [flutter_deer](https://github.com/simplezhli/flutter_deer)
- [GSYGithubAppFlutter](https://github.com/CarGuo/GSYGithubAppFlutter)

## 控件
- [marquee_text](https://github.com/bytedance/marquee_text)
- [RealRichText](https://github.com/bytedance/RealRichText)

## 开发插件包
- [开发插件包](https://flutterchina.club/developing-packages/)
- [官方文档](https://flutter-io.cn/docs/development/packages-and-plugins/developing-packages)

## flutter 开发环境异常处理
[Dart snapshot generator failed with exit code -6||error: Failed to memory map snapshot](https://github.com/flutter/flutter/issues/21859)
``` 
git clean -xfd
git stash save --keep-index
git stash drop
git pull
flutter doctor
```
- 如果`flutter doctor`成功，但是运行flutter工程仍然失败，删除安装目录`flutter/bin/cache`文件夹。再重新执行`flutter doctor`更新sdk配置
- 如果出现Dart Analysis not terminated 进行缓存清除，重新安装依赖
flutter Resolving dependencies...[flutter Resolving dependencies...](https://stackoverflow.com/questions/50145415/flutter-get-stuck-at-resolving-dependencies-for-android/53943887)
```
1. go to this folder ::  "your_project_folder/android/"
2. delete ".gradle"
3. open cmd in that directory 
4. type ".\gradlew" in cmd 
```
`删除本地工程目录下的.gradle文件夹，命令行运行.\gradlew（windows）`


.. 在dart中是一种语法，不是操作符。如果返回的是void是无法使用的，只有返回的是

## example
[flutter/examples/](https://github.com/flutter/flutter/tree/master/examples)
[flutter/samples](https://github.com/flutter/samples)
[flutter-go](https://github.com/alibaba/flutter-go)

**异常处理**
- [couldn't find "libflutter.so"](https://juejin.im/post/5c3444116fb9a049e6606bc4)
- No file or variants found for asset: assets/images. `images没有/结尾`。
- [how-to-set-landscape-orientation-mode-for-flutter-app](https://stackoverflow.com/questions/51806662/how-to-set-landscape-orientation-mode-for-flutter-app)


## dart protobuf_plugin 配置（Windows）
- [下载](https://developers.google.com/protocol-buffers/docs/cpptutorial#compiling-your-protocol-buffers)
- [releases版本](https://github.com/protocolbuffers/protobuf/releases/tag/v3.9.1)
- step1 下载完之后解包。配置bin到环境变量中。这是配置protoc，命令行运行protoc是否配置正常  
- step2 配置pub环境变量，在flutter目录flutter\bin\cache\dart-sdk\bin配置到环境变量中，命令行运行pub是否正常
- step3 运行pub global activate protoc_plugin 启用protoc插件 会在C:\Users\just_\AppData\Roaming\Pub\Cache\bin目录下更新一个protoc-gen-dart.bat文件
- step4 配置C:\Users\just_\AppData\Roaming\Pub\Cache\bin到环境变量中
- flutter pub global activate encrypt `mac os`

### Dart plugin for the protoc compiler 编译proto成dart文件
[protoc_plugin](https://github.com/dart-lang/protobuf/tree/master/protoc_plugin)
[darttutorial](https://developers.google.com/protocol-buffers/docs/darttutorial)
[dart-generated](https://developers.google.com/protocol-buffers/docs/reference/dart-generated)
```
protoc -I=$SRC_DIR --dart_out=$DST_DIR $SRC_DIR/addressbook.proto
protoc --proto_path=src --dart_out=build/gen src/foo.proto src/bar/baz.proto
protoc --proto_path=proto --dart_out=beenest/lib/class/common/model proto/api/auth/auth.proto proto/common/base_im.proto proto/common/base_channel.proto proto/api/channel/channel.proto proto/api/general/friends.proto proto/api/general/general.proto
protoc --proto_path=proto --dart_out=generate/build proto/api/auth/auth.proto proto/common/base_im.proto proto/common/base_channel.proto proto/api/channel/channel.proto proto/api/general/friends.proto proto/api/general/general.proto
```

## pub 包管理
- 如果pub缓存目录出现乱码，无法使用，可以删除缓存目录`hosts`下的文件，在Mac和Linux中，缓存目录默认是`~/.pub-cache`。在Windows中，位于`C:\Users\just_\AppData\Roaming\Pub\Cache`。可以通过设置PUB_CACHE环境变量对缓存目录进行修改。
再执行 flutter pub get 命令重新获取
- [Pub 包管理器](http://www.cndartlang.com/929.html)

## grpc 使用
[Flutter ❤ GRPC](https://medium.com/flutter-community/flutter-grpc-810f87612c6d)
[flutter-grpc-tutorial](https://github.com/amsokol/flutter-grpc-tutorial)
[grpc-dart](https://github.com/grpc/grpc-dart)

## dart bool 转换parse
[bool parse](https://stackoverflow.com/questions/21133935/in-dart-is-there-a-parse-for-bool-as-there-is-for-int)


## flutter build apk 重命名apk输出名称
```
def getDate() {
    return new Date().format('yyyyMMddHHmmss')
}

android.applicationVariants.all { variant ->
    variant.outputs.all {
        def appName = "appName";
        outputFileName = "${appName}-${variant.name}-${variant.versionName}-${getDate()}.apk"
    }
}
```
[迁移到 Android Plugin for Gradle 3.0.0](https://developer.android.google.cn/studio/build/gradle-plugin-3-0-0-migration.html)
[Gradle 提示与诀窍](https://developer.android.google.cn/studio/build/gradle-tips?hl=zh-CN#configure-multiple-apk-support)
[配置编译变体](https://developer.android.google.cn/studio/build/build-variants?hl=zh-CN)

### showModalBottomSheet setState 不生效解决方案
[解决方法](https://github.com/flutter/flutter/issues/2115)
```
 String update = '更新';

  ///选择省市
  void locationSheet() {
//    showModalBottomSheet(
//        context: context,
//        builder: (BuildContext context) {
//          return LocationPicker();
//        });

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context,state){
            return Center(
              child: FlatButton(
                  onPressed: () {
                    updated(state);
                  },
                  child: new Text('$update')),
            );
          });
        });
  }

  Future<Null> updated(StateSetter updateState) async {
    updateState(() {
      update = '更新后';
    });
  }
  /// 高度处理
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              //高度控制,增加container来控制高度
              return Container(
                height: 240,
                child: _buildSheetBody(title, list, state: setState),
              );
            },
          );
        },
      );
    });
```

### Row 要铺满整行，需要配合使用Expanded，默认是包裹子widget,同理，Column要铺满全屏，也需要配合Expanded使用，Expanded只能作用于Flex及其子类

### 在flutter widget layout 完成之后进行操作
(after_layout)[https://github.com/fluttercommunity/flutter_after_layout]
```
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }
```

### flustars 屏幕适配如果不依赖context 需要在build时
(flustars)[https://github.com/Sky24n/flustars]
```
MediaQuery.of(context);
```

### dart string toInt double to int 
```
int.parse('1');
Int64.parseInt('str');
var myDouble = double.parse('123.45');
assert(myDouble is double);
print(myDouble); // 123.45
```

### flutter_slidable 侧滑控件点击隐藏侧滑按钮
```
//How to let keep only one Slidable open?
//You have to set the controller parameter of the Slidable constructors to a SlidableController instance:
//保留一个Slidable打开
final SlidableController _slidableController = SlidableController();
...
Slidable(
      key: Key(item.title),
      controller: _slidableController,
      ...
      );
//点击事件
_slidableController.activeState = _slidableController.activeState;
```

### showModalBottomSheet 底部弹窗不受最高限制
```
showModalBottomSheet(
  context: context,
  /// 使用true则高度不受16分之9的最高限制
  isScrollControlled: true,
)
```

### socket.io不能正常工作 
[Socket.io not working on Android 9 (API level 28) ](https://stackoverflow.com/questions/53284903/socket-io-not-working-on-android-9-api-level-28?tdsourcetag=s_pcqq_aiomsg)  
Simply can be done by adding following in your manifest:
```
android:usesCleartextTraffic="true"
```

### Gradle build failed to produce an Android package. {772 行}
[Gradle build failed to produce an Android package.](https://chromium.googlesource.com/external/github.com/flutter/flutter/+/master/packages/flutter_tools/lib/src/android/gradle.dart)

### How to convert Flutter color to string and back to a color 
[颜色转换](https://stackoverflow.com/questions/49835146/how-to-convert-flutter-color-to-string-and-back-to-a-color)
```
Color color = new Color(0x12345678);
String colorString = color.toString(); // Color(0x12345678)
String valueString = colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
int value = int.parse(valueString, radix: 16);
Color otherColor = new Color(value);
```

### 隐藏键盘 
```
FocusScope.of(context).requestFocus(FocusNode());
```

### 动态添加widget
[动态添加widget](https://stackoverflow.com/questions/51605131/how-to-add-the-widgets-dynamically-to-column-in-flutter)

### 在singleChildScrollView 中添加ListView正常显示并且滚动正常
[在singleChildScrollView正常显示ListView](https://stackoverflow.com/questions/56131101/how-to-place-a-listview-inside-a-singlechildscrollview-but-prevent-them-from-scr)
```
ListView(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
),
```

### TextEditingController.clear() throws errors 
[github issue](https://github.com/flutter/flutter/issues/35909)
```
SchedulerBinding.instance.addPostFrameCallback((_) {
  focus.unfocus();
  controller.clear();
});
```

### FlatButton 不设置onPress 按钮是disable
```
  bool get enabled => onPressed != null;
```

### 拖动排序控件 ReorderableListView
- All children must have a key. 子控件要唯一
- 可以通过类型区分来构建不同的布局

### container wrap_content 使用row 或者column时用MainAxisSize.min match_parent MainAxisSize.max
row/column MainAxisSize.min which behaves as wrap_content and MainAxisSize.max which behaves as match_parent.
[linearlayout-in-flutter](https://proandroiddev.com/flutter-for-android-developers-how-to-design-linearlayout-in-flutter-5d819c0ddf1a)

### 状态管理 Provider bloc scoped_model
- [provider](https://github.com/rrousselGit/provider) [掘金博客](https://juejin.im/post/5d00a84fe51d455a2f22023f#heading-21)
- [bloc](https://github.com/felangel/bloc)[掘金博客](https://juejin.im/post/5bb6f344f265da0aa664d68a)
- [scoped_model](https://github.com/brianegan/scoped_model) `最新版本是2018年11月29日发布`[掘金博客](https://juejin.im/post/5b97fa0d5188255c5546dcf8)

### markdown 支持
- [flutter_markdown](https://github.com/flutter/flutter_markdown)
- [offical_markdown](https://github.com/dart-lang/markdown)

### websocket 通信,长连接
- [socket 长连接](http://www.52im.net/forum.php?mod=viewthread&tid=1722&highlight=%B3%A4%C1%AC%BD%D3)

### flutter lifecycle 对应 Android onResume
```
widget with WidgetsBindingObserver

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
    // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      // came back to Foreground
    }
  }
```

### flutter 粘贴板
```
import 'package:flutter/services.dart';
// 设置粘贴板数据
Clipboard.setData(ClipboardData(text: 'dc123456'));
// 获取粘贴板数据
ClipboardData clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
String str = clipboardData.text;
```

### 聊天界面
- [CSDN demo](https://blog.csdn.net/hekaiyou/article/details/78011843)
- [flutter-chat-demo](https://github.com/duytq94/flutter-chat-demo)
- [flutter-chat-app](https://github.com/rohan20/flutter-chat-app)

### 阿里云 OSS服务
-[aliyun-android-sdk](https://github.com/aliyun/aliyun-oss-android-sdk)

### shareSDK 
* [传送门](https://github.com/MobClub/ShareSDK-For-Flutter)
* [官方文档](http://wiki.mob.com/sharesdk-for-flutter/)
* 下载github源码，直接导入flutter工程。不要使用在线package方式接入，接入步骤以官方文档为主。
* Android，iOS的接入部分需要按照原生接入方式进行配置。
* Android 主要包括配置android/build.gradle 增加android/MobSDK.gradle，混淆文件
```
# sharesdk start
-keep class cn.sharesdk.**{*;}
-keep class com.sina.**{*;}
-keep class **.R$* {*;}
-keep class **.R{*;}
-keep class com.mob.**{*;}
-keep class m.framework.**{*;}
-dontwarn cn.sharesdk.**
-dontwarn com.sina.**
-dontwarn com.mob.**
-dontwarn **.R$*
# sharesdk end
```
* AndroidManifest.xml
```
    <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="@string/app_name"
        android:icon="@mipmap/ic_launcher"
        tools:replace="android:name">
```
## flutter 判断是否联网，获取网络类型
connectivity
[Homepage](https://github.com/flutter/plugins/tree/master/packages/connectivity)

## TextField  多行输入配置
```
TextField(
  controller: textEditingController ?? TextEditingController(),
  maxLines: 4,// 设置多行
  minLines: 1,// 必须设置，不然会变成多行显示
  maxLength: 2000,
  focusNode: focusNode,
  onSubmitted: (value) {
    Utils.debug("onSubmitted -------------------> $value");
    onSubmitted(value);
    textEditingController.text = "";
  },
  style: TextStyle(
    fontSize: Macros.scale(16),
    color: Colours.text_black_333,
    fontWeight: FontWeight.w500,
  ),
  cursorColor: Colours.brand_yellow,
  textInputAction: TextInputAction.send,//设置action，必须设置keyboardType，按钮的操作不是发送，而是换行
  keyboardType: TextInputType.text,//
  decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.symmetric(vertical: Dimens.gap_dp16),
    hintText: "请输入......",
    counterText: "",
    hintStyle: TextStyle(
        fontSize: Macros.scale(16), color: Colours.text_gray_b1),
  ),
);
```
## dart
[language-tour](https://dart.cn/guides/language/language-tour)

## emoji 表情自定义删除
```
  String text = textEditingController.text;
  var result = text.substring(0, text.length - 1);
  if (result.isNotEmpty) {
    List<int> bytes = utf8.encode(text.substring(text.length - 1));
    if (bytes.length == 3 && bytes[0] == 237) {
      // bytes[0] 为表情编码之后的byte
      result = result.substring(0, result.length - 1);
    }
  }
```

## flutter 相册Api
[flutter_photo_manager](https://github.com/CaiJingLong/flutter_photo_manager)
[flutter_photo](https://github.com/CaiJingLong/flutter_photo)

## flutter 迁移AndroidX
[迁移AndroidX](https://caijinglong.gitbooks.io/migrate-flutter-to-androidx/content/zhong-wen.html)

## 图片自定义选择可以借鉴flutter_photo代码实现

## listview 滚动到指定位置通过index
[scroll-to-index](https://github.com/quire-io/scroll-to-index)
[issues#12319](https://github.com/flutter/flutter/issues/12319)


## Dart 数据集中操作item 
Dart报错"Concurrent modification during iteration: Instance(length:3) of '_GrowableList'."
```
// Dart提供了removeWhere
List list = [1, 2, 3, 4];
 
// 这里使用了箭头函数，后面的表达式为true时会删除当前值
list.removeWhere((value) => value == 2); 
// 当然也能用{}
list.removeWhere((value) {
    retrun value == 2;
});
```

## utility libraries 
[dart 工具](https://github.com/google/quiver-dart)

## flutter orm 数据库
[ROM数据库使用](https://juejin.im/post/5da6d64a6fb9a04e1325e935)
[package](https://pub.flutter-io.cn/packages/flutter_orm_plugin)

## flutter 下载文件
[flutter_downloade](https://github.com/fluttercommunity/flutter_downloader)

## flutter 打开文件
[open_file](https://github.com/crazecoder/open_file)

## android studio Cannot find runner for main.dart
需要重新配置flutter SDK。配置路径（File->Settings->Languages&Frameworks->Flutter->Flutter SDK path）

## flutter listview build type 'Future<dynamic>' is not a subtype of type 'Widget'
* listview item build 包含Future获取数据
* https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html

## flutter 升级1.12.13 版本异常
**依赖库有异常：** 
1. crypto 需要升级至 2.1.3
2. cached_network_image ^2.0.0-rc
3. multi_image_picker 4.5.9会有异常信息，方法出现无法调用，如果升级到4.6.0则不会返回filePath
`I can't get filePath after upgrade from 4.5.7 to 4.6.0
https://github.com/Sh1d0w/multi_image_picker/issues/337#issuecomment-563581173
`

## 配置环境，环境加载不同配置
[Flutter 实现根据环境加载不同配置](https://www.yuanxuxu.com/2018/09/13/flutter-load-config-by-env/)
**打包命令**
```
flutter build apk -t lib/main_dev.dart
flutter build apk -t lib/main_test.dart
flutter build apk -t lib/main.dart
```


## textField 增加上下左右边距
```
decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: Dimens.gap_dp16),
),
```

## ScrollView 嵌套 ListView 
[Flutter : ListView, GridView inside ScrollView](https://medium.com/flutterpub/flutter-listview-gridview-inside-scrollview-68b722ae89d4)
```
/// CustomScrollView(
///   shrinkWrap: true,
///   slivers: <Widget>[
///     SliverPadding(
///       padding: const EdgeInsets.all(20.0),
///       sliver: SliverList(
///         delegate: SliverChildListDelegate(
///           <Widget>[
///             const Text('I\'m dedicating every day to you'),
///             const Text('Domestic life was never quite my style'),
///             const Text('When you smile, you knock me out, I fall apart'),
///             const Text('And I thought I was so smart'),
///           ],
///         ),
///       ),
///     ),
///   ],
/// )
```

## Flutter 防止高频操作(防抖)
* rxdart 
```dart
final _behaviorSubject = BehaviorSubject<String>();
@override
  void initState() {
    super.initState();
    _behaviorSubject.debounceTime(Duration(seconds: 1)).listen((String data){
      _handleData();
    });
  }
RaisedButton(
  onPressed: () {
    _behaviorSubject.add("");
  },
  child: Text('Test'),
)
```
* timer
```
import 'dart:async';
 
Function debounce(Function fn, [int t = 30]) {
  Timer _debounce;
  return () {
    // 还在时间之内，抛弃上一次
    if (_debounce?.isActive ?? false) _debounce.cancel();
 
    _debounce = Timer(Duration(milliseconds: t), () {
      fn();
    });
  };
}
 
RaisedButton(
      onPressed: debounce(() {
          print(1);
     }, 3000),
    child: Text('Test'),

```

## flutter 切换channel
[官方示例](https://flutter.cn/docs/development/tools/sdk/upgrading)
```
$ flutter channel
Flutter channels:
* stable
  beta
  dev
  master
```

To switch channels, run `flutter channel [<channel-name>]`, and then run `flutter upgrade` to ensure you're on the latest.
切换到指定版本
```
flutter version v1.9.1+hotfix.3
```

## flutter TextField 限制输入
```dart
TextField(
  inputFormatters: [
    WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9]")),
    LengthLimitingTextInputFormatter(30),
  ],
)
```

## flutter Textfield onfocus 监听
```dart
  FocusNode _myFocusNode = FocusNode();
  _myFocusNode.addListener((){
    _isEdit = true;
    setState(() {  
    });
  });
```

## dialog dismiss 回调 （How run code after showDialog is dismissed in Flutter?）
```dart
await showDialog(
       //Your Dialog Code
).then((val){
  /// 窗口隐藏的操作
    Navigator.pop(_context);
});
```

## 网络接口请求返回错误码进行处理 使用eventbus来进行数据传递
[传送门](https://github.com/flutterchina/dio/issues/105)

## Textfield 光标和文本显示不居中处理
[传送门](https://github.com/flutter/flutter/issues/40248)
```dart
ThemeData(
    textTheme: TextTheme(subhead: TextStyle(textBaseline: TextBaseline.alphabetic)),
/// or
TextField > style > textBaseline: TextBaseline.alphabetic
```

https://github.com/flutter/flutter/issues/20761#issuecomment-493434578

https://github.com/flutter/plugins/tree/master/packages/package_info


## textField maxLength 设置不显示 计数标示
```dart
TextField(
  obscureText: false,
  maxLength: widget.maxLength,
  keyboardType: TextInputType.text,
  controller: _controller,
  focusNode: _focusNode,
  cursorColor: Colours.brand_yellow,
  style: TextStyle(
    fontSize: Macros.scale(15),
  ),
  decoration: InputDecoration(
    hintText: _hint,
    border: InputBorder.none, //去掉下划线
    hintStyle: TextStyle(
      color: Colours.text_gray_cf,
      fontSize: Macros.scale(15),
    ),
    counterText: "",//不显示计数（0/maxLength）
  ),
  inputFormatters: widget.inputFormatters == null
      ? <TextInputFormatter>[]
      : widget.inputFormatters,
),
```

## 屏幕唤醒
* [传送门](https://pub.flutter-io.cn/packages/wakelock)

## 退出应用
SystemNavigator.pop();
exit(0); //会有黑屏

## audioplayers 
[传送门](https://pub.flutter-io.cn/packages/audioplayers)
* Unhandled Exception: MissingPluginException #216
* flutter clean & flutter pub get

``` java
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.view.KeyEvent;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
	//通讯名称,回到手机桌面
	private  final String CHANNEL = "android/back/desktop";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		GeneratedPluginRegistrant.registerWith(this);
		new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
			new MethodChannel.MethodCallHandler() {
				@Override
				public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
					if (methodCall.method.equals("backDesktop")) {
						result.success(true);
						moveTaskToBack(false);
					} 
				}
			}
		);
	}
}
```

``` dart
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AndroidBackTop {
	//初始化通信管道-设置退出到手机桌面
	static const String CHANNEL = "android/back/desktop";
	//设置回退到手机桌面
	static Future<bool> backDeskTop() async {
		final platform = MethodChannel(CHANNEL);
		//通知安卓返回,到手机桌面
		try {
			final bool out = await platform.invokeMethod('backDesktop');
			if (out) debugPrint('返回到桌面');
		} on PlatformException catch (e) {
			debugPrint("通信失败(设置回退到安卓手机桌面:设置失败)");
			print(e.toString());
		}
		return Future.value(false);
	}
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<ConfigModel>(
      builder: (context, child, configModel) {
        return MaterialApp(
			title: 'test',
			debugShowCheckedModeBanner: false,
			home: WillPopScope(
				onWillPop: () async {
					AndroidBackTop.backDeskTop();  //设置为返回不退出app
					return false;  //一定要return false
				},
				child: Text("Test"),
			),
        );
      },
    );
  }
}
```

### cocoapods 卸载，安装
[传送门](https://www.jianshu.com/p/f43b5964f582)

### 解决包依赖冲突
[传送门](https://blog.csdn.net/mqdxiaoxiao/article/details/102522868)

### textfield controller 资源回收
[传送门](https://flutter.cn/docs/cookbook/forms/text-field-changes)

### Error connecting to the service protocol: failed to connect to http://127.0.0.1:1029/89AGRYqn_pA=/ 
[传送门](https://github.com/flutter/flutter/issues/48234)
[传送门](https://github.com/flutter/flutter/issues/47204)
I was having this issue. I uninstalled the app from my device, opened the project in xcode, ran some build cleaning thing that appeared in the yellow triangle warning area, then built the app via xcode. Then uninstalled the app from device again. Then ran via android studio and it worked.
我有这个问题。 我从设备上卸载了该应用程序，在xcode中打开了该项目，运行了一些显示在黄色三角形警告区域中的构建清理程序，然后通过xcode构建了该应用程序。 然后再次从设备上卸载该应用。 然后通过android studio运行，它起作用了。

### 集成MobSDK push 自定义application
Can't load Kernel binary: Invalid kernel binary: Indicated size is invalid.
FlutterMain.startInitialization(this);
MobSDK.init(this);


### Flutter BackdropFilter 实现高斯模糊
如果不指定宽高 布局是全屏
需要使用ClipRect嵌套
```dart
Stack(
  fit: StackFit.expand,
  children: <Widget>[
    Text('0' * 10000),
    Center(
      child: ClipRect(  // <-- clips to the 200x200 [Container] below
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            alignment: Alignment.center,
            width: 200.0,
            height: 200.0,
            child: Text('Hello World'),
          ),
        ),
      ),
    ),
  ],
)
```

### mob 

### Dart List min/max value
list 不能为空
```dart 
import 'dart:math';

main(){
  print([1,2,8,6].reduce(max)); // 8
  print([1,2,8,6].reduce(min)); // 1
}
```

### 文本字符显示 https://pub.flutter-io.cn/packagesassorted_layout_widgets
单行字符显示
assorted_layout_widgets: ^1.0.18

### pod 安装失败
flutter clean
rm -Rf ios/Pods
rm -Rf ios/.symlinks
rm -Rf ios/Flutter/Flutter.framework
rm -Rf ios/Flutter/Flutter.podspec

### Bottom sheet with configurable height
底部弹窗设置自定义高度
https://github.com/flutter/flutter/issues/32747
```dart
isScrollControlled: true,
```

### Error connecting to the service protocol: failed to connect to http://127.0.0.1:1024/fu9GVzdywXU=/
killall iproxy
执行 /Users/zhangmingming/development/flutter/bin/cache/artifacts/usbmuxd/iproxy
export NO_PROXY=127.0.0.1,localhost

### 
https://juejin.im/post/5b5f00e7e51d45190571172f
flutter packages pub run build_runner build

### main 初始化数据
2020-04-16 12:09:24.201589+0800 Runner[15975:2019351] [VERBOSE-2:ui_dart_state.cc(157)] Unhandled Exception: ServicesBinding.defaultBinaryMessenger was accessed before the binding was initialized.
If you're running an application and need to access the binary messenger before `runApp()` has been called (for example, during plugin initialization), then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
If you're running a test, you can call the `TestWidgetsFlutterBinding.ensureInitialized()` as the first line in your test's `main()` method to initialize the binding.
#0      defaultBinaryMessenger.<anonymous closure> (package:flutter/src/services/binary_messenger.dart:76:7)
#1      defaultBinaryMessenger (package:flutter/src/services/binary_messenger.dart:89:4)
#2      PlatformAssetBundle.load (package:flutter/src/services/asset_bundle.dart:219:15)
#3      SimpleImageCache.load (package:bee_nest/res/simple_image_cache.dart:27:42)
#4      main (package:bee_nest/main_dev.dart:49:35)
#5      _AsyncAwaitCompleter.start (dart:async-patch/async_patch.dart:45:6)
#6      main (package:bee_nest/main_dev.dart:44:18)
#7      _runMainZoned.<anonymous closure>.<anonymous closure> (dart:ui/hooks.dart:239:25)
#8      _rootRun (dart:async/zone.dart:1126:13)
#9      _CustomZone.run (dart:async/zone.dart:1023:19)
#10     _runZoned (dart:async/zone.dart:1518:10)
#11     runZoned (dart:async/zone.dart:1502:12)
#12     _runMainZoned.<anonymous closure> (dart:ui/hooks.dart:231:5)
#13     _startIsolate.<anonymous closure> (dart:isolate-patch/isolate_patch.dart:307:19)
#14     _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:174:12)

### dart protobuf 处理
如果是要给对象赋值操作，需要进行clone之后再进行处理，不然会出现readonly

### [App.framework] Linked and embedded framework 'App.framework' was built for iOS/iOS Simulator
[传送门](https://github.com/flutter/flutter/issues/50568)
```
rm -rf ios/Flutter/App.framework
```
