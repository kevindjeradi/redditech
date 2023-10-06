import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/components/homepost.dart';
import 'package:redditech/templates/comment.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:http/http.dart' as http;

class PostComments extends StatefulWidget {
  final HomePost post;
  const PostComments({Key? key, required this.post}) : super(key: key);

  @override
  PostCommentsState createState() => PostCommentsState();
}

class PostCommentsState extends State<PostComments> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.greyDarken2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
            width: deviceWidth,
            height: deviceHeight,
            color: CustomColors.greyDarken3,
            child: Expanded(
              child: Column(children: [
                widget.post,
                Expanded(
                    child: FutureBuilder<http.Response>(
                        future: Api.makeGet(widget.post.permaLink),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final List body = jsonDecode(snapshot.data!.body);
                            List<Comment> commentsList = [];
                            for (dynamic comment in body[1]["data"]
                                ["children"]) {
                              commentsList.add(Comment.fromJson({
                                "user": comment["author"],
                                "body": comment["body"]
                              }));
                            }
                            return ListView.builder(
                                itemBuilder: (context, index) {
                              Comment comment = commentsList.elementAt(index);
                              return Container(
                                child: Column(children: [
                                  Row(
                                    children: [Text("u/" + comment.user)],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(child: Text(comment.body))
                                    ],
                                  )
                                ]),
                              );
                            });
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }))
              ]),
            )),
      ),
    );
  }
}
