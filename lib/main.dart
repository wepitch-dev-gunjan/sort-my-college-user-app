import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
import 'package:myapp/home_page/notification_page/news/service/news_service.dart';
import 'package:myapp/utils/navigation.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/service/news_api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/utils/common.dart';
import 'package:provider/provider.dart';
import 'notification_service.dart';
import 'page-1/splash_screen_1.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationServices().requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  MessageService.forgroundMessage();
  await NotificationServices().getAccessToken();
  await NotificationServices().getToken();
  MessageService.firebaseInit();
  MessageService.backgroudAndTerminateAppNavatior();

  bool? isLoggedIn = await MyApp.loggIn();
  runApp(MyApp(isLoggedIn: isLoggedIn!));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

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
          navigatorKey: navigatorKey,
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

// // ============================== ! Pretty Log in console !==========================

// class Console {
//   static data(dynamic responseBody, {String? value}) {
//     var encoder = const JsonEncoder.withIndent('  ');
//     final prettyString = encoder.convert(responseBody);
//     const String red = '\x1B[37m';
//     const String reset = '\x1B[0m';
//     log("${red}value$prettyString$reset");
//   }
// }



// class ZoomWebView extends StatefulWidget {
//   final String url;

//   ZoomWebView({required this.url});

//   @override
//   State<ZoomWebView> createState() => _ZoomWebViewState();
// }

// class _ZoomWebViewState extends State<ZoomWebView> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(widget.url));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Join Zoom Webinar")),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }




