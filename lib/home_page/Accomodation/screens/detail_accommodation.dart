import 'package:flutter/material.dart';
import 'package:myapp/home_page/entrance_preparation/components/review_card.dart';
import '../../../shared/colors_const.dart';
import '../../../utils/share_links.dart';
import '../../entrance_preparation/components/commons.dart';
import '../components/detail_accommodation_topcard.dart';
import '../components/nearby_location.dart';
import '../components/sharing_status_card.dart';

class DetailAccommodation extends StatelessWidget {
  final dynamic data;
  const DetailAccommodation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: CusAppBar(
        title: data['name'] ?? 'N/A',
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
            AccommondationTopCard(data: data),
            RoomsOfferedSection(data: data),
            NearByLocation(data: data),
            const ReviewCard(reviews: [],)
          ],
        ),
      )),
    );
  }
}
