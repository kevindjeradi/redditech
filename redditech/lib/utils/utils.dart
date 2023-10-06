import 'package:flutter/widgets.dart';

class Utils {
  static dynamic nullHandler(dynamic data) {
    if (data == null) {
      return 0;
    } else {
      return data;
    }
  }

  static String numericBirthdayToString(dynamic birthday) {
    if (birthday is int) {
      birthday = birthday.toString();
    }
    String day = birthday[0] + birthday[1];
    String month = birthday[2] + birthday[3];
    String alphaMonth = '';
    switch (month) {
      case "01":
        alphaMonth = "January";
        break;
      case "02":
        alphaMonth = "February";
        break;
      case "03":
        alphaMonth = "March";
        break;
      case "04":
        alphaMonth = "April";
        break;
      case "05":
        alphaMonth = "May";
        break;
      case "06":
        alphaMonth = "June";
        break;
      case "07":
        alphaMonth = "July";
        break;
      case "08":
        alphaMonth = "August";
        break;
      case "09":
        alphaMonth = "September";
        break;
      case "10":
        alphaMonth = "October";
        break;
      case "11":
        alphaMonth = "November";
        break;
      case "12":
        alphaMonth = "December";
        break;
      default:
    }
    return day +
        ' ' +
        alphaMonth +
        ' ' +
        birthday[4] +
        birthday[5] +
        birthday[6] +
        birthday[7];
  }

  static Map<int, Color> materialColor = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
}
