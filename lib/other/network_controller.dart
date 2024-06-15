// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myapp/utils.dart';

// class NetworkController extends GetxController {
//   final Connectivity _connectivity = Connectivity();

//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   void _updateConnectionStatus(ConnectivityResult connectivityResult) {
//     if (connectivityResult == ConnectivityResult.none) {
//       Get.rawSnackbar(
//           messageText: Text(
//             "PLEASE CONNECT TO THE INTERNET",
//             style: SafeGoogleFont("Inter", fontSize: 14, color: Colors.white),
//           ),
//           isDismissible: false,
//           overlayColor: Colors.green,
//           duration: const Duration(days: 1),
//           backgroundColor: Colors.red,
//           icon: const Icon(
//             Icons.wifi_off,
//             color: Colors.white,
//             size: 35,
//           ),
//           margin: EdgeInsets.zero,
//           snackStyle: SnackStyle.FLOATING);
//     } else {
//       if (Get.isSnackbarOpen) {
//         Get.closeCurrentSnackbar();
//       }
//     }
//   }
// }
