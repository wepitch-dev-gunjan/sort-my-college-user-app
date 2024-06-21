import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/booking_page/booking_page.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_details_screen.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutScreen extends StatefulWidget {
  final String name;
  final String? id;
  final String designation;
  final String profilepicurl;
  final String? sessionId;
  const CheckOutScreen({
    required this.designation,
    required this.name,
    required this.id,
    required this.profilepicurl,
    this.sessionId,
    super.key,
  });

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  DateTime now = DateTime.now();
  late Razorpay razorpay;
  String key = "";
  String oderId = '';
  var str;
  String phoneNumber = '';
  String payment_from = "";
  String cid = "";
  var amount;
  var amt_send;
  var name;
  bool isLoading = true;

  // var sessionId;
  late String gst;
  late String convinence_charge;
  String? sessionType;

  void openCheckOut(var amountt) async {
    amt_send = amountt;
    amount = amountt * 100;

    var options = {
      "key": key,
      "amount": amount,
      "name": "Sort My College",
      "theme.color": "#190E70",
      "currency": "INR",
      "image":
          "data:image/jpeg;base64,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",
      "Prefill": {
        "contact": phoneNumber,
        "email": "test@gmail.com",
      },
      "external": {
        "wallets": ["Paytm"]
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "Payment Success ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);

    await ApiService.counsellor_create_payment(
            cid,
            payment_from,
            oderId,
            response.paymentId!,
            'order',
            amt_send.toString(),
            '0',
            amt_send.toString(),
            'INR',
            'abc@gmail.com',
            "",
            'created',
            0,
            now.toString(),
            key,
            "user",
            'abc@gmail.com',
            phoneNumber,
            'session booking',
            gst,
            convinence_charge,
            sessionType ?? "")
        .then((value) => checkpaymentsucess(value));
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void initState() {
    super.initState();
    getAllInfo();

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void getAllInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString("phone_number") ?? "N/A";
    payment_from = prefs.getString("_id") ?? "";
    cid = prefs.getString("cid") ?? "";

    // latest session ke liye ye change kiya hai
    // sessionId = prefs.getString('sessionid');
    context
        .read<CounsellorDetailsProvider>()
        .fetchCheckOut_Data(widget.sessionId!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log("Session Type=>$sessiontype");

    var counsellorDetailController = context.watch<CounsellorDetailsProvider>();

    sessionType = counsellorDetailController.checkOutDetailsList.isNotEmpty
        ? counsellorDetailController.checkOutDetailsList[0].sessionType
        : null;

    str = counsellorDetailController.checkOutDetailsList.isNotEmpty
        ? counsellorDetailController.checkOutDetailsList[0].sessionDate
            ?.split('T')
        : '';

    // sessionId = counsellorDetailController.checkOutDetailsList.isNotEmpty
    //     ? counsellorDetailController.checkOutDetailsList[0].sessionId.toString()
    //     : '';

    var amount = '';
    if (counsellorDetailController.checkOutDetailsList.isNotEmpty) {
      dynamic totalAmount =
          counsellorDetailController.checkOutDetailsList[0].totalAmount;
      if (totalAmount != null) {
        amount = totalAmount.toString();
      }
    }

    if (counsellorDetailController.checkOutDetailsList.isNotEmpty) {
      gst = counsellorDetailController.checkOutDetailsList[0].gstAmount
          .toString();
    }

    if (counsellorDetailController.checkOutDetailsList.isNotEmpty) {
      convinence_charge = counsellorDetailController
          .checkOutDetailsList[0].gatewayCharge
          .toString();
    }

    name = '';
    if (counsellorDetailController.checkOutDetailsList.isNotEmpty) {
      name = counsellorDetailController.checkOutDetailsList[0].counsellorName ??
          'user';
    }
    var height = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        backgroundColor: ColorsConst.whiteColor,
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: -10,
          backgroundColor: ColorsConst.whiteColor,
          surfaceTintColor: ColorsConst.whiteColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorsConst.appBarColor,
            ),
          ),
          title: const Text(
            'CheckOut',
            style: TextStyle(color: ColorsConst.appBarColor),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 8, top: 30, bottom: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        shadowColor: ColorsConst.whiteColor,
                        color: ColorsConst.whiteColor,
                        surfaceTintColor: ColorsConst.whiteColor,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 18, right: 10),
                          height: 180,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(36),
                                        child: Image.network(
                                          widget.profilepicurl,
                                          height: 78,
                                          width: 76,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        counsellorDetailController
                                                .checkOutDetailsList.isNotEmpty
                                            ? counsellorDetailController
                                                    .checkOutDetailsList[0]
                                                    .counsellorName ??
                                                "N/A"
                                            : "N/A",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        widget.designation,
                                        style: const TextStyle(
                                            color: ColorsConst.black54Color),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Booking Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      Text(str.isNotEmpty ? str[0] : ''),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${counsellorDetailController.checkOutDetailsList.isNotEmpty ? counsellorDetailController.checkOutDetailsList[0].sessionType ?? "N/A" : "N/A"} Session',
                                        style: const TextStyle(
                                          color: ColorsConst.appBarColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            log("id${widget.id}");
                                            return CounsellorDetailsScreen(
                                              id: widget.id!,
                                            );
                                          }));
                                        },
                                        child: Container(
                                          height: 24,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color: ColorsConst.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all()),
                                          child: const Center(
                                              child: Text(
                                            'View Details',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Card(
                        elevation: 4,
                        shadowColor: ColorsConst.whiteColor,
                        color: ColorsConst.whiteColor,
                        surfaceTintColor: ColorsConst.whiteColor,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 12, left: 10, right: 10, bottom: 12),
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Session Type',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    counsellorDetailController
                                            .checkOutDetailsList.isNotEmpty
                                        ? counsellorDetailController
                                                .checkOutDetailsList[0]
                                                .sessionType ??
                                            "N/A"
                                        : "N/A",
                                    style: const TextStyle(
                                      color: ColorsConst.black54Color,
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Session Fees',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\u{20B9}${counsellorDetailController.checkOutDetailsList.isNotEmpty ? counsellorDetailController.checkOutDetailsList[0].sessionFee ?? "N/A" : "N/A"}',
                                    style: const TextStyle(
                                      color: ColorsConst.black54Color,
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'GST',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\u{20B9}${counsellorDetailController.checkOutDetailsList.isNotEmpty ? counsellorDetailController.checkOutDetailsList[0].gstAmount ?? "N/A" : "N/A"}',
                                    style: const TextStyle(
                                      color: ColorsConst.black54Color,
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Gateway Charge',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\u{20B9}${counsellorDetailController.checkOutDetailsList.isNotEmpty ? counsellorDetailController.checkOutDetailsList[0].gatewayCharge ?? "N/A" : "N/A"}',
                                    style: const TextStyle(
                                      color: ColorsConst.black54Color,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Total Amount',
                                    style: TextStyle(
                                        color: ColorsConst.black54Color,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\u{20B9}${counsellorDetailController.checkOutDetailsList.isNotEmpty ? counsellorDetailController.checkOutDetailsList[0].totalAmount ?? "N/A" : "N/A"}',
                                    style: const TextStyle(
                                      color: ColorsConst.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            ColorsConst.appBarColor),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  onPressed: () async {
                                    var valueRes =
                                        await ApiService.bookValidationSession(
                                            widget.sessionId!);
                                    if (valueRes.containsKey("message")) {
                                      EasyLoading.showToast(valueRes["message"],
                                          toastPosition:
                                              EasyLoadingToastPosition.bottom);

                                      var value = await ApiService
                                          .counsellor_create_order(
                                              widget.name,
                                              'abc@gmail.com',
                                              counsellorDetailController
                                                  .checkOutDetailsList[0]
                                                  .totalAmount,
                                              'session booking',
                                              phoneNumber);
                                      if (value["error"] ==
                                          "Order not successfully created") {
                                        EasyLoading.showToast(value["error"],
                                            toastPosition:
                                                EasyLoadingToastPosition
                                                    .bottom);
                                      } else {
                                        (value["message"] ==
                                            "Order successfully created");
                                        EasyLoading.showToast(value["message"],
                                            toastPosition:
                                                EasyLoadingToastPosition
                                                    .bottom);
                                        EasyLoading.showToast(
                                            value["data"]["id"],
                                            toastPosition:
                                                EasyLoadingToastPosition
                                                    .bottom);
                                        if (value["data"]["offer_id"] != null) {
                                          EasyLoading.showToast(
                                              value["data"]["offer_id"],
                                              toastPosition:
                                                  EasyLoadingToastPosition
                                                      .bottom);
                                        }
                                        key = value["data"]["key"];
                                        oderId = value["data"]["id"];
                                        print(key);

                                        num price = counsellorDetailController
                                            .checkOutDetailsList[0].totalAmount;
                                        price = price.toInt();

                                        openCheckOut(price);
                                      }
                                    } else {
                                      EasyLoading.showToast(valueRes["error"],
                                          toastPosition:
                                              EasyLoadingToastPosition.bottom);
                                    }
                                  },
                                  child: const Text(
                                    'Pay Now',
                                    style: TextStyle(
                                        color: ColorsConst.whiteColor),
                                  )),
                            ),
                            SizedBox(height: height * 0.04),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll(
                                            ColorsConst.appBarColor),
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: ColorsConst.whiteColor),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  checkpaymentsucess(Map<String, dynamic> value) async {
    if (value.containsKey("error")) {
      EasyLoading.showToast(value["error"],
          toastPosition: EasyLoadingToastPosition.bottom);
    } else {
      EasyLoading.showToast(value["message"],
          toastPosition: EasyLoadingToastPosition.bottom);

      await ApiService.updateBookingSession(widget.sessionId!)
          .then((value) => MoveToSessionPage());
    }
  }

  MoveToSessionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BookingPage()),
    );
  }
}
