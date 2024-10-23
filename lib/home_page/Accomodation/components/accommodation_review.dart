import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../other/api_service.dart';


class AccommodationGiveReviewSection extends StatefulWidget {
  final String id;
  final Function(Map<String, dynamic>) onReviewAdded;
  final List? reviews;

  const AccommodationGiveReviewSection({
    super.key,
    required this.id,
    required this.onReviewAdded,
    this.reviews
  });

  @override
  State<AccommodationGiveReviewSection> createState() => _AccommodationGiveReviewSectionState();
}
class _AccommodationGiveReviewSectionState extends State<AccommodationGiveReviewSection> {
  double ratingVal = 5;
  String feedbackMsg = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            'Give a Review',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    ratingVal = rating;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: TextFormField(
              onChanged: (value) {
                feedbackMsg = value;
              },
              controller: controller,
              cursorHeight: 22,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(left: 8.0, top: 4),
                hintText: 'comment',
                hintStyle: const TextStyle(color: Colors.black45),
                suffixIcon: IconButton(
                  onPressed: () async {
                    var value = await ApiService.epFeedback(
                      id: widget.id,
                      ratingVal: ratingVal,
                      feedbackMsg: feedbackMsg,
                    );

                    if (value["error"] ==
                        "Feedback is already given by the user") {
                      Fluttertoast.showToast(
                        msg: "Feedback is already given by the user",
                      );
                    } else {
                      if (value["message"] ==
                          "Feedback has been successfully added") {
                        Fluttertoast.showToast(
                          msg: "Feedback has been successfully added",
                          backgroundColor: Colors.green,
                        );
                        final res = await ApiService.getEpFeedback(id: widget.id);
                        final userName = res['feedbacks'][0]['user_name'];
                        final userProfile = res['feedbacks'][0]['profile_pic'];

                        widget.onReviewAdded({
                          'profile_pic': userProfile,
                          'user_name': userName,
                          'rating': ratingVal,
                          'comment': feedbackMsg,
                        });
                      }
                    }
                    controller.clear();
                  },
                  icon: const Icon(
                    Icons.send_sharp,
                    size: 22,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}