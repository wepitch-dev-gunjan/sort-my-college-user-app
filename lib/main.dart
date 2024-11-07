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


// class ScrollableDates extends StatefulWidget {
//   const ScrollableDates({super.key});
//   @override
//   ScrollableDatesState createState() => ScrollableDatesState();
// }

// class ScrollableDatesState extends State<ScrollableDates> {
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
//             DateTime? picked = await showModalBottomSheet(
//               backgroundColor: Colors.white,
//               context: context,
//               isScrollControlled: true,
//               builder: (BuildContext context) {
//                 return SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: CalendarDatePicker(
//                           initialDate: currentDate,
//                           firstDate: currentDate,
//                           lastDate: currentDate.add(const Duration(days: 365)),
//                           onDateChanged: (date) {
//                             Navigator.pop(context, date);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
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
//                   DateFormat('dd MMM yyyy').format(selectedDate),
//                   style: GoogleFonts.inter(
//                       fontSize: 13 * ffem, fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



class ScrollableDates extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const ScrollableDates({super.key, required this.onDateSelected});

  @override
  ScrollableDatesState createState() => ScrollableDatesState();
}

class ScrollableDatesState extends State<ScrollableDates> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
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
                    widget.onDateSelected(selectedDate); // Pass the date
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedDate == date ? const Color(0xff1F0A68) : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('dd MMM').format(date),
                          style: GoogleFonts.inter(
                            color: selectedDate == date ? Colors.white : Colors.black,
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          DateFormat('EEE').format(date).toUpperCase(),
                          style: GoogleFonts.inter(
                            color: selectedDate == date ? Colors.white : const Color(0xff828080),
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                          ),
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
            DateTime? picked = await showModalBottomSheet<DateTime>(
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
              widget.onDateSelected(selectedDate); // Pass the date
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
                    fontSize: 13 * ffem,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
