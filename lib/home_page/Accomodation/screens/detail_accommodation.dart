import 'package:flutter/material.dart';
import 'package:myapp/home_page/entrance_preparation/components/review_card.dart';
import '../../../shared/colors_const.dart';
import '../../../utils/share_links.dart';
import '../../entrance_preparation/components/commons.dart';
import '../components/accommodation_review.dart';
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
    );
  }
}
