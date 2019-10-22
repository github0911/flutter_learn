
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class TimerView extends StatefulWidget {
  final int expiredTime;

  /// 现在的时间（秒）
  final int nowTime;

  const TimerView({
    Key key,
    this.nowTime,
    this.expiredTime,
  }) : super(key: key);

  @override
  _TimerViewState createState() {
    return _TimerViewState();
  }
}

class _TimerViewState extends State<TimerView> {
  var timerCountDown = '';
  TimerUtil countDown;

  @override
  void initState() {
    // https://fluttertutorial.in/flutter-listview-timer-update-every-second/
    var times = widget.expiredTime - widget.nowTime;
    timerCountDown = secondsToHoursMinutesSeconds(times);
    _countDown(times);
    super.initState();
  }

  void _countDown(int times) {
    countDown = TimerUtil(mInterval: 1000, mTotalTime: (times * 1000).toInt());
    countDown.setOnTimerTickCallback((int value) {
      int tick = value ~/ 1000;
      setState(() {
        if (tick > 0) {
          timerCountDown = secondsToHoursMinutesSeconds(tick);
        } else {
          timerCountDown = "已过期";
        }
      });
    });
    countDown.startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      timerCountDown,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),
    );
  }

  String secondsToHoursMinutesSeconds(int seconds) {
    var hour = seconds ~/ 3600;
    var minute = (seconds % 3600) ~/ 60;
    var second = (seconds % 3600) % 60;
    final hourUpdate = hour < 10 ? '0$hour' : '$hour';
    final minuteUpdate = minute < 10 ? '0$minute' : '$minute';
    final secondUpdate = second < 10 ? '0$second' : '$second';
    return hourUpdate + ':' + minuteUpdate + ':' + secondUpdate;
  }

  @override
  void dispose() {
    super.dispose();
    countDown?.cancel();
  }
}
