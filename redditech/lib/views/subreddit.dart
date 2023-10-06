import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/components/appbartech.dart';
import 'package:redditech/components/homepost.dart';
import 'package:redditech/themes/customcolors.dart';

class Subreddit extends StatefulWidget {
  final String subredditName;
  const Subreddit({Key? key, required this.subredditName}) : super(key: key);

  @override
  _SubredditState createState() => _SubredditState();
}

class _SubredditState extends State<Subreddit> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<dynamic>> futuredata;
  Filter filter = Filter.hot;
  late String after = "";
  late List<dynamic> list = [];
  int counter = 0;
  bool loading = false;

  void initFetch() async {
    loading = true;
    var res = await Api.getPosts(widget.subredditName, filter, 5, counter, "");
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
      var res =
          await Api.getPosts(widget.subredditName, filter, 3, counter, after);
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
        appBar: AppBarTech(
          title: widget.subredditName,
          isSubreddit: true,
        ),
        body: SafeArea(
            child: Container(
                width: deviceWidth,
                height: deviceHeight,
                color: CustomColors.greyDarken3,
                child: Column(children: [
                  Expanded(
                    child: Builder(builder: (context) {
                      if (list.isNotEmpty) {
                        // log(snapshot.data!.body);
                        // Map<String, dynamic> data =
                        //     jsonDecode(snapshot.data!.body);
                        // List<dynamic> list = data["data"]["children"];
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
                                            ["reddit_video"]["fallback_url"]
                                        : list[index]["data"]["url"],
                                upvotes: list[index]["data"]["ups"],
                                commentNumber: list[index]["data"]
                                    ["num_comments"],
                                isVideo: list[index]["data"]["is_video"],
                                selfText: list[index]["data"]["selftext"],
                                linkUrl: list[index]["data"]
                                    ["url_overridden_by_dest"],
                                thumbnail: list[index]["data"]["thumbnail"],
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
