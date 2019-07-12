import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'cupertino_switch.dart';

class CupertinoTextFieldRoute extends StatefulWidget {
  static const String routeName = '/cupertino/text_fields';

  @override
  State<StatefulWidget> createState() {
    return new CupertinoTextFieldRouteState();
  }
}

class CupertinoTextFieldRouteState extends State<CupertinoTextFieldRoute> {
  TextEditingController _chatTextController;
  TextEditingController _locationTextController;

  @override
  void initState() {
    super.initState();
    _chatTextController = TextEditingController();
    _locationTextController = TextEditingController(text: '天河，棠下');
  }

  Widget _buildChatTextField() {
    return CupertinoTextField(
      controller: _chatTextController,
      textCapitalization: TextCapitalization.sentences,
      placeholder: '消息',
      decoration: BoxDecoration(
          border: Border.all(width: 0, color: CupertinoColors.inactiveGray),
          borderRadius: BorderRadius.circular(15)),
      maxLines: null,
      keyboardType: TextInputType.multiline,
      prefix: const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
      suffix: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: CupertinoButton(
          color: CupertinoColors.activeGreen,
          minSize: 0,
          child: const Icon(
            CupertinoIcons.up_arrow,
            size: 21,
            color: CupertinoColors.white,
          ),
          padding: const EdgeInsets.all(2),
          borderRadius: BorderRadius.circular(15),
          onPressed: () {
            setState(() {
              showToast(_chatTextController.text);
              _chatTextController.clear();
              Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context){
                return new CupertinoSwitchRoute();
              }));
            });
          },
        ),
      ),
      autofocus: true,
      suffixMode: OverlayVisibilityMode.editing,
      onSubmitted: (String text) {
        setState(() {
          _chatTextController.clear();
          showToast(text);
        });
      },
    );
  }

  Widget _buildNameField() {
    return const CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      clearButtonMode: OverlayVisibilityMode.editing,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(width: 0, color: CupertinoColors.inactiveGray)),
      ),
      placeholder: 'Name',
    );
  }

  Widget _buildEmailField() {
    return const CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0, color: CupertinoColors.inactiveGray),
        ),
      ),
      placeholder: 'Email',
    );
  }

  Widget _buildLocationField() {
    return CupertinoTextField(
      controller: _locationTextController,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
    );
  }

  Widget _buildPinField() {
    return CupertinoTextField(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.number,
      autocorrect: false,
      obscureText: true,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0,
            color: CupertinoColors.inactiveGray
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 17,
        color: CupertinoColors.black,
      ),
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
//          previousPageTitle: 'Cupertino',
          middle: Text('Text Fields'),
        ),
        child: CupertinoScrollbar(
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Column(
                  children: <Widget>[
                    _buildNameField(),
                    _buildEmailField(),
                    _buildLocationField(),
                    _buildPinField(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: _buildChatTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
