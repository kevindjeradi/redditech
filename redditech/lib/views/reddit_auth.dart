import 'dart:developer';
import 'package:redditech/routes/routes.dart' as route;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:redditech/user.ini';
// import 'dart:convert';
// import '../Render/BottomBarRender.dart';
// import 'package:dio/dio.dart';

class RedditAuth extends StatefulWidget {
  const RedditAuth({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RedditAuth createState() => _RedditAuth();
}

class _RedditAuth extends State<RedditAuth> {
  // void postCode(code) async {
  //   final id = base64.encode(utf8.encode(client_id + ':'));
  //   final response = await Dio().post(
  //       'https://www.reddit.com/api/v1/access_token',
  //       options: Options(headers: <String, dynamic>{
  //         'authorization': 'Basic $id',
  //         'content-type': "application/x-www-form-urlencoded"
  //       }),
  //       data:
  //           'grant_type=authorization_code&code=$code&redirect_uri=$redirect_url');
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => MyBottomBar(
  //             accessToken: response.data['access_token'],
  //             refreshToken: response.data['refresh_token'])),
  //   );
  // }

  Widget build(BuildContext context) {
    const String clientID = "B3lXVE56PcfUresmE4e4tw";
    const String state = "somestatezdfzdf";
    const String redirect = "http://localhost";
    const String scope =
        "identity,account,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread";
    return Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            "https://www.reddit.com/api/v1/authorize.compact?client_id=$clientID&response_type=code&state=$state&redirect_uri=$redirect&duration=permanent&scope=$scope",
        onPageFinished: (url) {
          if (url.startsWith("http://localhost")) {
            Api.login(url.split("code=")[1].split("#")[0]).then((value) {
              if (value) {
                Navigator.pushNamed(context, route.navigationMenu);
                log(Api.accessToken);
              } else {
                Navigator.pushNamed(context, route.loginPage);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("An error has occured.")));
              }
            });
          }
        },
      ),
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: CustomColors.greyDarken2,
          title: const Text(
            'Login to Redit',
            style: TextStyle(color: CustomColors.white),
          )),
    );
  }
}

  //       child: WebView(
  //     initialUrl:
  //         'https://www.reddit.com/api/v1/authorize.compact?client_id=$client_id&response_type=code&state=test&redirect_uri=$redirect_url&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread',
  //     javascriptMode: JavascriptMode.unrestricted,
  //     onWebViewCreated: (controller) {
  //       controller = controller;
  //     },
  //     navigationDelegate: (NavigationRequest request) {
  //       if (request.url.startsWith("http://localhost")) {
  //         var pos = request.url.lastIndexOf('=');
  //         var code = (pos != -1)
  //             ? request.url.substring(pos + 1, request.url.length - 2)
  //             : request.url;
  //         postCode(code);
  //         return NavigationDecision.prevent;
  //       }
  //       return NavigationDecision.navigate;
  //     },
  //   ));
  // }