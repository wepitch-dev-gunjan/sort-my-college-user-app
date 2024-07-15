import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';
import 'package:table_calendar/table_calendar.dart';

class SendEnquiryPage extends StatelessWidget {
  const SendEnquiryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const EpAppBar(title: "Allen Career Institute"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomCalendar(),
              const SizedBox(height: 20),
              const CusChips(),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your query',
                  hintStyle: TextStyle(color: Colors.black45),
                ),
                onTapOutside: (_) => FocusScope.of(context).unfocus(),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Btn(
          onTap: () {},
          btnName: "Send Enquiry",
          // ignore: prefer_const_constructors
          btnColor: Color(0XFF1F0A68),
          textColor: Colors.white,
          height: 45,
          borderRadius: 21,
        ),
      ),
    );
  }
}

class CusChips extends StatefulWidget {
  const CusChips({super.key});

  @override
  State<CusChips> createState() => _CusChipsState();
}

class _CusChipsState extends State<CusChips> {
  List<String> timeLst = [
    "10am - 12am",
    "12pm - 2pm",
    "2pm - 4pm",
    "4pm - 6pm",
    "6pm - 8pm",
    "8pm - 10pm",
  ];
  List<bool> isSelectedList = List.generate(6, (index) => false);
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Schedule Your Call',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < timeLst.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelectedList[i] == false) {
                        isSelectedList[i] = true;
                        selectedItems.add(timeLst[i]);
                      } else {
                        isSelectedList[i] = false;
                        selectedItems.remove(timeLst[i]);
                      }
                    });
                    // print(selectedItems);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5.0),
                    height: 30,
                    width: 120.w,
                    decoration: BoxDecoration(
                        color: isSelectedList[i]
                            ? const Color(0xff1F0A68)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(21),
                        border: Border.all(color: const Color(0xff1F0A68))),
                    child: Center(
                        child: Text(
                      timeLst[i],
                      style: TextStyle(
                          color:
                              isSelectedList[i] ? Colors.white : Colors.black),
                    )),
                  ),
                ),
              const SizedBox(width: 10.0)
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    // log("Selected Date$_selectedDay");
    return Column(
      children: [
        Material(
          elevation: 3,
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffB6B2B2), width: 0.2),
                borderRadius: BorderRadius.circular(11)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Select Date For Your Enquiry",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 124, 90, 184),
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: TextStyle(color: Colors.black),
                      weekendTextStyle: TextStyle(color: Color(0xff563EAA)),
                      outsideTextStyle: TextStyle(color: Colors.grey),
                    ),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle:
                          TextStyle(fontSize: 20.0, color: Colors.black),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
