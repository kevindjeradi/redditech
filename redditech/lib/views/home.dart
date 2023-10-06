import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/components/appbartech.dart';
import 'package:redditech/components/homepost.dart';
import 'package:redditech/themes/customcolors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<dynamic>> futuredata;
  Filter filter = Filter.best;
  late String after = "";
  late List<dynamic> list = [];
  int counter = 0;
  bool loading = false;

  void initFetch() async {
    loading = true;
    var res = await Api.getPosts("home", filter, 5, counter, "");
    list.addAll(jsonDecode(res.body)["data"]["children"]);
    setState(() {
      counter += 5;
      after = "&after=" + jsonDecode(res.body)["data"]["after"];
    });
    loading = false;
  }

  void morePosts() async {
    if (list.isNotEmpty && !loading) {
      loading = true;
      var res = await Api.getPosts("home", filter, 3, counter, after);
      list.addAll(jsonDecode(res.body)["data"]["children"]);
      setState(() {
        counter += 3;
        after = "&after=" + jsonDecode(res.body)["data"]["after"];
      });
      loading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    initFetch();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent * 0.9) {
        morePosts();
      }
    });
    return Scaffold(
        appBar: const AppBarTech(
          title: "Redditech",
          isSubreddit: false,
        ),
        body: SafeArea(
            child: Container(
                width: deviceWidth,
                height: deviceHeight,
                color: CustomColors.greyDarken3,
                child: Column(children: [
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: <Widget>[
                        IconButton(
                            onPressed: () {
                              setState(() {
                                filter = Filter.best;
                                list = [];
                              });
                              initFetch();
                            },
                            icon: const Icon(
                              Icons.rocket,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                filter = Filter.hot;
                                list = [];
                              });
                              initFetch();
                            },
                            icon: const Icon(
                              Icons.fireplace,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                filter = Filter.recent;
                                list = [];
                              });
                              initFetch();
                            },
                            icon: const Icon(
                              Icons.star,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                filter = Filter.top;
                                list = [];
                              });
                              initFetch();
                            },
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ))
                      ])),
                  Expanded(
                    child: Builder(builder: (context) {
                      if (list.isNotEmpty) {
                        return ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(top: 15),
                              width: deviceWidth,
                              child: HomePost(
                                message: list[index]["data"]["title"]!,
                                redditor: list[index]["data"]["author"]!,
                                subreddit: list[index]["data"]["subreddit"]!,
                                imageUrl:
                                    list[index]["data"]["is_video"] == true
                                        ? list[index]["data"]["media"]
                                            ["reddit_video"]["hls_url"]
                                        : list[index]["data"]["url"],
                                upvotes: list[index]["data"]["ups"],
                                commentNumber: list[index]["data"]
                                    ["num_comments"],
                                isVideo: list[index]["data"]["is_video"],
                                selfText: list[index]["data"]["selftext"],
                                permaLink: list[index]["data"]["permalink"],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(
                            child: SizedBox(
                          child: CircularProgressIndicator(),
                        ));
                      }
                    }),
                  )
                ]))));
  }
}
