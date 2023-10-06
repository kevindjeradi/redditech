import 'package:flutter/material.dart';
import 'package:redditech/themes/customcolors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Container(
              color: CustomColors.greyDarken3,
              padding: const EdgeInsets.all(15),
              width: deviceWidth,
              height: deviceHeight,
              child: const Text("SETTINGS"))),
    );
  }
}
