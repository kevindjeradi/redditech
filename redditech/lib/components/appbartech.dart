import 'package:flutter/material.dart';
import 'package:redditech/components/customsearchdelegate.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:redditech/views/subredditinfo.dart';

class AppBarTech extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isSubreddit;
  const AppBarTech({Key? key, required this.title, required this.isSubreddit})
      : super(key: key);

  @override
  _AppBarTechState createState() => _AppBarTechState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarTechState extends State<AppBarTech> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        widget.isSubreddit
            ? Padding(
                padding: const EdgeInsets.only(right: 7),
                child: IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SubredditInfo(
                                title: widget.title,
                              ))),
                ),
              )
            : Container(),
        Padding(
            padding: const EdgeInsets.only(right: 7),
            child: IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
                icon: const Icon(Icons.search))),
      ],
      automaticallyImplyLeading: widget.isSubreddit ? true : false,
      leading: widget.isSubreddit
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context))
          : null,
      title:
          widget.isSubreddit ? Text("r/" + widget.title) : Text(widget.title),
      centerTitle: true,
      backgroundColor: CustomColors.greyDarken2,
    );
  }
}
