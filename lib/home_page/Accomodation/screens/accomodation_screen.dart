import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/home_page/Accomodation/components/filter_screen.dart';
import 'package:myapp/home_page/Accomodation/screens/detail_accommodation.dart';
import 'package:myapp/home_page/entrance_preparation/components/shimmer_effect.dart';
import 'package:myapp/other/api_service.dart';
import '../../../shared/colors_const.dart';
import '../../entrance_preparation/components/commons.dart';
import '../../entrance_preparation/screens/entrance_preparation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccomodationScreen extends StatefulWidget {
  const AccomodationScreen({super.key});

  @override
  State<AccomodationScreen> createState() => _AccomodationScreenState();
}

class _AccomodationScreenState extends State<AccomodationScreen> {
  bool isLoading = true;
  dynamic data;
  List<String> cities = [];
  List<String> colleges = [];
  Map<String, List<String>> appliedFilters = {};

  @override
  void initState() {
    super.initState();
    getAllAccommodation();
    getCities();
    getColleges();
  }

  Future<void> getAllAccommodation() async {
    final res = await ApiService.getAllAccommodation();
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  getCities() async {
    final res = await ApiService.getCities();
    setState(() {
      cities = res['cities'].cast<String>();
      isLoading = false;
    });
  }

  getColleges() async {
    final res = await ApiService.getColleges();
    setState(() {
      colleges = res['colleges'].cast<String>();
      isLoading = false;
    });
  }

  Future<void> _refreshAccommodations() async {
    setState(() {
      isLoading = true;
    });
    await getAllAccommodation();
  }

  void _applyFilters(Map<String, List<String>> filters) {
    setState(() {
      appliedFilters = filters;
    });
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
                        cities: cities,
                        colleges: colleges,
                        data: data,
                        onRefresh: _refreshAccommodations, // Refresh function
                        appliedFilters: appliedFilters,
                        onFiltersUpdated: _applyFilters,
                      ),
                    ],
                  ),
                ),
    );
  }
}

class AccommodationCard extends StatelessWidget {
  final List<String> cities, colleges;

  final dynamic data;
  final Function onRefresh;
  final Map<String, List<String>> appliedFilters;
  final Function(Map<String, List<String>>) onFiltersUpdated;

  const AccommodationCard({
    super.key,
    required this.data,
    required this.onRefresh,
    required this.appliedFilters,
    required this.onFiltersUpdated,
    required this.cities,
    required this.colleges,
  });

