## [Windows 安装flutter]("https://flutterchina.club/setup-windows/")

### 使用外部包的操作流程：

编辑pubspec.yaml 在dependencies中加入所需要引入的package  
pubspec文件管理Flutter应用程序的assets(资源，如图片、package等)。  
在Android Studio的编辑器视图中查看pubspec时，单击右上角的 Packages get，这会将依赖包安装到您的项目。（类似gradle sync）
* 1、Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
* 2、Stateful widgets 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
    一个 StatefulWidget类。
    一个 State类。 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在.

提示: 在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新  
提示: 某些widget属性需要单个widget（child），而其它一些属性，如action，需要一组widgets(children），用方括号[]表示。  
### [语法]("https://www.jianshu.com/p/3d927a7bf020")
Flutter所使用的Dart语言，没有类似Java的publice protect private，以_开头的变量、函数和类，意味着它仅在库中是可视的  
在Dart中，当你不需要去改变一个变量的时候，应该使用final或者const，而不是使用var去声明一个变量。  
一个final变量只允许被赋值一次，必须在定义时或者构造函数参数表中将其初始化。  
const所修饰的是编译时常量，我们在编译时就已经知道了它的值，它的值是不可改变的。  
dart 中类 implements 不需要重写父类的构造方法  
Dart 语言并没有提供 interface 关键字，但是每一个类都隐式地定义了一个接口。

**如何更新 Widget**
在 Android 中，你可以直接操作更新 View。然而在 Flutter 中，Widget 是不可变的， 无法被直接更新，你需要操作 Widget 的状态。  
这就是有状态 (Stateful) 和无状态 (Stateless) Widget 概念的来源。  
这里需要着重注意的是，无状态和有状态的 Widget 本质上是行为一致的。它们每一帧都会重建，不同之处 在于 StatefulWidget 有一个跨帧存储和恢复状态数据的 State 对象。
如果一个 Widget 会变化（例如由于用户交互），它是有状态的。 然而，如果一个 Widget 响应变化，它的父 Widget 只要本身不响应变化，就依然是无状态的。 

**在函数式编程中，你可以做到：**
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
1. 在 Material Design 里，所有的界面，组件都有自己的标高值；
2. 在不同标高表面的边缘会有分割线来区别他们谁更"高"；
3. 不同表面之间的高度差可以使用暗淡的背景，增亮的背景或阴影来表示；
4. 标高较高的表面往往意味着内容也相对较为重要。

除 FlatButton 和 RaisedButton 之外，还有 OutlineButton ， FloatingActionButton ， IconButton ，等等。

**控件说明**  
Column 一个children属性，包含多个子项。垂直控件多个，但是不能滚动
ListView 一个children属性，包含多个子项。垂直控件多个，可以滚动
Row 水平控件多个
Align,Center,Container 只能存放一个控件

**本地图片加载配置与实现**  
在pubspec.yaml 文件中flutter: 节点增加  
    
    flutter: 
      assets:
      # 这样是assets目录下所有文件
      # 如果是assets/ic_launcher.png 指定某个文件
        - assets/
    
**嵌套行和列**  
为了最大限度地减少高度嵌套的布局代码可能导致的视觉混乱，可以在变量和函数中实现 UI 的各个部分。  

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

[oktoast]("https://www.kikt.top/posts/flutter/toast/oktoast/#%E6%96%87%E6%9C%AC-toast")  
[oktoast接入官方示例]("https://pub.dev/packages/oktoast#-example-tab-")  
默认圆角为10，显示时长为2.3s。

[Notebook]("https://github.com/OpenFlutter/Flutter-Notebook")  
[Flutter快速上车之Widget]("https://www.yuque.com/xytech/flutter/hc0xq7")  
[Flutter入门总结]("https://www.yuque.com/chenshier/chuyi/wtoyoq#43c760ef")