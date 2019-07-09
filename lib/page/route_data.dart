import 'package:flutter/material.dart';

/// 路由跳转
class NavigationApp extends StatelessWidget {

  Route<dynamic> _parseRoute(RouteSettings settings) {
    final List<String> path = settings.name.split("/");
    assert(path[0] == '');
    print(path);
    if (path[1] == 'second' && path.length == 3) {
      final value = double.parse(path[2]);
      return MaterialPageRoute<double>(
        settings: settings,
        builder: (BuildContext context) => new SecondScreenWidget(value: value),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navigation Example",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreenWidget(),
      onGenerateRoute: _parseRoute,
    );
  }
}

class FirstScreenWidget extends StatefulWidget {
  @override
  FirstScreenState createState() => new FirstScreenState();
}

class FirstScreenState extends State<FirstScreenWidget> {
  var _value = 50.0;

  //方法描述 async 在后面
  _navigationUsingConstructor() async {
    _value = await Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new SecondScreenWidget(value: _value))) ?? 1.0;
  }

  _navigationUsingRoute() async {
    _value = await Navigator.of(context).pushNamed('/second/$_value') ?? 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text("First Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slider(
              min: 1,
              max: 100,
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: const Text("Pass via constructor"),
                  onPressed: () {
                    _navigationUsingConstructor();
                  },
                ),
                RaisedButton(
                  child: const Text('Pass via route'),
                  onPressed: () {
                    _navigationUsingRoute();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreenWidget extends StatefulWidget {
  final double value;

  SecondScreenWidget({this.value: 1.0});

  @override
  SecondScreenState createState() => new SecondScreenState(value);
}

class SecondScreenState extends State<SecondScreenWidget> {
  double _value;

  SecondScreenState(this._value);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slider(
              min: 1,
              max: 100,
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
            RaisedButton(
              child: const Text('Retrun to first'),
              onPressed: () {
                Navigator.of(context).pop(_value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