  @override
  Widget build(BuildContext context) {
    log("filters===>>$appliedFilters");
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        TopSliderAccommodation(
          sliderText: accommodationSliderText,
          src: 'assets/accommodation/home.png',
          width: 45,
          height: 45,
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FilterScreen(
                        cities: cities,
                        colleges: colleges,
                      )),
            ).then((result) {
              if (result != null) {
                log("result$result");
                onFiltersUpdated(result);
                onRefresh();
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  width: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffE3E3E3), width: 0.5),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Filters",
                        style: GoogleFonts.inter(
                            fontSize: 16 * ffem, fontWeight: FontWeight.w600),
                      ),
                      Image.asset(
                        'assets/accommodation/filters.png',
                        height: 18 * fem,
                        width: 25 * fem,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                // Expanded(
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: appliedFilters.entries.map((entry) {
                //         return Row(
                //           children: entry.value.map((value) {
                //             return Container(
                //               margin: const EdgeInsets.only(right: 8),
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 10, vertical: 5),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[200],
                //                 borderRadius: BorderRadius.circular(15),
                //               ),
                //               child: Text(
                //                 value,
                //                 style: GoogleFonts.inter(
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w500,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             );
                //           }).toList(),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       children: appliedFilters.entries.map((entry) {
                //         if (entry.key == 'Budget') {
                //           // Special handling for budget range
                //           final budget = entry.value as Map<String, dynamic>;
                //           return Container(
                //             margin: const EdgeInsets.only(right: 8),
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 10, vertical: 5),
                //             decoration: BoxDecoration(
                //               color: Colors.grey[200],
                //               borderRadius: BorderRadius.circular(15),
                //             ),
                //             child: Text(
                //               "₹${budget['start']} - ₹${budget['end']}",
                //               style: GoogleFonts.inter(
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w500,
                //                 color: Colors.black,
                //               ),
                //             ),
                //           );
                //         } else {
                //           // Handle other filters as a list of strings
                //           return Row(
                //             children:
                //                 (entry.value as List<String>).map((value) {
                //               return Container(
                //                 margin: const EdgeInsets.only(right: 8),
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 10, vertical: 5),
                //                 decoration: BoxDecoration(
                //                   color: Colors.grey[200],
                //                   borderRadius: BorderRadius.circular(15),
                //                 ),
                //                 child: Text(
                //                   value,
                //                   style: GoogleFonts.inter(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w500,
                //                     color: Colors.black,
                //                   ),
                //                 ),
                //               );
                //             }).toList(),
                //           );
                //         }
                //       }).toList(),
                //     ),
                //   ),
                // ),

                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: appliedFilters.entries.map((entry) {
                        if (entry.key == 'Budget') {
                          // Special handling for budget range
                          if (entry.value is Map<String, dynamic>) {
                            final budget = entry.value as Map<String, dynamic>;
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "₹${budget['start']} - ₹${budget['end']}",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }
                          return const SizedBox(); // Return an empty widget if the type is incorrect
                        } else {
                          // Handle other filters as a list of strings
                          if (entry.value is List<String>) {
                            return Row(
                              children:
                                  (entry.value as List<String>).map((value) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const SizedBox(); // Return an empty widget if the type is incorrect
                        }
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
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
            int reviewsCount = accommodation['reviews_count'] ?? 0;

            String price = 'N/A';
            if (accommodation['rooms']?.isNotEmpty ?? false) {
              double? lowestPrice = accommodation['rooms']
                  ?.map((room) =>
                      (room['monthly_charge'] as num?)?.toDouble() ??
                      double.infinity)
                  .reduce((a, b) => a < b ? a : b);

              if (lowestPrice != double.infinity) {
                price = "${lowestPrice!.toInt()} INR";
              }
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              height: 180,
                              width: width,
                              fit: BoxFit.cover,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0, right: 5.0, top: 10),
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width / 2.1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 3.0),
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
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.inter(
                                            fontSize: 11 * ffem,
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
                          const SizedBox(height: 12),
                          // Price and button
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
                                            "/Month",
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// class AccommodationCard extends StatelessWidget {
//   final dynamic data;
//   final Function onRefresh;
//   final Map<String, List<String>> appliedFilters; // Accept applied filters

//   const AccommodationCard({
//     super.key,
//     required this.data,
//     required this.onRefresh,
//     required this.appliedFilters, // Pass applied filters
//   });

//   @override
//   Widget build(BuildContext context) {
//     log("FIlters==>>$appliedFilters");
//     double baseWidth = 460;
//     double width = MediaQuery.of(context).size.width;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 15.0),
//         // Top slider
//         TopSliderAccommodation(
//           sliderText: accommodationSliderText,
//           src: 'assets/accommodation/home.png',
//           width: 45,
//           height: 45,
//         ),
//         const SizedBox(height: 10.0),

//         // Filters section
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const FilterScreen()),
//             ).then((result) {
//               if (result != null) {}
//               onRefresh();
//             });
//           },
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Container(
//                   width: 100,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                   decoration: BoxDecoration(
//                     border:
//                         Border.all(color: const Color(0xffE3E3E3), width: 0.5),
//                     borderRadius: BorderRadius.circular(21),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         "Filters",
//                         style: GoogleFonts.inter(
//                             fontSize: 16 * ffem, fontWeight: FontWeight.w600),
//                       ),
//                       Image.asset(
//                         'assets/accommodation/filters.png',
//                         height: 18 * fem,
//                         width: 25 * fem,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Display applied filters as chips
//               if (appliedFilters.isNotEmpty)
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: appliedFilters.entries.map((entry) {
//                         final key = entry.key;
//                         final values = entry.value;
//                         return Row(
//                           children: values.map((value) {
//                             return Container(
//                               margin: const EdgeInsets.only(right: 8),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey[200],
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               child: Text(
//                                 value,
//                                 style: GoogleFonts.inter(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         // Accommodation list
//         ListView.builder(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             var accommodation = data[index];
//             String imageUrl = (accommodation['images'] != null &&
//                     accommodation['images'].isNotEmpty)
//                 ? accommodation['images'][0]
//                 : 'https://via.placeholder.com/150';
//             String name = accommodation['name'] ?? 'N/A';
//             String area = accommodation['address']['area'] ?? 'N/A';
//             String city = accommodation['address']['city'] ?? 'N/A';

//             double rating = (accommodation['rating'] != null)
//                 ? (accommodation['rating'] is int
//                     ? accommodation['rating'].toDouble()
//                     : accommodation['rating'])
//                 : 0.0;
//             int reviewsCount = accommodation['reviews_count'] ?? 0;
//             String price = (accommodation['rooms'] != null &&
//                     accommodation['rooms'].isNotEmpty)
//                 ? "${accommodation['rooms'][0]['monthly_charge'] ?? 'N/A'} INR/"
//                 : 'N/A';

//             return Padding(
//               padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
//               child: Column(
//                 children: [
//                   Card(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Accommodation image
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                               imageUrl,
//                               height: 180,
//                               width: width,
//                               fit: BoxFit.fill,
//                             ),
//                           ),

//                           // Name and location
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 left: 5.0, right: 5.0, top: 10),
//                             child: Text(
//                               name,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: GoogleFonts.inter(
//                                 fontSize: 24 * ffem,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 5),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   width: width / 2.1,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(height: 3.0),
//                                       Text(
//                                         "$area, $city",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: GoogleFonts.inter(
//                                           fontSize: 14 * ffem,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.star,
//                                         size: 12,
//                                         color: Colors.orange,
//                                       ),
//                                       const SizedBox(width: 2.0),
//                                       Flexible(
//                                         child: Text(
//                                           "$rating Rating | ($reviewsCount) Reviews",
//                                           maxLines: 2,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: GoogleFonts.inter(
//                                             fontSize: 11 * ffem,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),

//                           const SizedBox(height: 12),

//                           // Price and button
//                           Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 5.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 SizedBox(
//                                   width: width / 2.1,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Starting from",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: GoogleFonts.inter(
//                                           fontSize: 16 * ffem,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             price.toString(),
//                                             overflow: TextOverflow.ellipsis,
//                                             style: GoogleFonts.inter(
//                                               fontSize: 18 * ffem,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                           Text(
//                                             "Month",
//                                             overflow: TextOverflow.ellipsis,
//                                             style: GoogleFonts.inter(
//                                               fontSize: 16 * ffem,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Btn(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             DetailAccommodation(
//                                                 data: accommodation),
//                                       ),
//                                     );
//                                   },
//                                   btnName: "View Details",
//                                   textColor: Colors.white,
//                                   btnColor: const Color(0xff1F0A68),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }
