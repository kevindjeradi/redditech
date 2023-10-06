import 'package:flutter/material.dart';
import 'package:redditech/components/appbartech.dart';
import 'package:redditech/views/home.dart';
import 'package:redditech/views/profile.dart';
import 'package:redditech/views/settings.dart';
import 'package:redditech/views/subreddit.dart';

class SubredditNavigationMenu extends StatefulWidget {
  final String title;
  const SubredditNavigationMenu({Key? key, required this.title})
      : super(key: key);

  @override
  _SubredditNavigationMenuState createState() =>
      _SubredditNavigationMenuState();
}

class _SubredditNavigationMenuState extends State<SubredditNavigationMenu> {
  int _selectedIndex = 0;
  late Widget _subreddit;
  final Widget _profile = const Profile();
  final Widget _settings = const Settings();

  @override
  void initState() {
    super.initState();
    _subreddit = Subreddit(subredditName: widget.title);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget? getPageContent() {
    if (_selectedIndex == 0) {
      return _subreddit;
    } else if (_selectedIndex == 1) {
      return _profile;
    } else if (_selectedIndex == 2) {
      return _settings;
    } else {
      return _subreddit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: getPageContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
