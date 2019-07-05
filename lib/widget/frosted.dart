import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

///
///使用BackdropFilter实现毛玻璃效果,且子部件需要设置Opacity
///使用这个部件的代价很高，尽量少用
///ImageFilter.blur的sigmaX/Y决定了毛玻璃的模糊程度，值越高越模糊
///一般来说，为了防止模糊效果绘制出边界，需要使用ClipRect Widget包裹
///
class Frosted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //获取屏幕宽高
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: FlutterLogo(),
          ),
          Center(
            child: ClipRect(
              child: ClipRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Opacity(
                        opacity: 0.5,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(30),
                          height: 400,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
//                  color: Colors.grey.shade200.withOpacity(0.5),
                            color: Colors.grey.shade200,
                          ),
                          child: getText(),
//                          child: new Center(
//                            child: new Text('Frosted',
//                                style: Theme.of(context).textTheme.display3),
//                          ),
//                          child: Center(
//                            child: Text("FrostedFrostedFrostedFrostedFrostedFrosted",
//                                textAlign: TextAlign.center,
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                style: TextStyle(fontSize: 30.0, color: Colors.orangeAccent),
//                              ),
//                          )
                        ),
                      ))),
            ),
          )
        ],
      ),
    );
  }

  Center getText() {
    return Center(
      //增加点击事件
      child: GestureDetector(
        onTap: () {
          showToast("onTap", radius: 0);
        },
        child: Text(
          "FrostedFrostedFrostedFrostedFrostedFrosted",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 30.0, color: Colors.orangeAccent),
        ),
      ),
    );
  }
}
