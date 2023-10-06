import 'package:flutter/material.dart';
import 'package:redditech/themes/customcolors.dart';

enum Direction { up, down }

class UpDownVote extends StatefulWidget {
  final VoidCallback onPressed;
  final Direction icon;
  final bool isPressed;
  const UpDownVote(
      {Key? key,
      required this.onPressed,
      required this.icon,
      this.isPressed = false})
      : super(key: key);

  @override
  _UpDownVoteState createState() => _UpDownVoteState();
}

class _UpDownVoteState extends State<UpDownVote> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onPressed,
        icon: widget.icon == Direction.up
            ? Icon(Icons.arrow_upward,
                size: 20,
                color: widget.isPressed == true
                    ? CustomColors.attentionMessage
                    : Colors.black)
            : Icon(
                Icons.arrow_downward,
                size: 20,
                color: widget.isPressed == true ? Colors.blue : Colors.black,
              ));
  }
}
