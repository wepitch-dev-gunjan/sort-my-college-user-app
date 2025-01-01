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
  final String id;
  final List? review;

  const DetailAccommodation({super.key, required this.id, this.review});

  @override
  State<DetailAccommodation> createState() => _DetailAccommodationState();
}

class _DetailAccommodationState extends State<DetailAccommodation> {
  bool isLoading = true;
  List reviews = []; // Store the reviews here

  dynamic data;

  @override
  void initState() {
    getFeedback(widget.id);
    fetchAccommodations(widget.id);
    super.initState();
  }

  Future<void> fetchAccommodations(String id) async {
    final res = await ApiService.getAllAccommodation(id: id);
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  getFeedback(String id) async {
    final res = await ApiService.getAccommodationFeedback(id: widget.id);
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
    return isLoading
        ? const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: ColorsConst.whiteColor,
            body: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccommondationTopCard(data: data),
                RoomsOfferedSection(data: data),
                NearByLocation(data: data),
                reviews.isEmpty
                    ? const SizedBox()
                    : ReviewCard(reviews: reviews),
                AccommodationGiveReviewSection(
                  id: widget.id,
                  onReviewAdded: addReview,
                  reviews: reviews,
                ),
              ],
            )),
            bottomNavigationBar: AccommodationBottomBar(
              data: data,
            ),
          );
  }
}
