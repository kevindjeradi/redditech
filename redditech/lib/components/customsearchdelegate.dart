import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redditech/api/api.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:redditech/utils/utils.dart';
import 'package:redditech/views/subreddit.dart';
import 'package:redditech/views/subreddit_navigation_menu.dart';
import 'package:http/http.dart' as http;

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    "nature",
    "america",
    "gaming",
    "memes",
    "imsorryjohn"
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: CustomColors.greyDarken3,
        listTileTheme:
            const ListTileThemeData(tileColor: CustomColors.greyDarken3),
        primarySwatch: MaterialColor(333333, Utils.materialColor),
        backgroundColor: CustomColors.greyDarken3,
        appBarTheme: AppBarTheme(backgroundColor: CustomColors.greyDarken2));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, 'result');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<http.Response>(
        future: Api.makeGet("/subreddits/search?q=" + query.toLowerCase()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<String> suggestions = [];
            for (dynamic subreddit in jsonDecode(snapshot.data!.body)["data"]
                ["children"] as List<dynamic>) {
              suggestions.add(subreddit["data"]["display_name"]);
            }
            return ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      onTap: () => Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => SubredditNavigationMenu(
                                  title: suggestions.elementAt(index)))),
                      title: Text(
                        "r/" + suggestions.elementAt(index),
                        style: const TextStyle(color: Colors.white),
                      ));
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
