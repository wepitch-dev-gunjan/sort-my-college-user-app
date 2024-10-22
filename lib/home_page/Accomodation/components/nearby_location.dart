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
            item: data['nearby_locations']['colleges'],
          ),
          const SizedBox(height: 15),
          NearBySection(
            width: 160,
            height: 70,
            ffem: ffem,
            title: "Hospitals",
            src: "assets/accommodation/hospital.png",
            item: data['nearby_locations']['hospitals'],
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
          const SizedBox(height: 15),
          NearBySection(
            ffem: ffem,
            width: 160,
            height: 70,
            title: "Metro Station",
            src: "assets/accommodation/metro.png",
            item: data['nearby_locations']['metro_stations'],
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ],
      ),
    );
  }
}

class NearBySection extends StatelessWidget {
  final String title;
  final String src;
  final List item;
  final EdgeInsetsGeometry? padding;
  final double? width, height;
  const NearBySection({
    super.key,
    required this.ffem,
    required this.title,
    required this.src,
    required this.item,
    this.padding,
    this.width,
    this.height
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
            for (int i = 0; i < item.length; i++)
              Container(
                width: width,
                height: height,
                margin: const EdgeInsets.only(right: 15),
                padding: padding ??
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Text(
                    item[i],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 14 * ffem, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      )
    ]);
  }
}
