// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
// import 'package:myapp/home_page/notification_page/news/service/news_service.dart';
// import 'package:myapp/news/provider/news_provider.dart';
// import 'package:myapp/news/service/news_api_service.dart';
// import 'package:myapp/other/provider/counsellor_details_provider.dart';
// import 'package:myapp/other/provider/follower_provider.dart';
// import 'package:myapp/other/provider/user_booking_provider.dart';
// import 'package:myapp/page-1/shared.dart';
// import 'package:myapp/utils.dart';
// import 'package:myapp/utils/common.dart';
// import 'package:provider/provider.dart';
// import 'page-1/splash_screen_1.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   bool? isLoggedIn = await MyApp.loggIn();
//   runApp(MyApp(isLoggedIn: isLoggedIn!));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.isLoggedIn});

//   final bool isLoggedIn;

//   static Future<bool?> loggIn() async {
//     return await SharedPre.getAuthLogin();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => FollowerProvider()),
//         ChangeNotifierProvider(
//             create: (context) => CounsellorDetailsProvider()),
//         ChangeNotifierProvider(create: (context) => UserBookingProvider()),
//         ChangeNotifierProvider(
//             create: (context) =>
//                 NewsProvider(newsApiService: NewsApiService())),
//         ChangeNotifierProvider(
//             create: (context) => NewsProvider1(newsService: NewsService())),
//       ],
//       child: ScreenUtilInit(
//         designSize: ScreenUtil.defaultSize,
//         minTextAdapt: true,
//         child: GetMaterialApp(
//           title: 'SMC App',
//           debugShowCheckedModeBanner: false,
//           scaffoldMessengerKey: snackbarKey,
//           scrollBehavior: MyCustomScrollBehavior(),
//           theme: ThemeData(primarySwatch: Colors.grey),
//           home: SplashScreen1(isLoggedIn: isLoggedIn),
//           builder: EasyLoading.init(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImeiScreen(),
    );
  }
}

class ImeiScreen extends StatefulWidget {
  @override
  _ImeiScreenState createState() => _ImeiScreenState();
}

class _ImeiScreenState extends State<ImeiScreen> {
  String _imei = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getImei();
  }

  Future<void> _getImei() async {
    String imei = 'Unknown';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (await Permission.phone.request().isGranted) {
        if (Theme.of(context).platform == TargetPlatform.android) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          imei = androidInfo.serialNumber;
        } else {
          imei = 'IMEI not available on this platform';
        }
      } else {
        imei = 'Permission denied';
      }
    } catch (e) {
      imei = 'Failed to get IMEI: $e';
    }

    if (!mounted) return;

    setState(() {
      _imei = imei;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get IMEI'),
      ),
      body: Center(
        child: Text('IMEI: $_imei'),
      ),
    );
  }
}
