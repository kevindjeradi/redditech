import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redditech/providers/tokenprovider.dart';

enum Filter { best, recent, hot, top, random }

class Api {
  static String accessToken = TokenProvider.accessToken;
  static String secret = "wrFYDCPffRo95TYahw_mp1mTSjiDcA";
  static String clientID = "B3lXVE56PcfUresmE4e4tw";
  static String redirect = "http://localhost";
  static String baseOAuthUrl = "https://oauth.reddit.com";

  static Map<String, String> baseHeaders = {
    "Authorization": "bearer " + accessToken
  };

  static Future login(String code) async {
    http.Response response = await http.post(
      Uri.parse("https://www.reddit.com/api/v1/access_token"),
      headers: {
        "Authorization": "Basic " + base64.encode(utf8.encode(clientID + ':'))
      },
      body: {
        "grant_type": "authorization_code",
        "code": code,
        "redirect_uri": redirect
      },
    );
    Map<String, dynamic> responseJSON = jsonDecode(response.body);
    if (responseJSON.keys.first == "error") {
      return false;
    } else {
      TokenProvider.accessToken = responseJSON["access_token"];
      return true;
    }
  }

  /// Static Method Fetchs every settings of the current user
  static Future<Map<String, dynamic>> getPrefs() async {
    http.Response response = await http.get(
      Uri.parse("https://oauth.reddit.com/api/v1/me/prefs"),
      headers: baseHeaders,
    );
    Map<String, dynamic> responseJSON = jsonDecode(response.body);
    return (responseJSON);
  }

  /// Static Method Send a PATCH request to the Reddit Api to update preferences
  static savePrefs(Map<String, dynamic> settingsMap) async {
    await http.patch(Uri.parse("https://oauth.reddit.com/api/v1/me/prefs"),
        headers: baseHeaders, body: json.encode(settingsMap));
  }

  static Future getProfileData() {
    return http.get(Uri.parse(baseOAuthUrl + "/api/v1/me"),
        headers: baseHeaders);
  }

  static Future<http.Response> makeGet(String url) {
    return http.get(Uri.parse(baseOAuthUrl + url), headers: baseHeaders);
  }

  static Future<http.Response> makePost(String url, dynamic body) {
    return http.post(Uri.parse(baseOAuthUrl + url),
        headers: baseHeaders, body: body);
  }

  static Future<http.Response> getPosts(String subreddit, Filter filter,
      int count, int alreadySeen, String lastPost) {
    String value = "/best";
    switch (filter) {
      case Filter.best:
        value = "/best";
        break;
      case Filter.hot:
        value = "/hot";
        break;
      case Filter.random:
        value = "/random";
        break;
      case Filter.recent:
        value = "/new";
        break;
      case Filter.top:
        value = "/top";
        break;
      default:
        "/best";
    }
    if (subreddit == "home") {
      return http.get(
          Uri.parse(
              baseOAuthUrl + value + "?limit=" + count.toString() + lastPost),
          headers: baseHeaders);
    } else {
      return http.get(
          Uri.parse(baseOAuthUrl +
              "/r/" +
              subreddit +
              value +
              "?limit=" +
              count.toString() +
              lastPost),
          headers: baseHeaders);
    }
  }

  // static Future getHomePost(Filter filter, int number) {

  // }
}
