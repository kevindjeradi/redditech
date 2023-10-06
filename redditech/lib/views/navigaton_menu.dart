import 'package:flutter/material.dart';
import 'package:redditech/themes/customcolors.dart';
import 'package:redditech/views/home.dart';
import 'package:redditech/views/profile.dart';
import 'package:redditech/views/settings.dart';
import 'package:redditech/views/settings_page.dart';
import 'package:redditech/snake/splash_screen/HomeScreen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  final Widget _home = const Home();
  final Widget _profile = const Profile();
  final Widget _settings = const SettingsPage();
  final Widget _bonus = const Bonus();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget? getPageContent() {
    if (_selectedIndex == 0) {
      return _home;
    } else if (_selectedIndex == 1) {
      return _profile;
    } else if (_selectedIndex == 2) {
      return _settings;
    } else {
      return _bonus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: getPageContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.greyDarken2,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: CustomColors.attentionMessage,
        selectedItemColor: CustomColors.attentionMessage,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_outlined),
            label: "bonus",
          ),
        ],
      ),
    );
  }
}
