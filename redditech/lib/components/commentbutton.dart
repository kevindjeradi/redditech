import 'package:flutter/material.dart';
import 'package:redditech/components/homepost.dart';
import 'package:redditech/themes/texts.dart';
import 'package:redditech/views/comments.dart';

class CommentButton extends StatefulWidget {
  final int commentNumber;
  final HomePost post;
  const CommentButton(
      {Key? key, required this.commentNumber, required this.post})
      : super(key: key);

  @override
  _CommentButtonState createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => PostComments(post: widget.post))),
      splashFactory: InkSplash.splashFactory,
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.only(right: 5),
              child: const Icon(
                Icons.comment,
              )),
          Text(
            widget.commentNumber != 0 ? widget.commentNumber.toString() : '',
            style: TextThemes.genericWhite,
          )
        ],
      ),
    );
  }
}
