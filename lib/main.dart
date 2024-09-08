import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
import 'package:myapp/home_page/notification_page/news/service/news_service.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/service/news_api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/utils/common.dart';
import 'package:provider/provider.dart';
import 'page-1/splash_screen_1.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  bool? isLoggedIn = await MyApp.loggIn();
  runApp(MyApp(isLoggedIn: isLoggedIn!));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  static Future<bool?> loggIn() async {
    return await SharedPre.getAuthLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FollowerProvider()),
        ChangeNotifierProvider(
            create: (context) => CounsellorDetailsProvider()),
        ChangeNotifierProvider(create: (context) => UserBookingProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                NewsProvider(newsApiService: NewsApiService())),
        ChangeNotifierProvider(
            create: (context) => NewsProvider1(newsService: NewsService())),
      ],
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        child: GetMaterialApp(
          title: 'SMC App',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: snackbarKey,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(primarySwatch: Colors.grey),
          home: SplashScreen1(isLoggedIn: isLoggedIn),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:device_info_plus/device_info_plus.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Unique ID Example',
//       home: UniqueIdScreen(),
//     );
//   }
// }

// class UniqueIdScreen extends StatefulWidget {
//   @override
//   _UniqueIdScreenState createState() => _UniqueIdScreenState();
// }

// class _UniqueIdScreenState extends State<UniqueIdScreen> {
//   String _uniqueId = 'Fetching...';

//   @override
//   void initState() {
//     super.initState();
//     _fetchUniqueId();
//   }

//   Future<void> _fetchUniqueId() async {
//     String uniqueId;

//     if (await _isIOS()) {
//       uniqueId = await _getIOSUniqueId();
//     } else {
//       uniqueId = await _getAndroidUniqueId();
//     }

//     setState(() {
//       _uniqueId = uniqueId;
//     });
//   }

//   Future<bool> _isIOS() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     try {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       return iosInfo != null;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<String> _getIOSUniqueId() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

//     // iOS पर IMEI तक पहुंच संभव नहीं है; `identifierForVendor` का उपयोग करें
//     return iosInfo.identifierForVendor ?? 'Unknown ID'; // यूनिक आईडी प्राप्त करें
//   }

//   Future<String> _getAndroidUniqueId() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

//     // Android पर IMEI तक पहुंच सीमित हो सकती है; `androidId` का उपयोग करें
//     return androidInfo.id; // Android ID प्राप्त करें
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Unique ID Example'),
//       ),
//       body: Center(
//         child: Text('Unique ID: $_uniqueId'),
//       ),
//     );
//   }
// }
