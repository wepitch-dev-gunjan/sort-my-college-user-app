import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/share_links.dart';
import '../../entrance_preparation/components/commons.dart';

class AccommondationTopCard extends StatefulWidget {
  final dynamic data;
  const AccommondationTopCard({super.key, required this.data});

  @override
  AccommondationTopCardState createState() => AccommondationTopCardState();
}

class AccommondationTopCardState extends State<AccommondationTopCard> {
  late PageController _pageController;
  int _currentPage = 0;
  List<String> images = [];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize images from widget.data
    images = widget.data['images'] != null && widget.data['images'].isNotEmpty
        ? List<String>.from(widget.data['images'])
        : ['https://via.placeholder.com/150'];

    // Set up the timer to auto-slide the images
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    final area = widget.data['address']['area'] ?? 'N/A';
    final city = widget.data['address']['city'] ?? 'N/A';
    // final startingPrice = widget.data['rooms'][0]['monthly_charge'] ?? 'N/A';

    String price = 'N/A';
    if (widget.data['rooms']?.isNotEmpty ?? false) {
      double? lowestPrice = widget.data['rooms']
          ?.map((room) =>
              (room['monthly_charge'] as num?)?.toDouble() ?? double.infinity)
          .reduce((a, b) => a < b ? a : b);

      if (lowestPrice != double.infinity) {
        price = "${lowestPrice!.toInt()}";
      }
    }

    return Column(
      children: [
        SizedBox(
          height: 260,
          width: width,
          child: PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image.network(
                    images[index],
                    height: 260,
                    width: width,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 7.0, right: 10.0, top: 3, bottom: 3),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            widget.data['rating'].toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 7.0,
                        right: 10.0,
                        top: 3,
                        bottom: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 15,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            widget.data['recommended_for'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        shareLinks();
                      },
                      child: Image.asset(
                        "assets/page-1/images/share.png",
                        color: const Color(0xff1F0A68),
                        height: 23,
                        width: 23,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? const Color(0xff1F0A68)
                    : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['name'] ?? 'N/A',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "$area, $city",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    InkWell(
                      onTap: () async {
                        final Uri redirectLink =
                            Uri.parse(widget.data['direction']);
                        if (await canLaunchUrl(redirectLink)) {
                          await launchUrl(redirectLink);
                        } else {
                          throw 'Could not launch $redirectLink';
                        }
                      },
                      child: TextWithIcon(
                        text: "DIRECTION",
                        fontWeight: FontWeight.w500,
                        iconColor: const Color(0xff1F0A68),
                        icon: Icons.directions,
                        textColor: const Color(0xff1F0A68),
                        fontSize: 16 * ffem,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Text(
                    "Starting at\n₹ $price/month",
                    style: GoogleFonts.inter(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
