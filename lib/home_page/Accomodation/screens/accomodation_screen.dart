import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/colors_const.dart';
import '../../entrance_preparation/components/commons.dart';
import '../../entrance_preparation/screens/entrance_preparation_screen.dart';
import '../components/filter_screen.dart';

class AccomodationScreen extends StatelessWidget {
  const AccomodationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: const CusAppBar(
        title: 'Accommodation',
        icon: Icons.search,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 15.0),
            TopSlider(
              sliderText: accommodationSliderText,
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/accommodation/testimage.png",
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                    // const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width / 2.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ram Niwas PG ",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Ram Bagh Circle, Jaipur",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w500),
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
                                    "4.2 Rating | (99) Reviews",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        fontSize: 12 * ffem,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width / 2.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Starting from",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontSize: 16 * ffem,
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "10,000 INR/",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                          fontSize: 18 * ffem,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      "Month",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.inter(
                                          fontSize: 16 * ffem,
                                          fontWeight: FontWeight.w400),
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
                                      builder: (context) => FilterScreen()));
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
            )
          ],
        ),
      )),
    );
  }
}
