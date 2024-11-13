import 'dart:convert';
import 'dart:developer';
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
          // home: VisitScheduleBottomSheet(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

class Console {
  static data(dynamic responseBody, {String? value}) {
    var encoder = const JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(responseBody);
    const String red = '\x1B[37m';
    const String reset = '\x1B[0m';
    log("${red}value$prettyString$reset");
  }
}



// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final ScrollController _scrollController = ScrollController();
//   bool _showBackArrow = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       setState(() {
//         // Toggle between showing the back arrow if scrolled past a threshold
//         _showBackArrow = _scrollController.position.pixels > 50;
//       });
//     });
//   }

//   void _scrollToAccommodation() {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   void _scrollToStart() {
//     _scrollController.animateTo(
//       0,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 430;
//     double fem = MediaQuery.of(context).size.width / baseWidth;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Scrollable Row Example'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   controller: _scrollController,
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           onTapgotocounsellor(context);
//                         },
//                         child: SizedBox(
//                           height: 110 * fem,
//                           width: 175 * fem,
//                           child: Image.asset(
//                             "assets/page-1/images/find_counsellor.png",
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       GestureDetector(
//                         onTap: () {
//                           onTapgotoEP(context);
//                         },
//                         child: SizedBox(
//                           height: 110 * fem,
//                           width: 175 * fem,
//                           child: Image.asset("assets/page-1/images/Group 793.png"),
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       GestureDetector(
//                         onTap: () {
//                           onTapgotoAccommodation(context);
//                         },
//                         child: SizedBox(
//                           height: 110 * fem,
//                           width: 175 * fem,
//                           child: Image.asset("assets/page-1/images/Group 795.png"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   right: 0,
//                   top: 20,
//                   child: IconButton(
//                     icon: Icon(
//                       _showBackArrow ? Icons.arrow_back : Icons.arrow_forward,
//                       color: const Color(0xff1F0A68),
//                     ),
//                     onPressed: () {
//                       if (_showBackArrow) {
//                         _scrollToStart();
//                       } else {
//                         _scrollToAccommodation();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
