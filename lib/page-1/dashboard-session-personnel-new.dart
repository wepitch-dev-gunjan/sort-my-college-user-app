import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:myapp/booking_page/checkout_screen.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/counsellor_sessions.dart';
import '../other/provider/counsellor_details_provider.dart';
import 'dart:developer' as console show log;

class Counseling_Session_Personnel extends StatefulWidget {
  const Counseling_Session_Personnel(
      {super.key,
      required this.name,
      required this.id,
      required this.designation,
      required this.profilepic});

  final String name;
  final String id;
  final String designation;
  final String profilepic;

  @override
  State<Counseling_Session_Personnel> createState() =>
      _Counseling_Session_PersonnelState();
}

class _Counseling_Session_PersonnelState
    extends State<Counseling_Session_Personnel>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  SessionDate sessionDate = SessionDate();
  String selectedDate = Jiffy.now().format(pattern: "d MMM");
  String selectedSessionDate = Jiffy.now().format(pattern: "dd/M/yyyy");
  late Razorpay razorpay;
  String key = "";

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    sessionDate.getDates();
    tabController =
        TabController(length: sessionDate.dates.length, vsync: this);
    configLoading();
    fetchDataFromApi();

    context
        .read<CounsellorDetailsProvider>()
        .fetchCounsellor_session(id: widget.id);
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..textColor = Colors.black
      ..radius = 20
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.white
      ..indicatorColor = const Color(0xff1f0a68)
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.circle;
  }

  void fetchDataFromApi() {
    var date = Jiffy.now().format(pattern: "yyyy-M-d");
    context.read<CounsellorDetailsProvider>().fetchCounsellor_session_perssonel(
        id: widget.id, date: date, sessionType: "Personal");
  }

  void fetchDataFromApiAll() {
    var date = Jiffy.now().format(pattern: "yyyy-M-d");
    context.read<CounsellorDetailsProvider>().fetchCounsellor_session_perssonel(
        id: widget.id, date: date, sessionType: "Personal");
  }

  @override
  Widget build(BuildContext context) {
    var counsellorSessionProvider = context.watch<CounsellorDetailsProvider>();
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return counsellorSessionProvider.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 14 * fem,
                        top: 20,
                        child: SizedBox(
                            width: 400 * fem,
                            height: 45 * fem,
                            child: TabBar(
                                indicatorColor: const Color(0xff1F0A68),
                                indicatorWeight: 3,
                                controller: tabController,
                                isScrollable: true,
                                tabs: sessionDate.dates.map((e) {
                                  return GestureDetector(
                                    onTap: () {
                                      tabController.animateTo(e.index);
                                      String date = Jiffy.parse(e.date,
                                              pattern: "d MMM yyyy")
                                          .format(pattern: "yyyy-M-d");
                                      selectedSessionDate = Jiffy.parse(date)
                                          .format(pattern: "dd/M/yyyy");
                                      console.log(date);
                                      selectedDate = e.formattedDate;
                                      context
                                          .read<CounsellorDetailsProvider>()
                                          .fetchCounsellor_session(
                                              id: widget.id,
                                              date: date,
                                              sessionType: "Personal");
                                      context
                                          .read<CounsellorDetailsProvider>()
                                          .fetchCounsellor_session(
                                              id: widget.id);
                                    },
                                    child: SizedBox(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Center(
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    7 * fem,
                                                    0 * fem),
                                                child: Text(
                                                  '${e.index == 0 ? "Today" : e.index == 1 ? "Tomorrow" : e.day}, ${e.formattedDate}',
                                                  textAlign: TextAlign.center,
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2125 * ffem / fem,
                                                    letterSpacing:
                                                        0.59375 * fem,
                                                    color: e.day == "Sun"
                                                        ? Colors.red
                                                        : const Color(
                                                            0xff000000),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                isDateIsSame(
                                                        e.formattedDate,
                                                        counsellorSessionProvider
                                                                .allDetails
                                                                .sessions ??
                                                            [])
                                                    ? slotCount(
                                                                e.formattedDate,
                                                                counsellorSessionProvider
                                                                        .allDetails
                                                                        .sessions ??
                                                                    []) ==
                                                            ""
                                                        ? "No Slots"
                                                        : "${slotCount(e.formattedDate, counsellorSessionProvider.allDetails.sessions ?? [])} Slots"
                                                    : "No Slots",
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont('Inter',
                                                    fontSize: 12 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.2125 * ffem / fem,
                                                    letterSpacing:
                                                        0.59375 * fem,
                                                    color: isDateIsSame(
                                                            e.formattedDate,
                                                            counsellorSessionProvider
                                                                    .allDetails
                                                                    .sessions ??
                                                                [])
                                                        ? slotCount(
                                                                    e
                                                                        .formattedDate,
                                                                    counsellorSessionProvider
                                                                            .allDetails
                                                                            .sessions ??
                                                                        []) ==
                                                                ""
                                                            ? Colors.red
                                                            : Colors.green
                                                        : Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList())),
                      ),
                      Positioned(
                        // bookyourslotnzU (1779:1252)
                        left: 30 * fem,
                        top: 80.5 * fem,
                        child: Align(
                          child: SizedBox(
                            width: 220 * fem,
                            height: 20 * fem,
                            child: Text(
                              'Book Your Slot',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2125 * ffem / fem,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: counsellorSessionProvider
                                  .allDetails.totalAvailableSlots ==
                              -1 ||
                          counsellorSessionProvider
                                  .details.totalAvailableSlots ==
                              -1
                      ? Builder(builder: (context) {
                          if (counsellorSessionProvider
                                      .allDetails.totalAvailableSlots ==
                                  -1 ||
                              counsellorSessionProvider
                                      .details.totalAvailableSlots ==
                                  -1) {
                            EasyLoading.showToast(
                              "404 Page Not Found!",
                              toastPosition: EasyLoadingToastPosition.bottom,
                            );
                          }
                          return const Center(
                            child: Text("Something went wrong!"),
                          );
                        })
                      : counsellorSessionProvider.details.sessions == null
                          ? const Center(
                              child: /*CircularProgressIndicator(
                               valueColor:AlwaysStoppedAnimation<Color>(Colors.red)
                            )*/
                                  Text("No Sessions Available"),
                            )
                          : counsellorSessionProvider.details.sessions!.isEmpty
                              ? const Center(
                                  child: Text("No Sessions Available"),
                                )
                              : ListView.builder(
                                  itemCount: counsellorSessionProvider
                                      .details.sessions!.length,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    dynamic bookedslot =
                                        counsellorSessionProvider.details
                                                .sessions![index].sessionSlots -
                                            counsellorSessionProvider
                                                .details
                                                .sessions![index]
                                                .sessionAvailableSlots;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Card(
                                        color: ColorsConst.whiteColor,
                                        surfaceTintColor:
                                            ColorsConst.whiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 19.5, vertical: 15),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const Text(
                                                    'Session',
                                                    style: TextStyle(
                                                      color: Color(0xFF1F0A68),
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 0,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 45.51,
                                                    height: 19,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                          0xFFB1A0EA),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(99),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        ' ${bookedslot.toString()} / ${counsellorSessionProvider.details.sessions![index].sessionSlots}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        selectedSessionDate,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        counsellorSessionProvider
                                                                    .details
                                                                    .sessions?[
                                                                        index]
                                                                    .sessionTime !=
                                                                null
                                                            ? '${(counsellorSessionProvider.details.sessions![index].sessionTime! ~/ 60) % 12 == 0 ? 12 : (counsellorSessionProvider.details.sessions![index].sessionTime! ~/ 60) % 12}:${(counsellorSessionProvider.details.sessions![index].sessionTime! % 60).toString().padLeft(2, '0')} ${(counsellorSessionProvider.details.sessions![index].sessionTime! ~/ 60) < 12 ? 'AM' : 'PM'}'
                                                            : 'N/A',
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),

                                                      // Text(
                                                      //   counsellorSessionProvider
                                                      //               .details
                                                      //               .sessions?[
                                                      //                   index]
                                                      //               .sessionTime !=
                                                      //           null
                                                      //       ? DateFormat(
                                                      //               'h:mm a')
                                                      //           .format(
                                                      //           DateTime
                                                      //               .fromMillisecondsSinceEpoch(
                                                      //             counsellorSessionProvider
                                                      //                 .details
                                                      //                 .sessions![
                                                      //                     index]
                                                      //                 .sessionTime!,
                                                      //             isUtc: true,
                                                      //           ).toLocal(),
                                                      //         )
                                                      //       : 'N/A',
                                                      //   style: const TextStyle(
                                                      //     color: Colors.black,
                                                      //     fontSize: 12,
                                                      //     fontFamily: 'Inter',
                                                      //     fontWeight:
                                                      //         FontWeight.w400,
                                                      //     height: 0,
                                                      //   ),
                                                      // ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Price - ${counsellorSessionProvider.details.sessions?[index].sessionPrice ?? "0"} /-',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 0,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          isExpanded =
                                                              !isExpanded;
                                                          setState(() {});
                                                        },
                                                        child: const Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              'View Details',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Inter',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                height: 0,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 15,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      isExpanded
                                                          ? Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "Name : ${widget.name}"),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                    "Slots : ${counsellorSessionProvider.details.sessions?[index].sessionSlots ?? "0"}"),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                    "Duration : ${counsellorSessionProvider.details.sessions?[index].sessionDuration ?? "0"}"),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                    "Session Status : ${counsellorSessionProvider.details.sessions?[index].sessionStatus ?? "N/A"}"),
                                                              ],
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    /*onTap: ()
                                                    {
                                                      EasyLoading.show(
                                                          status: "Loading...",
                                                          dismissOnTap: false);
                                                      ApiService.sessionBooked(
                                                              counsellorSessionProvider
                                                                  .details
                                                                  .sessions![
                                                                      index]
                                                                  .id!)
                                                          .then((value) {
                                                        if (value["message"] ==
                                                            "Counseling session booked successfully") {
                                                          EasyLoading.showToast(
                                                              value["message"],
                                                              toastPosition:
                                                                  EasyLoadingToastPosition
                                                                      .bottom);
                                                          context
                                                              .read<
                                                                  CounsellorDetailsProvider>()
                                                              .fetchCounsellor_session(
                                                                  id: widget
                                                                      .id);
                                                          var date = Jiffy.parse(
                                                                  counsellorSessionProvider
                                                                      .details
                                                                      .sessions![
                                                                          index]
                                                                      .sessionDate!)
                                                              .format(
                                                                  pattern:
                                                                      "yyyy-M-d");
                                                          context
                                                              .read<
                                                                  CounsellorDetailsProvider>()
                                                              .fetchCounsellor_session(
                                                                  id: widget.id,
                                                                  sessionType:
                                                                      "Personal",
                                                                  date: date);
                                                          setState(() {});
                                                        } else {
                                                          EasyLoading.showToast(
                                                              value["error"],
                                                              toastPosition:
                                                                  EasyLoadingToastPosition
                                                                      .bottom);
                                                        }
                                                      });
                                                    },*/
                                                    child: Container(
                                                      width: 96,
                                                      height: 38,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: const Color(
                                                            0xFF1F0A68),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side:
                                                              const BorderSide(
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            SharedPreferences
                                                                sPref =
                                                                await SharedPreferences
                                                                    .getInstance();
                                                            var id =
                                                                counsellorSessionProvider
                                                                    .details
                                                                    .sessions?[
                                                                        index]
                                                                    .id;
                                                            sPref.setString(
                                                                'sessionid',
                                                                id!);

                                                            var sessionSlots =
                                                                counsellorSessionProvider
                                                                    .details
                                                                    .sessions![
                                                                        index]
                                                                    .sessionSlots!;
                                                            var sessionAvailableSlots =
                                                                counsellorSessionProvider
                                                                    .details
                                                                    .sessions![
                                                                        index]
                                                                    .sessionAvailableSlots!;

                                                            if (sessionAvailableSlots <=
                                                                0) {
                                                              EasyLoading.showToast(
                                                                  'There are no booking slots available in this session, please book another session',
                                                                  toastPosition:
                                                                      EasyLoadingToastPosition
                                                                          .bottom);
                                                            } else {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) {
                                                                return CheckOutScreen(
                                                                    name: widget
                                                                        .name,
                                                                    id: id,
                                                                    designation:
                                                                        widget
                                                                            .id,
                                                                    profilepicurl:
                                                                        widget
                                                                            .profilepic);
                                                              }));
                                                            }
                                                          },
                                                          child: const Text(
                                                            'Book',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              height: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );

                                    // return Container(
                                    //   // group193fip (I2510:2510;2510:2244)
                                    //   margin: EdgeInsets.fromLTRB(
                                    //       10 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    //   padding: EdgeInsets.fromLTRB(
                                    //       5 * fem, 0.5 * fem, 5 * fem, 16 * fem),
                                    //   width: double.infinity,

                                    //   child: Column(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       Container(
                                    //         width: 350,
                                    //         height: 130,
                                    //         decoration: ShapeDecoration(
                                    //           color: Colors.white,
                                    //           shape: RoundedRectangleBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(20),
                                    //           ),
                                    //           shadows: const [
                                    //             BoxShadow(
                                    //               color: Color(0x3F000000),
                                    //               blurRadius: 5,
                                    //               offset: Offset(0, 0),
                                    //               spreadRadius: 0,
                                    //             )
                                    //           ],
                                    //         ),
                                    //         child: Row(
                                    //           mainAxisSize: MainAxisSize.min,
                                    //           mainAxisAlignment:
                                    //               MainAxisAlignment.center,
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.center,
                                    //           children: [
                                    //             Container(
                                    //               width: 330,
                                    //               height: 150,
                                    //               child: Stack(
                                    //                 children: [
                                    //                   Positioned(
                                    //                     left: 0,
                                    //                     top: 0,
                                    //                     child: Container(
                                    //                       width: 350,
                                    //                       height: 131,
                                    //                     ),
                                    //                   ),
                                    //                   Positioned(
                                    //                     left: 230,
                                    //                     top: 70,
                                    //                     child: Container(
                                    //                       width: 96,
                                    //                       height: 38,
                                    //                       child: Stack(
                                    //                         children: [
                                    //                           Positioned(
                                    //                             left: 0,
                                    //                             top: 0,
                                    //                             child: Container(
                                    //                               width: 96,
                                    //                               height: 38,
                                    //                               decoration:
                                    //                                   ShapeDecoration(
                                    //                                 color: const Color(
                                    //                                     0xFF1F0A68),
                                    //                                 shape:
                                    //                                     RoundedRectangleBorder(
                                    //                                   side: const BorderSide(
                                    //                                       width:
                                    //                                           1),
                                    //                                   borderRadius:
                                    //                                       BorderRadius.circular(
                                    //                                           10),
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                           const Positioned(
                                    //                             left: 24,
                                    //                             top: 7,
                                    //                             child: Text(
                                    //                               'Book',
                                    //                               textAlign:
                                    //                                   TextAlign
                                    //                                       .center,
                                    //                               style:
                                    //                                   TextStyle(
                                    //                                 color: Colors
                                    //                                     .white,
                                    //                                 fontSize: 18,
                                    //                                 fontFamily:
                                    //                                     'Inter',
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w600,
                                    //                                 height: 0,
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   const Positioned(
                                    //                     left: 19.01,
                                    //                     top: 63,
                                    //                     child: SizedBox(
                                    //                       width: 174.98,
                                    //                       child: Text(
                                    //                         '2:00 PM - 03:00 PM',
                                    //                         style: TextStyle(
                                    //                           color: Colors.black,
                                    //                           fontSize: 12,
                                    //                           fontFamily: 'Inter',
                                    //                           fontWeight:
                                    //                               FontWeight.w400,
                                    //                           height: 0,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   //updated
                                    //                   Positioned(
                                    //                     left: 19.01,
                                    //                     top: 81,
                                    //                     child: SizedBox(
                                    //                       width: 78.89,
                                    //                       child: Text(
                                    //                         'Price - ${counsellorSessionProvider.details.sessions![index].sessionPrice} /-',
                                    //                         textAlign:
                                    //                             TextAlign.center,
                                    //                         style:
                                    //                             const TextStyle(
                                    //                           color: Colors.black,
                                    //                           fontSize: 12,
                                    //                           fontFamily: 'Inter',
                                    //                           fontWeight:
                                    //                               FontWeight.w500,
                                    //                           height: 0,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   Positioned(
                                    //                     left: 18,
                                    //                     top: 98,
                                    //                     child: SizedBox(
                                    //                       width: 97,
                                    //                       height: 17,
                                    //                       child: Stack(
                                    //                         children: [
                                    //                           Positioned(
                                    //                             left: 80,
                                    //                             top: 17,
                                    //                             child: Transform(
                                    //                               transform: Matrix4
                                    //                                   .identity()
                                    //                                 ..translate(
                                    //                                     0.0, 0.0)
                                    //                                 ..rotateZ(
                                    //                                     -1.57),
                                    //                               child:
                                    //                                   Container(
                                    //                                 width: 17,
                                    //                                 height: 17,
                                    //                                 decoration:
                                    //                                     const BoxDecoration(
                                    //                                   image:
                                    //                                       DecorationImage(
                                    //                                     image: AssetImage(
                                    //                                         'assets/page-1/images/arrow-down-2.png'),
                                    //                                     fit: BoxFit
                                    //                                         .fill,
                                    //                                   ),
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                           Positioned(
                                    //                             left: 0,
                                    //                             top: 1,
                                    //                             child: SizedBox(
                                    //                               width: 150,
                                    //                               child:
                                    //                                   GestureDetector(
                                    //                                 onTap: () {
                                    //                                   isExpanded =
                                    //                                       !isExpanded;
                                    //                                 },
                                    //                                 child: Column(
                                    //                                   crossAxisAlignment:
                                    //                                       CrossAxisAlignment
                                    //                                           .start,
                                    //                                   children: [
                                    //                                     Text(
                                    //                                       'View Details',
                                    //                                       textAlign:
                                    //                                           TextAlign.left,
                                    //                                       style:
                                    //                                           TextStyle(
                                    //                                         color:
                                    //                                             Colors.black,
                                    //                                         fontSize:
                                    //                                             12,
                                    //                                         fontFamily:
                                    //                                             'Inter',
                                    //                                         fontWeight:
                                    //                                             FontWeight.w800,
                                    //                                         height:
                                    //                                             0,
                                    //                                       ),
                                    //                                     ),
                                    //                                   ],
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   Positioned(
                                    //                     left: 19.01,
                                    //                     top: 15,
                                    //                     child: Container(
                                    //                       width: 352.99,
                                    //                       height: 24,
                                    //                       child: Stack(
                                    //                         children: [
                                    //                           Positioned(
                                    //                             left: 260.47,
                                    //                             top: 3,
                                    //                             child: Container(
                                    //                               width: 45.51,
                                    //                               height: 19,
                                    //                               child: Stack(
                                    //                                 children: [
                                    //                                   Positioned(
                                    //                                     left: 0,
                                    //                                     top: 0,
                                    //                                     child:
                                    //             Container(
                                    //           width:
                                    //               45.51,
                                    //           height:
                                    //               19,
                                    //           decoration:
                                    //               ShapeDecoration(
                                    //             color:
                                    //                 const Color(0xFFB1A0EA),
                                    //             shape:
                                    //                 RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(99),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Positioned(
                                    //         left: 5,
                                    //         top: 2,
                                    //         child:
                                    //             Text(
                                    //           '${counsellorSessionProvider.details.sessions![index].sessionAvailableSlots}/${counsellorSessionProvider.details.sessions![index].sessionSlots}',
                                    //           style:
                                    //               const TextStyle(
                                    //             color:
                                    //                 Colors.white,
                                    //             fontSize:
                                    //                 13,
                                    //             fontFamily:
                                    //                 'Inter',
                                    //             fontWeight:
                                    //                 FontWeight.w500,
                                    //             height:
                                    //                 0,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // ),
                                    //                           const Positioned(
                                    //                             left: 0,
                                    //                             top: 0,
                                    //                             child: SizedBox(
                                    //                               width: 198.24,
                                    //                               child: Text(
                                    //                                 'Coming soon',
                                    //                                 style:
                                    //                                     TextStyle(
                                    //                                   color: Color(
                                    //                                       0xFF1F0A68),
                                    //                                   fontSize:
                                    //                                       20,
                                    //                                   fontFamily:
                                    //                                       'Inter',
                                    //                                   fontWeight:
                                    //                                       FontWeight
                                    //                                           .w600,
                                    //                                   height: 0,
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           ),
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   Positioned(
                                    //                     left: 19.01,
                                    //                     top: 43,
                                    //                     child: SizedBox(
                                    //                       width: 67.77,
                                    //                       height: 16,
                                    //                       child: Text(
                                    //                         selectedDate,
                                    //                         textAlign:
                                    //                             TextAlign.center,
                                    //                         style:
                                    //                             const TextStyle(
                                    //                           color: Colors.black,
                                    //                           fontSize: 12,
                                    //                           fontFamily: 'Inter',
                                    //                           fontWeight:
                                    //                               FontWeight.w400,
                                    //                           height: 0,
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // );
                                  }),
                ),
              ],
            ),
          );
  }

  callme() async {
    await Future.delayed(const Duration(seconds: 3));
    const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red));
  }

  Future<bool> _onBackPressed() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePageContainer_2()),
    );
    return true;
  }
}

List<String> sampleViewDetails = [
  "\u2022 name:",
  "\u2022 slots:",
  "\u2022 duration:",
];

bool isDateIsSame(String date, List<Sessions> sessions) {
  for (final element in sessions) {
    var apiDate = Jiffy.parse(element.sessionDate!).format(pattern: "d MMM");
    if (date.contains(apiDate)) {
      console.log("yess");
      return true;
    }
  }
  console.log("nope");

  return false;
}

String slotCount(String date, List<Sessions> sessions) {
  for (final element in sessions) {
    var apiDate = Jiffy.parse(element.sessionDate!).format(pattern: "d MMM");

    if (element.sessionType == "Personal") {
      if (date.contains(apiDate)) {
        return element.sessionAvailableSlots.toString();
      }
    }
  }

  return "";
}
