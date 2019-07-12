import 'package:flutter/cupertino.dart';

/// cupertino switch
class CupertinoSwitchRoute extends StatefulWidget {
  @override
  CupertinoSwitchRouteState createState() {
    return new CupertinoSwitchRouteState();
  }
}

class CupertinoSwitchRouteState extends State<CupertinoSwitchRoute> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Cupertino Switch'),
      ),
      child: DefaultTextStyle(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Semantics(
                    container: true,
                    child: Column(
                      children: <Widget>[
                        CupertinoSwitch(
                            value: _switchValue,
                            onChanged: (bool value) {
                              setState(() {
                                _switchValue = value;
                              });
                            }),
                        Text('Enable - ${_switchValue ? "on" : "off"}'),
                      ],
                    ),
                  ),
                  Semantics(
                    container: true,
                    child: Column(
                      children: <Widget>[
                        CupertinoSwitch(
                          value: true,
                          onChanged: null,
                        ),
                        Text('Disable - On'),
                      ],
                    ),
                  ),
                  Semantics(
                    container: true,
                    child: Column(
                      children: <Widget>[
                        CupertinoSwitch(
                          value: false,
                          onChanged: null,
                        ),
                        Text('Disable - off'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}