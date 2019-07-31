import 'dart:async';
import 'package:rxdart/rxdart.dart';

void main() {
  print("hello, world");

  var stream = Stream.fromIterable([1, 2, 3]);

  stream.takeWhile(test).listen((data) {
    print(data);
  });

//  stream.take(2).listen((data){
//    print(data);
//  });

  StreamController controller = StreamController();

  //监听这个流的出口，当有data流出时，打印这个data
  var num = 0;
  StreamSubscription subscription = controller.stream.listen((data) {
    if (data is int) {
      print("$data");
      num += data;
    } else {
      data();
      print(num);
    }
  });
//  subscription.onData(handleData);
//  subscription.onDone((){
//    print("onDone");
//  });
//  subscription.onError(handleError);
  controller.sink.add(123);
  controller.sink.add(456);
  controller.sink.add(789);
  controller.sink.add(handleError);
  controller.close();
  bool tag = controller.isClosed;
  print("close $tag" );

  StreamController<int> controller2 = StreamController<int>();

  final transformer =
      StreamTransformer<int, String>.fromHandlers(handleData: (value, sink) {
    if (value == 100) {
      sink.add("你猜对了");
    } else {
      sink.addError('还没猜中，再试一次吧');
      controller2.close();
    }
  });

  controller2.stream
      .transform(transformer)
      .listen((data) => print(data), onError: (err) => print(err));

  controller2.sink.add(23);
  controller2.close();

  StreamController controller3 = StreamController();
  Stream stream3 = controller3.stream.asBroadcastStream(
      onListen: (StreamSubscription subscription) {
    print(subscription);
  }, onCancel: (StreamSubscription subscription) {
    print("onCancel");
  });
  stream3.listen((data) {
    print(data);
  });
  stream3.listen((data) {
    print(data);
  });
  controller3.sink.add(987);
  controller3.close();

  // 初始化一个单订阅的Stream controller
  final StreamController ctrl = StreamController();

  // 初始化一个监听
  final StreamSubscription subscription2 =
      ctrl.stream.listen((data) => print('$data'));

  // 往Stream中添加数据
  ctrl.sink.add('my name');
  ctrl.sink.add(1234);
  ctrl.sink.add({'a': 'element A', 'b': 'element B'});
  ctrl.sink.add(123.45);
  ctrl.close();

  // rxDart
  Observable.fromIterable([11, 22]).listen((data) {
    print(data);
  });

  TimerStream("hi", new Duration(seconds: 1))
      .listen((i) => print(i)); // print "hi" after 1 minute
}

void handleData(data) {
  print("handleData $data");
}

handleError() {
  print("handleError");
}

void onData(event) {}

bool test(int event) {
  return event == 1;
}
