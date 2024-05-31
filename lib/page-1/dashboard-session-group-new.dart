import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jiffy/jiffy.dart';
import 'package:myapp/booking_page/checkout_screen.dart';
import 'package:myapp/home_page/homepagecontainer_2.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../booking_page/booking_page.dart';
import '../model/counsellor_sessions.dart';
import '../other/provider/counsellor_details_provider.dart';
import 'dart:developer' as console show log;

class Counseling_Session_group extends StatefulWidget {
  const Counseling_Session_group(
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
  State<Counseling_Session_group> createState() =>
      _Counseling_Session_groupState();
}

class _Counseling_Session_groupState extends State<Counseling_Session_group>
    with SingleTickerProviderStateMixin {
//phone pe  members
// SANDBOX
// PRODUCTION
  late int bookedslot;
  String environment = "PRODUCTION";
  String appId = "";
  String merchantId = "SORTMYCOLLONLINE";

// PGTESTPAYUAT
// SORTMYCOLLONLINE
  bool enableLogging = true;
  String saltKey = "fd064c88-80c4-4ef1-bf9f-0628189916a5";
  String saltIndex = "2";
  String checkSum = "";
  String callBackUrl =
      "https://webhook.site/a53375c1-0ed6-432e-8c25-ad324fed6c2a";
  String body = "";
  Object? result;
  String apiEndPoint = "/pg/v1/pay";
  String? packageName = 'com.sortmycollege';

  //widget members
  bool isExpanded = false;
  SessionDate sessionDate = SessionDate();
  String selectedDate = Jiffy.now().format(pattern: "d MMM");
  String selectedSessionDate = Jiffy.now().format(pattern: "dd/M/yyyy");

  late Razorpay razorpay;
  String key = "";

  void startPgTransaction(String? id, String? sessionDate, sessionPrice) {
    /* try {
      body = getCheckSum(sessionPrice);
      var response = PhonePePaymentSdk.startTransaction(
          body, callBackUrl, checkSum, packageName);
      response.then((val) {
        setState(() {
          if (val != null) {
            String status = val["status"].toString();
            String error = val["error"].toString();
            if (status == "SUCCESS") {
              AppConst1.showToast("Payment Successfully");
              EasyLoading.show(
                  status: "Loading...",
                  dismissOnTap: false);
              ApiService.sessionBooked(
                  id!)
                  .then((value) {
                if (value["message"] ==
                    "Counseling session booked successfully") {
                  EasyLoading.showToast(
                      value["message"],
                      toastPosition:
                      EasyLoadingToastPosition.bottom);
                  context
                      .read<CounsellorDetailsProvider>()
                      .fetchCounsellor_session(
                      id: widget.id);
                  var date = Jiffy.parse(
                      sessionDate!)
                      .format(
                      pattern: "yyyy-M-d");
                  context
                      .read<CounsellorDetailsProvider>()
                      .fetchCounsellor_session(
                      id: widget.id,
                      sessionType: "Group",
                      date: date);
                  setState(() {});
                } else {
                  EasyLoading.showToast(
                      value["error"],
                      toastPosition:
                      EasyLoadingToastPosition.bottom);
                }
              });
            } else {
              AppConst1.showToast("Transaction failed please try again $error");
              print('Error:    ${error}');
            }
          }
        });
      }).catchError((error) {
        handleError(error);
        AppConst1.showToast("Transaction failed please try again $error");
        print('Error:    ${error}');
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
      AppConst1.showToast("Transaction failed please try again $error");
    }*/
  }

  void PhonePayInit() {
    /* PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
        print(result);
        //handleException: Invalid appId!
      })
    })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });*/
  }

  // void startPgTransaction() {
  //   try {
  //     body = getCheckSum();
  //     var response = PhonePePaymentSdk.startTransaction(
  //         body, callBackUrl, checkSum, packageName);
  //     response.then((val) {
  //       setState(() {
  //         if (val != null) {
  //           String status = val["status"].toString();
  //           String error = val["error"].toString();
  //         }
  //       });
  //     }).catchError((error) {
  //       handleError(error);
  //       AppConst1.showToast("Transaction failed please try again $error");
  //       print('Error:    ${error}');
  //       return <dynamic>{};
  //     });
  //   } catch (error) {
  //     handleError(error);
  //     AppConst1.showToast("Transaction failed please try again $error");
  //   }
  // }

  // getCheckSum(sessionPrice) {
  //   var requestData = {
  //     "merchantId": merchantId,
  //     "merchantTransactionId": "transaction_123",
  //     "merchantUserId": "90223250",
  //     "amount": 100,
  //     "mobileNumber": "9999999999",
  //     "callbackUrl": callBackUrl,
  //     "paymentInstrument": {
  //       "type": "PAY_PAGE",
  //     },
  //   };
  //   String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
  //   checkSum =
  //   "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";
  //
  //   return base64Body;
  // }

  getCheckSum(int sessionPrice) {
    int price = int.parse(sessionPrice.toString());
    price * 100;
    // String strPrice = price.toString();
    String strPrice = '1';
    var requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": strPrice,
      "mobileNumber": "9999999999",
      "callbackUrl": callBackUrl,
      "paymentInstrument": {
        "type": "PAY_PAGE",
      },
    };
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checkSum =
        "${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex";

    return base64Body;
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
    });
  }

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //PhonePayInit();
    // body = getCheckSum();
    sessionDate.getDates();
    tabController =
        TabController(length: sessionDate.dates.length, vsync: this);
    configLoading();
    fetchDataFromApi();

    // Fluttertoast.showToast(msg: "abc");

    //fetchDataFromApiAll();
    context
        .read<CounsellorDetailsProvider>()
        .fetchCounsellor_session(id: widget.id);
  }

  @override
  void onResume() {
    //Fluttertoast.showToast(msg: 'abc');
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
    context.read<CounsellorDetailsProvider>().fetchCounsellor_session(
        id: widget.id, date: date, sessionType: "Group");
  }

  void fetchDataFromApiAll() {
    var date = Jiffy.now().format(pattern: "yyyy-M-d");
    context.read<CounsellorDetailsProvider>().fetchCounsellor_session_all(
        id: widget.id, date: date, sessionType: "Group");
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
                  // frame12Fje (1879:51)
                  width: double.infinity,
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        // frame311tGg (2620:3569)
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
                                              sessionType: "Group");
                                      context
                                          .read<CounsellorDetailsProvider>()
                                          .fetchCounsellor_session(
                                              id: widget.id);
                                    },
                                    child: SizedBox(
                                      // group310VQt (2620:3574)

                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment
                                          //         .center,
                                          children: [
                                            Center(
                                              // today21octT6p (2620:3575)
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
                                              // noslotskrc (2620:3576)
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
                // IconButton(onPressed: (){
                //   startPgTransaction();
                // }, icon: Icon(Icons.add)),
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
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
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
                                                  Text(
                                                    counsellorSessionProvider
                                                            .details
                                                            .sessions![index]
                                                            .sessionUser ??
                                                        'Session',
                                                    style: const TextStyle(
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
                                                            ? '${(counsellorSessionProvider.details.sessions![index].sessionTime! ~/ 60) % 12}:${(counsellorSessionProvider.details.sessions![index].sessionTime! % 60).toString().padLeft(2, '0')} ${(counsellorSessionProvider.details.sessions![index].sessionTime! ~/ 60) < 12 ? 'AM' : 'PM'}'
                                                            : 'N/A',

                                                        // counsellorSessionProvider
                                                        //             .details
                                                        //             .sessions?[
                                                        //                 index]
                                                        //             .sessionTime !=
                                                        //         null
                                                        //     ? DateFormat(
                                                        //             'h:mm a')
                                                        //         .format(DateTime.fromMillisecondsSinceEpoch(
                                                        //             counsellorSessionProvider
                                                        //                 .details
                                                        //                 .sessions![
                                                        //                     index]
                                                        //                 .sessionTime!))
                                                        //     : 'N/A',
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
                                                        'Price - ${counsellorSessionProvider.details.sessions?[index].sessionPrice} /-',
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
                                                    onTap: () async {
                                                      SharedPreferences sPref =
                                                          await SharedPreferences
                                                              .getInstance();

                                                      var id =
                                                          counsellorSessionProvider
                                                              .details
                                                              .sessions?[index]
                                                              .id;
                                                      sPref.setString(
                                                          'sessionid', id!);

                                                      /*Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  CheckOutScreen(
                                                                      designation: widget.designation,
                                                                      name: widget
                                                                          .name,
                                                                      id: id)));*/

                                                      var sessionSlots =
                                                          counsellorSessionProvider
                                                              .details
                                                              .sessions![index]
                                                              .sessionSlots!;
                                                      var sessionAvailableSlots =
                                                          counsellorSessionProvider
                                                              .details
                                                              .sessions![index]
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
                                                            builder: (context) {

                                                              return CheckOutScreen(
                                                                  designation:
                                                                      widget
                                                                          .designation,
                                                                  name: widget
                                                                      .name,
                                                                  profilepicurl:
                                                                      widget
                                                                          .profilepic,
                                                                  id: widget
                                                                      .id);
                                                            },
                                                          ),
                                                        );

                                                        /* await ApiService.updateBookingSession(id)
                                                            .then((value) => MoveToSessionPage()); */
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 96,
                                                      height: 38,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: counsellorSessionProvider
                                                                    .details
                                                                    .sessions![
                                                                        index]
                                                                    .sessionAvailableSlots! >
                                                                0
                                                            ? const Color(
                                                                0xFF1F0A68)
                                                            : const Color(
                                                                0xFF1F0A68),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'Book',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 0,
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

  MoveToSessionPage() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BookingPage()
            // CounsellingSessionPage(
            //   id: cid,
            //   name: name,
            //   designation: widget.designation,
            //   profileurl: widget.profilepicurl,
            //   selectedIndex_get: 0,)

            ));
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
      // console.log("yess");
      return true;
    }
  }
  //console.log("nope");

  return false;
}

String slotCount(String date, List<Sessions> sessions) {
  for (final element in sessions) {
    var apiDate = Jiffy.parse(element.sessionDate!).format(pattern: "d MMM");

    if (element.sessionType == "Group") {
      if (date.contains(apiDate)) {
        return element.sessionAvailableSlots.toString();
      }
    }
  }

  return "";
}
