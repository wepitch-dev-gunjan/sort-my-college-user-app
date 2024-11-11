import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../other/api_service.dart';
import '../../../shared/colors_const.dart';
import '../../entrance_preparation/components/review_card.dart';
import '../components/accommodation_review.dart';
import '../components/bottom_bar.dart';
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
  bool isLoading = true;
  List reviews = []; // Store the reviews here

  @override
  void initState() {
    getFeedback(widget.data['_id']);
    super.initState();
  }

  getFeedback(String id) async {
    final res =
        await ApiService.getAccommodationFeedback(id: widget.data['_id']);
    setState(() {
      reviews = res['feedbacks'];
      isLoading = false;
    });
  }

  void addReview(Map<String, dynamic> review) {
    setState(() {
      reviews.insert(0, review);
    });
  }

  @override
  Widget build(BuildContext context) {
    log("data1${widget.data['_id']}");
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccommondationTopCard(data: widget.data),
          RoomsOfferedSection(data: widget.data),
          NearByLocation(data: widget.data),
          reviews.isEmpty ? const SizedBox() : ReviewCard(reviews: reviews),
          AccommodationGiveReviewSection(
            id: widget.data['_id'],
            onReviewAdded: addReview,
            reviews: reviews,
          ),
        ],
      )),
      bottomNavigationBar: AccommodationBottomBar(
        data: widget.data,
      ),
    );
  }
}
