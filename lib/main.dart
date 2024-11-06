import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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

// class VisitScheduleBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.pop(context),
//       child: Container(
//         color: Colors.black.withOpacity(0.5),
//         child: GestureDetector(
//           onTap: () {},
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Visit schedule',
//                   style: TextStyle(
//                     color: Colors.purple,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   'When are you planning to visit?',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 ScrollableDates(),
//                 const SizedBox(height: 16),
//                 const TextField(
//                   decoration: InputDecoration(
//                     labelText: 'Additional details',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     disabledForegroundColor: Colors.purple,
//                     minimumSize: const Size(double.infinity, 48),
//                   ),
//                   onPressed: () {
//                     // Handle confirm action
//                   },
//                   child: const Text('CONFIRM'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ScrollableDates extends StatefulWidget {
//   const ScrollableDates({super.key});
//   @override
//   _ScrollableDatesState createState() => _ScrollableDatesState();
// }

// class _ScrollableDatesState extends State<ScrollableDates> {
//   DateTime currentDate = DateTime.now();
//   DateTime selectedDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 460;
//     double width = MediaQuery.of(context).size.width;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;
//     return Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: 7,
//               itemBuilder: (context, index) {
//                 DateTime date = currentDate.add(Duration(days: index));
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedDate = date;
//                     });
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 2),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: selectedDate == date
//                           ? const Color(0xff1F0A68)
//                           : Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           DateFormat('dd MMM').format(date),
//                           style: GoogleFonts.inter(
//                               color: selectedDate == date
//                                   ? Colors.white
//                                   : Colors.black,
//                               fontSize: 16 * ffem,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         Text(
//                           DateFormat('EEE').format(date).toUpperCase(),
//                           style: GoogleFonts.inter(
//                               color: selectedDate == date
//                                   ? Colors.white
//                                   : const Color(0xff828080),
//                               fontSize: 14 * ffem,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         GestureDetector(
//           onTap: () async {
//             DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: currentDate,
//               firstDate: currentDate,
//               lastDate: currentDate.add(const Duration(days: 365)),
//               builder: (BuildContext context, Widget? child) {
//                 return Theme(
//                   data: ThemeData.light().copyWith(
//                     // primaryColor: Colors.red,

//                     colorScheme:
//                         const ColorScheme.light(primary: Color(0xff1F0A68)),
//                     buttonTheme: const ButtonThemeData(
//                         textTheme: ButtonTextTheme.primary), // Button color
//                   ),
//                   child: child ?? const SizedBox.shrink(), // Provide a fallback
//                 );
//               },
//             );

//             if (picked != null) {
//               setState(() {
//                 selectedDate = picked;
//               });
//             }
//           },
//           child: Container(
//             height: 60,
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Column(
//               children: [
//                 const Icon(
//                   Icons.calendar_today,
//                   color: Color(0xff1F0A68),
//                 ),
//                 Text(
//                   "Select Date",
//                   style: GoogleFonts.inter(
//                       fontSize: 13 * ffem, fontWeight: FontWeight.w600),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ScrollableDates extends StatefulWidget {
  const ScrollableDates({super.key});
  @override
  ScrollableDatesState createState() => ScrollableDatesState();
}

class ScrollableDatesState extends State<ScrollableDates> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                DateTime date = currentDate.add(Duration(days: index));
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedDate == date
                          ? const Color(0xff1F0A68)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('dd MMM').format(date),
                          style: GoogleFonts.inter(
                              color: selectedDate == date
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          DateFormat('EEE').format(date).toUpperCase(),
                          style: GoogleFonts.inter(
                              color: selectedDate == date
                                  ? Colors.white
                                  : const Color(0xff828080),
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      Expanded(
                        child: CalendarDatePicker(
                          initialDate: currentDate,
                          firstDate: currentDate,
                          lastDate: currentDate.add(const Duration(days: 365)),
                          onDateChanged: (date) {
                            Navigator.pop(context, date);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );

            if (picked != null) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Color(0xff1F0A68),
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(selectedDate),
                  style: GoogleFonts.inter(
                      fontSize: 13 * ffem, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
