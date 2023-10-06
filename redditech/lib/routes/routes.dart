import 'package:flutter/material.dart';
// Define Routes
import 'package:redditech/views/login.dart';
import 'package:redditech/views/home.dart';
import 'package:redditech/views/navigaton_menu.dart';

// Route Names
const String loginPage = 'login';
const String homePage = 'home';
const String navigationMenu = 'navigationMenu';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => const Login());
    case homePage:
      return MaterialPageRoute(builder: (context) => const Home());
    case navigationMenu:
      return MaterialPageRoute(builder: (context) => const NavigationMenu());
    default:
      throw ('This route name does not exit');
  }
}
