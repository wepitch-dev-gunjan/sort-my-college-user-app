import 'dart:developer';
import 'package:in_app_update/in_app_update.dart';



void checkForAndroidUpdate() async {
  try {
    final AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (updateInfo.immediateUpdateAllowed) {
        // Immediate Update
        await InAppUpdate.performImmediateUpdate();
      } else if (updateInfo.flexibleUpdateAllowed) {
        // Flexible Update
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
      }
    } else {
      log("Not Available any update");
    }
  } catch (e) {
    log("Error checking for updates: $e");
  }
}
