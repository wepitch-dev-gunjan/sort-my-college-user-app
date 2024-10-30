import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myapp/booking_page/booking_confirmatoin_past.dart';
import 'package:myapp/main.dart';
import '../../../shared/colors_const.dart';
import '../../../utils/share_links.dart';
import '../../entrance_preparation/components/commons.dart';
import '../components/detail_accommodation_topcard.dart';
import '../components/nearby_location.dart';
import '../components/sharing_status_card.dart';

class DetailAccommodation extends StatefulWidget {
  final dynamic data;

  const DetailAccommodation({super.key, required this.data});

  @override
  State<DetailAccommodation> createState() => _DetailAccommodationState();
}

class _DetailAccommodationState extends State<DetailAccommodation> {
  void addReview(Map<String, dynamic> review) {
    setState(() {
      // reviews.insert(0, review);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: CusAppBar(
        title: widget.data['name'] ?? 'N/A',
        action: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  shareLinks();
                },
                child: Image.asset(
                  "assets/page-1/images/share.png",
                  color: const Color(0xff1F0A68),
                  height: 23,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccommondationTopCard(data: widget.data),
            RoomsOfferedSection(data: widget.data),
            NearByLocation(data: widget.data),
            // const ReviewCard(reviews: [],),
            // AccommodationGiveReviewSection(
            //   id: "123456789",
            //   onReviewAdded: addReview,
            //   reviews: [],
            // ),
          ],
        ),
      )),
      bottomNavigationBar: Container(
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
                    isScrollControlled: true, // Allow full width and height
                    builder: (context) {
                      return Container(
                        width: MediaQuery.of(context).size.width, // Full width
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // Adjusts to content height
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Visit schedule',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              color: const Color(0xffF8F8F8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                        "When are you planning to visit?"),
                                    const SizedBox(height: 10.0),
                                    ScrollableDates(),
                                    const SizedBox(height: 10.0),
                                    const Text("Additional details"),
                                  ],
                                ),
                              ),
                            )
                            
                            
                          ],
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
      ),
    );
  }
}
