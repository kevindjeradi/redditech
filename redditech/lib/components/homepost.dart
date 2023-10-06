import 'dart:io';

import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/components/commentbutton.dart';
import 'package:redditech/components/fullscreenimage.dart';
import 'package:redditech/components/updownvote.dart';
import 'package:redditech/components/videoplayer.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:redditech/themes/texts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePost extends StatefulWidget {
  final String redditor;
  final String subreddit;
  final String message;
  final String selfText;
  final int upvotes;
  final int commentNumber;
  final bool isVideo;
  final String imageUrl;
  final String? thumbnail;
  final String? linkUrl;
  final String permaLink;
  const HomePost(
      {Key? key,
      required this.redditor,
      required this.subreddit,
      required this.message,
      required this.selfText,
      required this.upvotes,
      required this.commentNumber,
      required this.isVideo,
      required this.imageUrl,
      required this.permaLink,
      this.thumbnail,
      this.linkUrl})
      : super(key: key);

  @override
  _HomePostState createState() => _HomePostState();
}

class _HomePostState extends State<HomePost> {
  bool upPressed = false;
  bool downPressed = false;
  late int upvotes;
  late Future<void> _initializeVideoPlayerFuture;
  late bool isVideoInitialized;

  @override
  void initState() {
    super.initState();
    upvotes = widget.upvotes;

    if (widget.isVideo) {
      isVideoInitialized = true;
    } else {
      isVideoInitialized = false;
    }
  }

  @override
  void dispose() {
    if (isVideoInitialized) {
      isVideoInitialized = false;
    }
    super.dispose();
  }

  Future<http.Response> getImage(String url) async {
    return await Api.makeGet(url);
  }

  String imageUrlHandler(String? url) {
    if (url == null) {
      return "https://cdn2.iconfinder.com/data/icons/mobile-layout-2/32/51_49_browser_mobile_application_confuse_error_smiley_emoji-512.png";
    } else {
      return url;
    }
  }

  String videoUrlHandler(String? url) {
    if (url == null) {
      return "https://v.redd.it/snq6mn3wifj81/DASH_1080.mp4?source=fallback";
    } else {
      return url;
    }
  }

  Future<http.Response> imagePreview() async {
    return http.get(Uri.parse(imageUrlHandler(widget.imageUrl)));
  }

  // Future<VideoPlayerController> getVideo() async {
  //   return Future.delayed(const Duration(milliseconds: 0), () => _controller);
  // }

  Future<http.Response> handleImage() async {
    return http.get(Uri.parse(
        "https://cdn2.iconfinder.com/data/icons/mobile-layout-2/32/51_49_browser_mobile_application_confuse_error_smiley_emoji-512.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: CustomColors.greyDarken2,
            border: Border(
                top: BorderSide(color: CustomColors.attentionMessage, width: 1),
                bottom: BorderSide(
                    color: CustomColors.attentionMessage, width: 1))),
        child: Column(children: [
          Row(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(7, 5, 0, 10),
                child: Text(
                  "u/" + widget.redditor,
                  style: TextThemes.postUser,
                ))
          ]),
          Row(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(7, 5, 0, 10),
              child: Text(
                "r/" + widget.subreddit,
                style: TextThemes.postSubReddit,
              ),
            )
          ]),
          Container(
              padding: const EdgeInsets.fromLTRB(7, 0, 0, 12),
              child: Row(children: [
                Flexible(
                    child: Text(
                  widget.message,
                  style: TextThemes.post,
                ))
              ])),
          Container(
            padding: const EdgeInsets.fromLTRB(7, 0, 0, 12),
            child: Row(
              children: [
                Flexible(
                    child: Text(
                  widget.selfText,
                  style: TextThemes.postSelfText,
                ))
              ],
            ),
          ),
          widget.linkUrl == null
              ? Container()
              : Container(
                  padding: const EdgeInsets.fromLTRB(7, 0, 0, 12),
                  child: Row(children: [
                    Flexible(
                        child: GestureDetector(
                            child: Text(
                              widget.linkUrl!,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            leading: IconButton(
                                                icon: const Icon(
                                                    Icons.arrow_back),
                                                onPressed: () =>
                                                    Navigator.pop(context)),
                                            centerTitle: true,
                                            title: Text(
                                              widget.linkUrl!,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            backgroundColor:
                                                CustomColors.greyDarken2,
                                          ),
                                          body: WebView(
                                            javascriptMode:
                                                JavascriptMode.unrestricted,
                                            initialUrl: widget.linkUrl,
                                          ),
                                        )))))
                  ])),
          widget.isVideo
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  child: VideoItems(
                    videoPlayerController: VideoPlayerController.network(
                        widget.imageUrl.replaceAll("&amp;", '&')),
                    looping: false,
                    autoplay: false,
                  ))
              : InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              FullScreenImage(imageUrl: widget.imageUrl))),
                  child: Image.network(
                    widget.imageUrl,
                    errorBuilder: (context, error, stackTrace) => Container(),
                  ),
                ),
          Container(
              color: const Color.fromRGBO(0, 0, 0, 0.1),
              child: Row(children: [
                UpDownVote(
                    onPressed: () {
                      setState(() {
                        if (downPressed) {
                          upvotes += 2;
                        } else {
                          if (upPressed) {
                            upvotes -= 1;
                          } else {
                            upvotes += 1;
                          }
                        }
                        upPressed = !upPressed;
                        downPressed = false;
                      });
                    },
                    icon: Direction.up,
                    isPressed: upPressed),
                UpDownVote(
                    onPressed: () {
                      setState(() {
                        if (upPressed) {
                          upvotes -= 2;
                        } else {
                          if (downPressed) {
                            upvotes += 1;
                          } else {
                            upvotes -= 1;
                          }
                        }
                        downPressed = !downPressed;
                        upPressed = false;
                      });
                    },
                    icon: Direction.down,
                    isPressed: downPressed),
                Text(
                  upvotes > 999
                      ? "+999"
                      : upvotes < -999
                          ? "-999"
                          : upvotes.toString(),
                  style: TextThemes.genericWhite,
                ),
                const Divider(
                  thickness: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  height: 5,
                  endIndent: 20,
                  indent: 20,
                ),
                CommentButton(
                  commentNumber: widget.commentNumber,
                  post: widget,
                )
              ]))
        ]));
  }
}
