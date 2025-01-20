import 'package:flutter/material.dart';


// class Console {
//   static data(List responseBody, {String? value}) {
//     var encoder = const JsonEncoder.withIndent('  ');
//     final prettyString = encoder.convert(responseBody);
//     const String red = '\x1B[37m';
//     const String reset = '\x1B[0m';
//     log("${red}value$prettyString$reset");
//   }
// }


final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBarMsg(String message, {Color? color}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  );
  snackbarKey.currentState?.showSnackBar(snackBar);
}



