import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/services.dart';

class ProgressIndicatorRoute extends StatefulWidget {
  @override
  ProgressIndicatorRouteState createState() {
    return new ProgressIndicatorRouteState();
  }
}

class ProgressIndicatorRouteState extends State<ProgressIndicatorRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  String _batteryLevel = "Battery Level";

  static const getBatteryPlugin = const MethodChannel("flutter.plugin/battery");

  Future<void> _getBatteryLevel() async {
    String batteryLever;
    try {
      final int result = await getBatteryPlugin.invokeMethod("getBatteryLevel");
      batteryLever = "Battery Level at $result";
    } on PlatformException catch (e) {
      batteryLever = "Failed to get battery level ${e.message}";
    }
    setState(() {
      _batteryLevel = batteryLever;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      reverseCurve: Curves.fastOutSlowIn,
      curve: const Interval(0, 0.9, curve: Curves.fastOutSlowIn),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        } else if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
      } else {
        switch (_controller.status) {
          case AnimationStatus.forward:
          case AnimationStatus.dismissed:
            _controller.forward();
            break;
          case AnimationStatus.completed:
          case AnimationStatus.reverse:
            _controller.reverse();
            break;
        }
      }
    });
  }

  Widget _buildIndicators(BuildContext context, Widget child) {
    final List<Widget> indicators = <Widget>[
      const SizedBox(
        width: 200,
        child: LinearProgressIndicator(),
      ),
      const LinearProgressIndicator(),
      const LinearProgressIndicator(),
      LinearProgressIndicator(
        value: _animation.value,
      ),
      Text(_batteryLevel, style: TextStyle(color: Colors.red, fontSize: 18),),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const CircularProgressIndicator(
            strokeWidth: 1,
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              value: _animation.value,
            ),
          ),
          SizedBox(
            width: 100,
            height: 20,
            child: Text(
              '${(_animation.value * 100).toStringAsFixed(1)}%',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    ];
    return Column(
      children: indicators.map<Widget>((Widget w) {
        return Container(
          child: w,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Progress Indicator',
          style: TextStyle(color: Colors.black,),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                showToast('edit', radius: 0);
                _getBatteryLevel();
              },
              child: Icon(
                Icons.edit,
                color: Colors.black,
              ),
            )
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: DefaultTextStyle(
              style: Theme.of(context).textTheme.title,
              child: GestureDetector(
                onTap: _handleTap,
                behavior: HitTestBehavior.opaque,
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: _buildIndicators,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
