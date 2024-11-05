import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main.dart';
import '../../entrance_preparation/components/commons.dart';

class AccommodationBottomBar extends StatelessWidget {
  const AccommodationBottomBar({super.key});

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
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width, // Full width
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      'Visit Schedule',
                                      style: GoogleFonts.inter(
                                        fontSize: 22 * ffem,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff1f0a68),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Card(
                                    color: const Color(0xffF8F8F8),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "When are you planning to visit?",
                                                style: GoogleFonts.inter(
                                                  fontSize: 20 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              const ScrollableDates(),
                                              const SizedBox(height: 15.0),
                                              Text(
                                                "Additional details",
                                                style: GoogleFonts.inter(
                                                  fontSize: 20 * ffem,
                                                  fontWeight: FontWeight.w500,
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
                                              color: const Color(0xffACACAC),
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
                                      onTap: () {},
                                      btnName: "CONFIRM",
                                      width: width,
                                      height: 50,
                                      btnColor: const Color(0xff1f0a68),
                                      textColor: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
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
