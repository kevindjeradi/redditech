import 'package:flutter/material.dart';
import 'package:redditech/routes/routes.dart' as route;
import 'package:redditech/themes/themedata.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'REDDITECH',
      theme: themedata,
      onGenerateRoute: route.controller,
      initialRoute: route.loginPage,
    );
  }
}
