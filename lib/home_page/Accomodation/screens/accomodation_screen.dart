
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/home_page/Accomodation/components/filter_screen.dart';
import 'package:myapp/home_page/Accomodation/screens/detail_accommodation.dart';
import 'package:myapp/home_page/entrance_preparation/components/shimmer_effect.dart';
import 'package:myapp/other/api_service.dart';
import '../../../shared/colors_const.dart';
import '../../entrance_preparation/components/commons.dart';
import '../../entrance_preparation/screens/entrance_preparation_screen.dart';

class AccomodationScreen extends StatefulWidget {
  const AccomodationScreen({super.key});

  @override
  State<AccomodationScreen> createState() => _AccomodationScreenState();
}

class _AccomodationScreenState extends State<AccomodationScreen> {
  bool isLoading = true;
  List data = [];
  List<String> cities = [];
  List<String> colleges = [];
  Map<String, List<String>> appliedFilters = {}; // Applied filters

  @override
  void initState() {
    super.initState();
    getCities();
    getColleges();
    fetchAccommodations(); // Fetch data with filters
  }

  Future<void> fetchAccommodations() async {
    if (!mounted) return; // Check if widget is still mounted
    setState(() {
      isLoading = true;
    });

    final res = await ApiService.getAllAccommodations(filters: appliedFilters);
    if (!mounted) return; // Check if widget is still mounted
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  Future<void> getCities() async {
    final res = await ApiService.getCities();
    if (!mounted) return; // Check if widget is still mounted
    setState(() {
      cities = res['cities'].cast<String>();
    });
  }

  Future<void> getColleges() async {
    final res = await ApiService.getColleges();
    if (!mounted) return; // Check if widget is still mounted
    setState(() {
      colleges = res['colleges'].cast<String>();
    });
  }

  void _applyFilters(Map<String, List<String>> filters) {
    if (!mounted) return; // Check if widget is still mounted
    setState(() {
      appliedFilters = filters; // Update applied filters
    });
    fetchAccommodations(); // Fetch data with new filters
  }

  Future<void> _refreshAccommodations() async {
    fetchAccommodations(); // Refresh accommodations
  }

  @override
  void dispose() {
    data.clear();
    cities.clear();
    colleges.clear();
    super.dispose();
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
          : data.isEmpty
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
                        onRefresh: _refreshAccommodations,
                        appliedFilters: appliedFilters,
                        onFiltersUpdated: _applyFilters, // Filter callback
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
                          return Row(
                            children: (entry.value).map((value) {
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
            String imageUrl =
                accommodation['images'] ?? 'https://via.placeholder.com/150';

            String name = accommodation['name'] ?? 'N/A';
            String area = accommodation['address']['area'] ?? 'N/A';
            String city = accommodation['address']['city'] ?? 'N/A';

            String rating = accommodation['rating'] ?? "N/A";
            String reviewsCount = accommodation['review_count'] ?? "N/A";

            dynamic price = accommodation['monthly_charge'] ?? 'N/A';

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
                                                id: data[index]["_id"]),
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
