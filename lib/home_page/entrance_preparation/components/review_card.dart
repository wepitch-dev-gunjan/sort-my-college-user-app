import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../other/api_service.dart';

class GiveReviewSection extends StatefulWidget {
  final String id;
  final Function(Map<String, dynamic>)
      onReviewAdded; // Callback to update reviews in ReviewCard

  const GiveReviewSection({
    super.key,
    required this.id,
    required this.onReviewAdded, // Pass the callback
  });

  @override
  State<GiveReviewSection> createState() => _GiveReviewSectionState();
}

class _GiveReviewSectionState extends State<GiveReviewSection> {
  double rating_val = 5;
  String feedback_msg = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    rating_val = rating;
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
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
                feedback_msg = value;
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
                      ratingVal: rating_val,
                      feedbackMsg: feedback_msg,
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

                        widget.onReviewAdded({
                          'user_name': 'User', 
                          'rating': rating_val,
                          'comment': feedback_msg,
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

class ReviewCard extends StatefulWidget {
  final String? id; // Allow nullable id
  final List? reviews; // Allow nullable reviews

  const ReviewCard({
    super.key,
    this.id,
    this.reviews,
  });

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check for null and empty list
    if (widget.reviews == null || widget.reviews!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Text(
            'Reviews',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.26,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.reviews!.length,
                  itemBuilder: (context, index) {
                    // Add null checks for individual items
                    var review = widget.reviews![index];
                    double rating = (review['rating'] ?? 0).toDouble();
                    String userName =
                        review['user_name']?.toString() ?? 'Anonymous';
                    String comment =
                        review['comment']?.toString() ?? 'No comment available';

                    return Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  const CircleAvatar(radius: 25),
                                  const SizedBox(height: 5),
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  RatingBarIndicator(
                                    rating: rating,
                                    itemSize: 20,
                                    itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: Colors.amber),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        comment,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.reviews!.length.clamp(0, 5); i++)
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: i == _currentPage
                              ? Colors.black
                              : Colors.grey.shade400,
                        ),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
