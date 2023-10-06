import 'package:flutter/widgets.dart';

// class ToggleProvider with ChangeNotifier {
//   late String accessToken = "";

//   String get getAccessToken => accessToken;

//   void changeToggleProvider(String value) {
//     accessToken = value;
//     notifyListeners();
//   }
// }

class TokenProvider {
  static String accessToken = "";
}
