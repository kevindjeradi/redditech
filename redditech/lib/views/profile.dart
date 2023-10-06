import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/providers/tokenprovider.dart';
import 'package:redditech/templates/user.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:redditech/themes/texts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
            color: CustomColors.greyDarken3,
            padding: const EdgeInsets.all(15),
            width: deviceWidth,
            height: deviceHeight,
            child: FutureBuilder<dynamic>(
              future: Api.getProfileData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data = jsonDecode(snapshot.data!.body);
                  User user = User.fromJson({
                    "avatar": data["icon_img"],
                    "nickname": data["subreddit"]["display_name_prefixed"],
                    "karma": data["total_karma"],
                    "snooAvatar": data["snoovatar_img"],
                    "description": data["subreddit"]["public_description"]
                  });
                  return Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              SizedBox(
                                width: deviceWidth * 0.45,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      user.snooAvatar,
                                      headers: {
                                        "Authorization": "bearer " +
                                            TokenProvider.accessToken
                                      },
                                      loadingBuilder:
                                          (context, widget, loadingProgress) =>
                                              const CircularProgressIndicator(),
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.network(
                                        user.avatarUrl.replaceAll("&amp;", '&'),
                                        headers: {
                                          "Authorization": "bearer " +
                                              TokenProvider.accessToken
                                        },
                                      ),
                                    )),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    user.nickname,
                                    style: TextThemes.profileUser,
                                  ))
                            ],
                          )),
                      Container(
                          padding: const EdgeInsets.fromLTRB(12, 20, 0, 0),
                          child: Row(
                            children: [
                              SizedBox(
                                child: Row(children: [
                                  Container(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: const Icon(
                                        Icons.ac_unit,
                                        color: Colors.white,
                                      )),
                                  Text(
                                    user.karma.toString(),
                                    style: TextThemes.genericWhite,
                                  )
                                ]),
                              )
                            ],
                          )),
                      user.description == ""
                          ? Container()
                          : Row(children: const [
                              Text(
                                "description :",
                                style: TextThemes.genericWhite,
                              )
                            ]),
                      Row(children: [
                        Text(
                          user.description,
                          style: TextThemes.genericWhite,
                        )
                      ])
                    ],
                  );
                } else {
                  return const Center(
                    child: SizedBox(child: CircularProgressIndicator()),
                  );
                }
              },
            )),
      )),
    );
  }
}
