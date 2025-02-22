import 'dart:convert';
import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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
import 'notifications/notification_handler.dart';
import 'page-1/splash_screen_1.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await NotificationHandler.initializeNotifications();
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
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver observer =
        FirebaseAnalyticsObserver(analytics: analytics);

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
            navigatorObservers: [observer],
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: snackbarKey,
            scrollBehavior: MyCustomScrollBehavior(),
            theme: ThemeData(primarySwatch: Colors.grey),
            home: SplashScreen1(isLoggedIn: isLoggedIn),
            builder: EasyLoading.init()),
      ),
    );
  }
}

// // // // ============================== ! Pretty Log in console !==========================

// class Console {
//   static data(dynamic responseBody, {String? value}) {
//     var encoder = const JsonEncoder.withIndent('  ');
//     final prettyString = encoder.convert(responseBody);
//     const String red = '\x1B[37m';
//     const String reset = '\x1B[0m';
//     log("${red}value$prettyString$reset");
//   }
// }





// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:truecaller_sdk/truecaller_sdk.dart';
// import 'package:permission_handler/permission_handler.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Truecaller Login Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TruecallerLoginScreen(),
//     );
//   }
// }

// class TruecallerLoginScreen extends StatefulWidget {
//   @override
//   _TruecallerLoginScreenState createState() => _TruecallerLoginScreenState();
// }

// class _TruecallerLoginScreenState extends State<TruecallerLoginScreen> {
//   StreamSubscription? _truecallerSubscription;
//   String _statusMessage = "Initialize Truecaller SDK";

//   @override
//   void initState() {
//     super.initState();
//     _initializeTruecallerSDK();
//   }

//   @override
//   void dispose() {
//     _truecallerSubscription?.cancel();
//     super.dispose();
//   }

//   void _initializeTruecallerSDK() async {
//     // Initialize Truecaller SDK
//     TcSdk.initializeSDK(
//       sdkOption: TcSdkOptions.OPTION_VERIFY_ALL_USERS,
//       consentHeadingOption: TcSdkOptions.SDK_CONSENT_HEADING_LOG_IN_TO,
//       footerType: TcSdkOptions.FOOTER_TYPE_ANOTHER_MOBILE_NO,
//     );

//     // Check if Truecaller is usable
//     bool isUsable = await TcSdk.isOAuthFlowUsable;

//     if (isUsable) {
//       setState(() {
//         _statusMessage = "Truecaller is usable";
//       });

//       // Set OAuth state and scopes
//       String oAuthState = "unique_state_123";
//       TcSdk.setOAuthState(oAuthState);
//       TcSdk.setOAuthScopes(['profile', 'phone', 'openid']);

//       // Generate code verifier and challenge
//       String codeVerifier = await TcSdk.generateRandomCodeVerifier;
//       String codeChallenge = await TcSdk.generateCodeChallenge(codeVerifier);

//       // Set code challenge and get authorization code
//       TcSdk.setCodeChallenge(codeChallenge);
//       TcSdk.getAuthorizationCode;

//       // Listen for callbacks
//       _truecallerSubscription = TcSdk.streamCallbackData.listen((callback) {
//         switch (callback.result) {
//           case TcSdkCallbackResult.success:
//             String authCode = callback.tcOAuthData!.authorizationCode;
//             setState(() {
//               _statusMessage = "Authorization Code: $authCode";
//             });
//             // Call your backend API to exchange authCode for access token
//             break;
//           case TcSdkCallbackResult.failure:
//             setState(() {
//               _statusMessage = "Error: ${callback.error!.message}";
//             });
//             break;
//           case TcSdkCallbackResult.verification:
//             // Handle manual verification
//             TcSdk.requestVerification(phoneNumber: "+91XXXXXXXXXX");
//             break;
//           case TcSdkCallbackResult.otpReceived:
//             // Handle OTP received
//             String otp = callback.otp!;
//             TcSdk.verifyOtp(otp: otp, firstName: "User", lastName: "Name");
//             break;
//           default:
//             break;
//         }
//       });
//     } else {
//       setState(() {
//         _statusMessage = "Truecaller is not usable";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Truecaller Login Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               _statusMessage,
//               style: TextStyle(fontSize: 18),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 // Request phone permission
//                 var status = await Permission.phone.request();
//                 if (status.isGranted) {
//                   _initializeTruecallerSDK();
//                 } else {
//                   setState(() {
//                     _statusMessage = "Phone permission denied";
//                   });
//                 }
//               },
//               child: Text('Start Truecaller Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }