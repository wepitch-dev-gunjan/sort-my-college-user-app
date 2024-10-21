
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NearByLocation extends StatelessWidget {
  final dynamic data;
  const NearByLocation({super.key, required this.data});

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
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              'Nearby Locations',
              style: GoogleFonts.inter(
                  fontSize: 20 * ffem, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 15.0),
          NearBySection(
            ffem: ffem,
            title: "Colleges",
            src: "assets/accommodation/college.png",
            colleges: data['nearby_locations']['colleges'],
          ),
          const SizedBox(height: 15),
          NearBySection(
            ffem: ffem,
            title: "Hospitals",
            src: "assets/accommodation/hospital.png",
            colleges: data['nearby_locations']['hospitals'],
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          ),
          const SizedBox(height: 15),
          NearBySection(
            ffem: ffem,
            title: "Metro Station",
            src: "assets/accommodation/metro.png",
            colleges: data['nearby_locations']['metro_stations'],
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          ),
        ],
      ),
    );
  }
}

class NearBySection extends StatelessWidget {
  final String title;
  final String src;
  final List colleges;
  final EdgeInsetsGeometry? padding;
  const NearBySection({
    super.key,
    required this.ffem,
    required this.title,
    required this.src,
    required this.colleges,
    this.padding,
  });

  final double ffem;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(src, width: 24, height: 24),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: GoogleFonts.inter(
                  fontSize: 18 * ffem, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
      const SizedBox(height: 15.0),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < colleges.length; i++)
              Container(
                margin: const EdgeInsets.only(right: 15),
                padding: padding ??
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  colleges[i],
                  style: GoogleFonts.inter(
                      fontSize: 14 * ffem, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      )
    ]);
  }
}
