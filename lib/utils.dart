import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

TextStyle SafeGoogleFont(
  String fontFamily, {
  TextStyle? textStyle,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  Locale? locale,
  Paint? foreground,
  Paint? background,
  List<Shadow>? shadows,
  List<FontFeature>? fontFeatures,
  TextDecoration? decoration,
  Color? decorationColor,
  TextDecorationStyle? decorationStyle,
  double? decorationThickness,
}) {
  try {
    return GoogleFonts.getFont(
      fontFamily,
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  } catch (ex) {
    return GoogleFonts.getFont(
      "Source Sans Pro",
      textStyle: textStyle,
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      height: height,
      locale: locale,
      foreground: foreground,
      background: background,
      shadows: shadows,
      fontFeatures: fontFeatures,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
    );
  }
}

class SessionDate {
  static DateTime now = DateTime.now();

  static String todayDate = DateFormat("d MMM").format(now);
  static String year = Jiffy.now().format(pattern: "yyyy");

  static String get todayDay {
    String day = Jiffy.parse("$todayDate $year", pattern: "d MMM yyyy")
        .format(pattern: 'EEEE')
        .toString();

    return day;
  }

  final List<DateModel> dates = [];

  static dateTimeDif() {
    DateTime dt1 = DateTime.parse("2024-03-28 06:30:00");
    DateTime dt2 = DateTime.parse("2024-03-28 05:30:00");

    Duration diff = dt1.difference(dt2);

//print(diff.inDays);
//output (in days): 1198

    print(diff.inMinutes);
  }

  void getDates() {
    var myFormat = DateFormat('d MMM');
    DateTime todayNum = DateTime.now();

    for (int i = 0; i <= 5; i++) {
      DateTime futureDate = todayNum.add(Duration(days: i));

      String formattedDate = myFormat.format(futureDate);

      String day = Jiffy.parse("$formattedDate $year", pattern: "d MMM yyyy")
          .format(pattern: 'EEEE')
          .toString()
          .substring(0, 3);

      dates.add(DateModel(
          index: i,
          day: day,
          formattedDate: formattedDate,
          date: "$formattedDate $year"));
    }
  }
}

class DateModel {
  final int index;
  final String date;
  final String formattedDate;
  final String day;

  DateModel({
    required this.index,
    required this.day,
    required this.formattedDate,
    required this.date,
  });
}
