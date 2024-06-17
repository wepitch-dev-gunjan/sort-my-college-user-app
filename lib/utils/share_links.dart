import 'dart:io';
import 'package:share_plus/share_plus.dart';

shareLinks() {
  if (Platform.isIOS) {
    Share.share('https://apps.apple.com/in/app/sort-my-college/id6480402447');
  } else if (Platform.isAndroid) {
    Share.share(
        'https://play.google.com/store/apps/details?id=com.sortmycollege');
  } else {
    throw 'Platform not supported';
  }
}
