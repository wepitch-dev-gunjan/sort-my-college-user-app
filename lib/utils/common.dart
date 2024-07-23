import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

String convertSessionTime(String sessionTime) {
  int time = int.parse(sessionTime);
  String hour = ((time ~/ 60) % 12).toString();
  String minute = (time % 60).toString().padLeft(2, '0');
  String period = (time ~/ 60) < 12 ? 'AM' : 'PM';

  return '$hour:$minute $period';
}

// logData(String responseBody) {
//   final encoder = JsonEncoder.withIndent('  ');
//   final prettyString = encoder.convert(responseBody);

//   var data = log(prettyString);
//   return data;
// }

void logData(List responseBody, {String? value}) {
  final encoder = JsonEncoder.withIndent('  ');
  final prettyString = encoder.convert(responseBody);
  log("value$prettyString");
}

// class Console {
//   static data(List responseBody, {String? value}) {
//     final encoder = JsonEncoder.withIndent('  ');
//     final prettyString = encoder.convert(responseBody);
//     log("value$prettyString");
//   }
// }

class Console {
  static data(List responseBody, {String? value}) {
    var encoder = const JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(responseBody);
    const String red = '\x1B[37m';
    const String reset = '\x1B[0m';
    log("${red}value$prettyString$reset");
  }
}


final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void ShowSnackBarMsg(String message, {Color? color}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}



