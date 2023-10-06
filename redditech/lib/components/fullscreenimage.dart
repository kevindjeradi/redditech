import 'package:flutter/material.dart';
import 'package:redditech/themes/customcolors.dart';

class FullScreenImage extends StatefulWidget {
  final String imageUrl;
  const FullScreenImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.greyDarken2,
      body: GestureDetector(
        child: Center(
          child: Hero(tag: 'image', child: Image.network(widget.imageUrl)),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
