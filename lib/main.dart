import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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

class VisitScheduleBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Visit schedule',
                  style: TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'When are you planning to visit?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ScrollableDates(),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Additional details',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledForegroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    // Handle confirm action
                  },
                  child: const Text('CONFIRM'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollableDates extends StatefulWidget {
  @override
  _ScrollableDatesState createState() => _ScrollableDatesState();
}

class _ScrollableDatesState extends State<ScrollableDates> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    padding: const EdgeInsets.all(8.0),
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
                          style: TextStyle(
                            color: selectedDate == date
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          DateFormat('EEE').format(date).toUpperCase(),
                          style: TextStyle(
                            color: selectedDate == date
                                ? Colors.white
                                : const Color(0xff828080),
                            fontSize: 12,
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
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: currentDate,
              firstDate: currentDate,
              lastDate: currentDate.add(const Duration(days: 365)),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Colors.red,

                    colorScheme:
                        const ColorScheme.light(primary: Color(0xff1F0A68)),
                    buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary), // Button color
                  ),
                  child: child ?? const SizedBox.shrink(), // Provide a fallback
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
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('Scrollable Year Calendar'),
//         ),
//         body: const ScrollableYearCalendar(),
//       ),
//     );
//   }
// }

// class ScrollableYearCalendar extends StatefulWidget {
//   const ScrollableYearCalendar({Key? key}) : super(key: key);

//   @override
//   _ScrollableYearCalendarState createState() => _ScrollableYearCalendarState();
// }

// class _ScrollableYearCalendarState extends State<ScrollableYearCalendar> {
//   DateTime _selectedDate = DateTime.now();
//   final ItemScrollController _scrollController = ItemScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 10),
//         // Display the currently selected date
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Selected Date: ${_selectedDate.toLocal().toString().split(' ')[0]}",
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Expanded(
//           child: ScrollablePositionedList.builder(
//             itemScrollController: _scrollController,
//             itemCount: 12,
//             itemBuilder: (context, index) {
//               final month = index + 1;
//               final year = 2024; // You can change the year dynamically as needed
//               return CalendarCard(
//                 year: year,
//                 month: month,
//                 onDaySelected: (selectedDay) {
//                   setState(() {
//                     _selectedDate = selectedDay;
//                   });
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CalendarCard extends StatefulWidget {
//   final int year;
//   final int month;
//   final Function(DateTime) onDaySelected;

//   const CalendarCard({
//     required this.year,
//     required this.month,
//     required this.onDaySelected,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _CalendarCardState createState() => _CalendarCardState();
// }

// class _CalendarCardState extends State<CalendarCard> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   @override
//   Widget build(BuildContext context) {
//     final firstDay = DateTime(widget.year, widget.month, 1);
//     final lastDay = DateTime(widget.year, widget.month + 1, 0);

//     // Ensure the focusedDay is within bounds
//     if (_focusedDay.isAfter(lastDay)) {
//       _focusedDay = lastDay;
//     } else if (_focusedDay.isBefore(firstDay)) {
//       _focusedDay = firstDay;
//     }

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Text(
//                 "${firstDay.month.toString().padLeft(2, '0')} - ${widget.year}",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             TableCalendar(
//               firstDay: firstDay,
//               lastDay: lastDay,
//               focusedDay: _focusedDay,
//               selectedDayPredicate: (day) {
//                 return isSameDay(_selectedDay, day);
//               },
//               onDaySelected: (selectedDay, focusedDay) {
//                 setState(() {
//                   _selectedDay = selectedDay;
//                   _focusedDay = focusedDay;
//                 });
//                 widget.onDaySelected(selectedDay);
//               },
//               headerVisible: false,
//               calendarStyle: CalendarStyle(
//                 isTodayHighlighted: true,
//                 selectedDecoration: BoxDecoration(
//                   color: Colors.blueAccent,
//                   shape: BoxShape.circle,
//                 ),
//                 selectedTextStyle: const TextStyle(color: Colors.white),
//                 defaultTextStyle: const TextStyle(color: Colors.black),
//                 weekendTextStyle: const TextStyle(color: Colors.black),
//                 outsideTextStyle: TextStyle(color: Colors.grey.shade400),
//               ),
//               daysOfWeekStyle: const DaysOfWeekStyle(
//                 weekendStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
