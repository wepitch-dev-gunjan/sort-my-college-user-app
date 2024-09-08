import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url, BuildContext context) async {
  EasyLoading.show(status: "Loading...", dismissOnTap: false);
  var uri = Uri.parse(url);
  log("message Uri$uri");

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri).then((value) {
      if (value) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.showToast(
          "Unable to Open..",
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      }
    });
  } else {
    EasyLoading.showToast(
      "Unable to Open..",
      toastPosition: EasyLoadingToastPosition.bottom,
    );
    EasyLoading.dismiss();
  }
}

bool isSessionExpired(
    String sessionDate, String sessionTime, int sessionDuration) {
  // Parse date
  List<String> dateParts = sessionDate.split('-');
  int day = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int year = int.parse(dateParts[2]);

  // Parse time
  List<String> timeParts = sessionTime.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1].substring(0, 2));

  // Get AM/PM period
  String period = sessionTime.substring(sessionTime.length - 2);

  // Convert to 24-hour format
  if (period == 'PM' && hour != 12) {
    hour += 12;
  } else if (period == 'AM' && hour == 12) {
    hour = 0;
  }

  // Combine date and time
  DateTime combinedDateTime = DateTime(year, month, day, hour, minute);

  // log("CombineDate1$combinedDateTime");

  // Add session duration to the combined datetime
  combinedDateTime = combinedDateTime.add(Duration(minutes: sessionDuration));
  // log("CombineDate2$combinedDateTime");
  // Get current datetime
  DateTime now = DateTime.now();

  // // Check if the session is expired
  // log("123${combinedDateTime.isBefore(now)}");
  return combinedDateTime.isBefore(now);
}
