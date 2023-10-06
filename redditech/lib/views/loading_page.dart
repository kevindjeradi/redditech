import 'package:loading_animations/loading_animations.dart';
import 'package:flutter/material.dart';
import 'package:redditech/themes/customcolors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TabBarView(
        children: <Widget>[
          LoadingBouncingGrid.square(
            borderSize: 3.0,
            backgroundColor: CustomColors.attentionMessage,
          ),
        ],
      ),
    );
  }
}
