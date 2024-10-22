import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/home_page/Accomodation/screens/detail_accommodation.dart';
import 'package:myapp/home_page/entrance_preparation/components/shimmer_effect.dart';
import 'package:myapp/other/api_service.dart';
import '../../../shared/colors_const.dart';
import '../../entrance_preparation/components/commons.dart';
import '../../entrance_preparation/screens/entrance_preparation_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AccomodationScreen extends StatefulWidget {
  const AccomodationScreen({super.key});

  @override
  State<AccomodationScreen> createState() => _AccomodationScreenState();
}

class _AccomodationScreenState extends State<AccomodationScreen> {
  bool isLoading = true;
  dynamic data;

  @override
  void initState() {
    super.initState();
    getAllAccommodation();
  }

  // Future<void> loadCachedData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final cachedData = prefs.getString('accommodationData');

  //   if (cachedData != null) {
  //     setState(() {
  //       data = jsonDecode(cachedData);
  //       isLoading = false;
  //     });
  //   }

  //   getAllAccommodation();
  // }

  Future<void> getAllAccommodation() async {
    final res = await ApiService.getAllAccommodation();
    if (res != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accommodationData', jsonEncode(res));
      setState(() {
        data = res;
        isLoading = false;
      });
    }
  }

  Future<void> _refreshAccommodations() async {
    setState(() {
      isLoading = true;
    });
    await getAllAccommodation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: const CusAppBar(
        title: 'Accommodation',
      ),
      body: isLoading
          ? const AccommodationShimmerEffect()
          : data == null || data.isEmpty
              ? const Center(
                  child: Text(
                    'No Data Available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                )
              : RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: Colors.black,
                  onRefresh: _refreshAccommodations,
                  child: ListView(
                    children: [
                      AccommodationCard(
                          data:
                              data), // Ensure AccommodationCard can fit inside a ListView
                    ],
                  ),
                ),
    );
  }
}

class AccommodationCard extends StatelessWidget {
  final dynamic data;
  const AccommodationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
      children: [
        const SizedBox(height: 15.0),
        TopSlider(
          sliderText: accommodationSliderText,
          src: 'assets/accommodation/home.png',
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 10.0),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            var accommodation = data[index];
            String imageUrl = (accommodation['images'] != null &&
                    accommodation['images'].isNotEmpty)
                ? accommodation['images'][0]
                : 'https://via.placeholder.com/150';
            String name = accommodation['name'] ?? 'N/A';
            String area = accommodation['address']['area'] ?? 'N/A';
            String city = accommodation['address']['city'] ?? 'N/A';
            double rating = (accommodation['rating'] != null)
                ? (accommodation['rating'] is int
                    ? accommodation['rating'].toDouble()
                    : accommodation['rating'])
                : 0.0;
            int reviewsCount = accommodation['rooms']?.length ?? 0;
            String price = (accommodation['rooms'] != null &&
                    accommodation['rooms'].isNotEmpty)
                ? "${accommodation['rooms'][0]['monthly_charge'] ?? 'N/A'} INR/"
                : 'N/A';
            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              height: 180,
                              width: width,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width / 2.1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: 24 * ffem,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "$area, $city",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 12,
                                        color: Colors.orange,
                                      ),
                                      const SizedBox(width: 2.0),
                                      Flexible(
                                        child: Text(
                                          "$rating Rating | ($reviewsCount) Reviews",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width / 2.1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Starting from",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            price.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                              fontSize: 18 * ffem,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            "Month",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                              fontSize: 16 * ffem,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Btn(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailAccommodation(
                                                data: accommodation),
                                      ),
                                    );
                                  },
                                  btnName: "View Details",
                                  textColor: Colors.white,
                                  btnColor: const Color(0xff1F0A68),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
