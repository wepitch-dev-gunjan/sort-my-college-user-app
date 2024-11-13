
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// class ScrollableDates extends StatefulWidget {
//   final ValueChanged<DateTime> onDateSelected;

//   const ScrollableDates({super.key, required this.onDateSelected});

//   @override
//   ScrollableDatesState createState() => ScrollableDatesState();
// }

// class ScrollableDatesState extends State<ScrollableDates> {
//   DateTime currentDate = DateTime.now();
//   DateTime selectedDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 460;
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
//                     widget.onDateSelected(selectedDate); // Pass the date
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
//                             color: selectedDate == date
//                                 ? Colors.white
//                                 : Colors.black,
//                             fontSize: 16 * ffem,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           DateFormat('EEE').format(date).toUpperCase(),
//                           style: GoogleFonts.inter(
//                             color: selectedDate == date
//                                 ? Colors.white
//                                 : const Color(0xff828080),
//                             fontSize: 14 * ffem,
//                             fontWeight: FontWeight.w600,
//                           ),
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
//             DateTime? picked = await showModalBottomSheet<DateTime>(
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
//               widget.onDateSelected(selectedDate); // Pass the date
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
//                     fontSize: 13 * ffem,
//                     fontWeight: FontWeight.w600,
//                   ),
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

// class ScrollableDatesState extends State<ScrollableDates> {
//   DateTime currentDate = DateTime.now();
//   DateTime selectedDate = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 460;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;

//     // Generate the list of 7 dates based on the selected date
//     List<DateTime> dateList = List.generate(7, (index) {
//       return selectedDate.add(Duration(days: index));
//     });

//     return Row(
//       children: [
//         Expanded(
//           child: SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: dateList.length,
//               itemBuilder: (context, index) {
//                 DateTime date = dateList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedDate = date;
//                     });
//                     widget.onDateSelected(selectedDate); // Pass the date
//                   },
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: selectedDate == date ? const Color(0xff1F0A68) : Colors.white,
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           DateFormat('dd MMM').format(date),
//                           style: GoogleFonts.inter(
//                             color: selectedDate == date ? Colors.white : Colors.black,
//                             fontSize: 16 * ffem,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           DateFormat('EEE').format(date).toUpperCase(),
//                           style: GoogleFonts.inter(
//                             color: selectedDate == date ? Colors.white : const Color(0xff828080),
//                             fontSize: 14 * ffem,
//                             fontWeight: FontWeight.w600,
//                           ),
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
//             DateTime? picked = await showModalBottomSheet<DateTime>(
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
//                           initialDate: selectedDate,
//                           firstDate: currentDate, // Keep showing dates from today onwards
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
//               widget.onDateSelected(selectedDate); // Pass the date
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
//                     fontSize: 13 * ffem,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



class ScrollableDatesState extends State<ScrollableDates> {
  DateTime currentDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<DateTime> dateList = []; // List to store the visible dates

  @override
  void initState() {
    super.initState();
    // Initialize with the first 7 days starting from today
    dateList = List.generate(7, (index) => currentDate.add(Duration(days: index)));
  }

  void updateDateListFromCalendar(DateTime newDate) {
    setState(() {
      // Update the date list to start from the selected calendar date and add the next 6 days
      dateList = List.generate(7, (index) => newDate.add(Duration(days: index)));
      selectedDate = newDate; // Update selectedDate to the newly chosen date
    });
  }

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
              itemCount: dateList.length,
              itemBuilder: (context, index) {
                DateTime date = dateList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                    widget.onDateSelected(selectedDate);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          DateFormat('EEE').format(date).toUpperCase(),
                          style: GoogleFonts.inter(
                            color: selectedDate == date
                                ? Colors.white
                                : const Color(0xff828080),
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
              // Only update the list if the selected date is outside the initially shown 7 days
              if (!dateList.contains(picked)) {
                updateDateListFromCalendar(picked);
              } else {
                setState(() {
                  selectedDate = picked;
                });
              }
              widget.onDateSelected(selectedDate);
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
