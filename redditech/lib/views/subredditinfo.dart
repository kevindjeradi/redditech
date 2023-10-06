import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/components/custombutton.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:http/http.dart' as http;
import 'package:redditech/themes/texts.dart';

class SubredditInfo extends StatefulWidget {
  final String title;
  const SubredditInfo({Key? key, required this.title}) : super(key: key);

  @override
  _SubredditInfoState createState() => _SubredditInfoState();
}

class _SubredditInfoState extends State<SubredditInfo> {
  late bool isSubscribed;
  late Future<http.Response> futureData;

  @override
  void initState() {
    super.initState();
    futureData = Api.makeGet("/r/" + widget.title + "/about");
    futureData.then((value) =>
        isSubscribed = jsonDecode(value.body)["data"]["user_is_subscriber"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.greyDarken2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        color: CustomColors.greyDarken3,
        child: Expanded(
            child: FutureBuilder<http.Response>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final body = jsonDecode(snapshot.data!.body)["data"];
              return Center(
                  child: Column(
                children: [
                  Image.network(
                    body["community_icon"].toString().replaceAll("&amp;", '&'),
                    errorBuilder: (context, error, stackTrace) => Image.network(
                      body["banner_background_image"]
                          .toString()
                          .replaceAll("&amp;", '&'),
                      errorBuilder: (context, error, stackTrace) => const Text(
                        "No image for this subreddit.",
                        style: TextThemes.genericWhite,
                      ),
                    ),
                  ),
                  Text(
                    body["display_name_prefixed"],
                    style: const TextStyle(color: Colors.white, fontSize: 26),
                  ),
                  Text(
                    body["title"],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "Subscribers: " + body["subscribers"].toString(),
                    style: TextThemes.genericWhite,
                  ),
                  const Text(
                    "Description: ",
                    style: TextThemes.genericWhite,
                  ),
                  Text(
                    body["public_description"],
                    style: TextThemes.genericWhite,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CustomButton(
                      color: ButtonColor.blue,
                      text: isSubscribed ? "Unsubcribe" : "Subscribe",
                      function: () {
                        isSubscribed
                            ? Api.makePost("/api/subscribe",
                                {"action": "unsub", "sr": body["name"]})
                            : Api.makePost("/api/subscribe",
                                {"action": "sub", "sr": body["name"]});
                        setState(() {
                          isSubscribed = !isSubscribed;
                        });
                      },
                    ),
                  )
                ],
              ));
            } else {
              return const CircularProgressIndicator();
            }
          },
        )),
      )),
    );
  }
}
