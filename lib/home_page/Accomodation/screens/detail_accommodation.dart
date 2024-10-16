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
        ],
      )),
    );
  }
}

class AccommondationTopCard extends StatelessWidget {
  final dynamic data;
  const AccommondationTopCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    String imageUrl = (data['images'] != null && data['images'].isNotEmpty)
        ? data['images'][0]
        : 'https://via.placeholder.com/150';

    final area = data['address']['area'] ?? 'N/A';
    final city = data['address']['city'] ?? 'N/A';
    final startingPrice = data['rooms'][0]['montly_charge'] ?? 'N/A';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 180,
              width: width,
              fit: BoxFit.fill,
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
                    data['name'] ?? 'N/A',
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
                      final Uri redirectLink = Uri.parse(data['direction']);
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
          const SharingStatusCard(
              roomType: "Single Shareing",
              availability: "Available",
              price: "5000",
              isAvailable: true),
          const SizedBox(height: 20.0),
          const SharingStatusCard(
              roomType: "Double Shareing",
              availability: "Not Available",
              price: "5000",
              isAvailable: false)
        ],
      ),
    );
  }
}
