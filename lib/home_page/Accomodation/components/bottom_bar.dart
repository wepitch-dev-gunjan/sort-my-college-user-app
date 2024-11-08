import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myapp/widget/custom_webniar_card_widget.dart';
import '../../../main.dart';
import '../../entrance_preparation/components/commons.dart';
import 'scrollable_date_picker.dart';

class AccommodationBottomBar extends StatefulWidget {
  final dynamic data;

  const AccommodationBottomBar({
    super.key,
    required this.data,
  });

  @override
  State<AccommodationBottomBar> createState() => _AccommodationBottomBarState();
}

class _AccommodationBottomBarState extends State<AccommodationBottomBar> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      height: Platform.isIOS ? 70 : 50,
      width: MediaQuery.of(context).size.width,
      color: const Color(0xffF2F2F2),
      child: Padding(
        padding: EdgeInsets.only(
            left: 35, right: 20, bottom: Platform.isIOS ? 20 : 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Interested?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Btn(
              onTap: () async {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Schedule Visit',
                                          style: GoogleFonts.inter(
                                            fontSize: 22 * ffem,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(
                                              0xff1f0a68,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Card(
                                        color: const Color(0xffF8F8F8),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "When are you planning to visit?",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 20 * ffem,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10.0),
                                                  ScrollableDates(
                                                    onDateSelected: (date) {
                                                      setState(() {
                                                        selectedDate = date;
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(height: 15.0),
                                                  Text(
                                                    "Additional details",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 20 * ffem,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextFormField(
                                              maxLines: 2,
                                              decoration: InputDecoration(
                                                fillColor: Colors.white,
                                                hintText: "Type here....",
                                                hintStyle: GoogleFonts.inter(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xffACACAC),
                                                ),
                                                filled: true,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Btn(
                                          onTap: () async {
                                            if (selectedDate != null) {
                                              Navigator.pop(context);
                                              showModalBottomSheet(
                                                  context: context,
                                                  backgroundColor: Colors.white,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top: Radius.circular(
                                                        20.0,
                                                      ),
                                                    ),
                                                  ),
                                                  isScrollControlled: true,
                                                  builder: (context) {
                                                    return EnquiryBottomSheet(
                                                      data: widget.data,
                                                      width: width,
                                                      ffem: ffem,
                                                      date: selectedDate
                                                          .toString(),
                                                    );
                                                  });
                                            } else {
                                              dateRequired();
                                            }
                                          },
                                          btnName: "CONFIRM",
                                          width: width,
                                          height: 50,
                                          btnColor: const Color(0xff1f0a68),
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 5,
                              child: IconButton(
                                icon: const Icon(Icons.cancel_outlined,
                                    color: Colors.grey),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              btnName: "Schedule Visit",
              textColor: Colors.white,
              height: 40,
              borderRadius: 5.0,
              width: 160.w,
              btnColor: const Color(0xff1F0A68),
            )
          ],
        ),
      ),
    );
  }
}

dateRequired() {
  EasyLoading.showToast("Plese select a date",
      toastPosition: EasyLoadingToastPosition.bottom);
}

class EnquiryBottomSheet extends StatelessWidget {
  final dynamic data;
  final double width;
  final double ffem;
  final String date;

  const EnquiryBottomSheet(
      {super.key,
      required this.width,
      required this.ffem,
      required this.data,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enquiry Sent',
            style: GoogleFonts.inter(
              fontSize: 22 * ffem,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w700,
              color: const Color(0xff1f0a68),
            ),
          ),
          const SizedBox(height: 15.0),
          SizedBox(
            width: width,
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Text(
                      'Ram Niwas PG',
                      style: GoogleFonts.inter(
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    CusTile(
                      ffem: ffem,
                      icon: Icons.date_range,
                      leading: "Date",
                      traling:
                          DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
                    ),
                    const SizedBox(height: 10.0),
                    CusTile(
                      ffem: ffem,
                      icon: Icons.watch_later,
                      leading: "Time",
                      traling: "9AM-12PM",
                    ),
                    const SizedBox(height: 10.0),
                    CusTile(
                      ffem: ffem,
                      icon: Icons.location_on,
                      leading: "Location",
                      traling:
                          "${data['address']['area']} ${data['address']['city']} ${data['address']['state']} ${data['address']['pin_code']}",
                    ),
                    const SizedBox(height: 10.0),
                    CusTile(
                      ffem: ffem,
                      icon: Icons.email,
                      leading: "Gmail",
                      traling: "smc@gmail.com",
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          GestureDetector(
            onTap: () {},
            child: Text(
              "Need help?",
              style: GoogleFonts.inter(
                fontSize: 18 * ffem,
                decoration: TextDecoration.underline,
                color: const Color(0xff1F0A68),
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CusTile extends StatelessWidget {
  const CusTile({
    super.key,
    required this.ffem,
    required this.icon,
    required this.leading,
    required this.traling,
  });

  final double ffem;
  final IconData icon;
  final String leading;
  final String traling;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(width: 10.0),
            Text(
              leading,
              style: GoogleFonts.inter(
                fontSize: 18 * ffem,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const Text(
          "-",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          width: 120,
          child: Text(
            traling,
            style: GoogleFonts.inter(
              fontSize: 18 * ffem,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
