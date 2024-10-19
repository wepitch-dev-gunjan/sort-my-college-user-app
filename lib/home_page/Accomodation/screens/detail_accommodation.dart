import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/colors_const.dart';
import '../../../utils/share_links.dart';
import '../../entrance_preparation/components/commons.dart';
import '../components/sharing_status_card.dart';

class DetailAccommodation extends StatelessWidget {
  final dynamic data;
  const DetailAccommodation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    log("Acc Data$data");
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccommondationTopCard(data: data),
          RoomsOfferedSection(data: data),
          NearByLocation(data: data)
        ],
      )),
    );
  }
}

class AccommondationTopCard extends StatefulWidget {
  final dynamic data;
  const AccommondationTopCard({super.key, required this.data});

  @override
  AccommondationTopCardState createState() => AccommondationTopCardState();
}

class AccommondationTopCardState extends State<AccommondationTopCard> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    List<String> images =
        widget.data['images'] != null && widget.data['images'].isNotEmpty
            ? List<String>.from(widget.data['images'])
            : ['https://via.placeholder.com/150'];
    final area = widget.data['address']['area'] ?? 'N/A';
    final city = widget.data['address']['city'] ?? 'N/A';
    final startingPrice = widget.data['rooms'][0]['montly_charge'] ?? 'N/A';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: 190,
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
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // child: CachedNetworkImage(
                  //   repeat: ImageRepeat.noRepeat,
                  //   imageUrl: images[index],
                  //   height: 180,
                  //   width: width,
                  //   fit: BoxFit.fill,
                  //   placeholder: (context, url) => const Center(
                  //     child: CircularProgressIndicator(strokeWidth: 2.0),
                  //   ),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  //   cacheKey: images[
                  //       index], // Unique cache key to avoid unnecessary reloads
                  // ),

                  child: Image.network(
                    images[index],
                    height: 180,
                    width: width,
                    fit: BoxFit.fill,
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
                );
              },
            ),
          ),
        ),
        // Dots below the image
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            images.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == index ? 10 : 6,
              height: _currentPage == index ? 10 : 6,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['name'] ?? 'N/A',
                    style: GoogleFonts.inter(
                        fontSize: 22 * ffem, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "$area, $city",
                    style: GoogleFonts.inter(
                        fontSize: 16 * ffem, fontWeight: FontWeight.w500),
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(11)),
                child: Center(
                  child: Text(
                    "Starting at\n₹ $startingPrice/month",
                    style: GoogleFonts.inter(
                        fontSize: 16 * ffem, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class RoomsOfferedSection extends StatelessWidget {
  final dynamic data;
  const RoomsOfferedSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              "Rooms Offered",
              style: GoogleFonts.inter(
                  fontSize: 20 * ffem, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 20.0),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data['rooms'].length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      SharingStatusCard(
                        roomType:
                            "${data['rooms'][index]['sharing_type']} Sharing",
                        availability: data['rooms'][index]['available'] == true
                            ? "Available"
                            : "Not Available",
                        price:
                            "₹ ${data['rooms'][index]['monthly_charge'].toString()}",
                        isAvailable: data['rooms'][index]['available'],
                        facilities: data['rooms'][index]['details'],
                      ),
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}

class NearByLocation extends StatelessWidget {
  final dynamic data;
  const NearByLocation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    // double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Nearby Locations',
              style: GoogleFonts.inter(
                  fontSize: 20 * ffem, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
