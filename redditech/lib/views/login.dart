import 'package:flutter/material.dart';
import 'package:redditech/routes/routes.dart' as route;
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:redditech/components/custombutton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:redditech/views/reddit_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        color: CustomColors.greyDarken3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 150, 50, 30),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: Column(children: [
                  Text(
                    "Bienvenue sur Redditech",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Connectez-vous pour continuer.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ]),
              ),
              // TEST BTN GENERIC
              CustomButton(
                  icon: FontAwesomeIcons.reddit,
                  text: "Log in with Reddit",
                  function: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RedditAuth(
                                title: "ni",
                              ))),
                  color: ButtonColor.blue),
            ],
          ),
        ),
      )),
    );
  }
}
