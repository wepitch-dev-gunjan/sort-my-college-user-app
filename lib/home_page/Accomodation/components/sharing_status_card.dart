import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharingStatusCard extends StatelessWidget {
  final String roomType, availability, price;
  final bool isAvailable;
  const SharingStatusCard(
      {super.key,
      required this.roomType,
      required this.availability,
      required this.price,
      required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black12, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                spreadRadius: 0.5,
                blurRadius: 0.5,
                offset: const Offset(0, 1),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      roomType,
                      style: TextStyle(
                          fontSize: 20 * ffem, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                const VerticalDivider(
                  color: Colors.black12,
                  thickness: 0.5,
                  indent: 2,
                  endIndent: 2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                            fontSize: 20 * ffem, fontWeight: FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return PgDialog();
                            },
                          );
                        },
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                              color: Color(0xff1F0A68),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -14 * fem,
          left: 20 * fem,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(21),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.20),
                  spreadRadius: 0.5,
                  blurRadius: 0.5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Text(
              availability,
              style: TextStyle(
                color: isAvailable ? Colors.green : Colors.red,
                fontWeight: FontWeight.w700,
                fontSize: 12 * ffem,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PgDialog extends StatelessWidget {
  final List<String> facilities = [
    "AC",
    "WiFi",
    "TV",
    "Fridge",
    "Laundry",
    "Parking"
  ];
  PgDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21.0),
      ),
      child: Stack(
        children: [
          Container(
            height: 290,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(21),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(21),
                  child: Container(
                    // height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Column(
                        children: [
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [],
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xff1F0A68),
                                borderRadius: BorderRadius.circular(11)),
                            child: Text(
                              "Academic Session",
                              style: GoogleFonts.inter(
                                  fontSize: 20 * ffem,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            "Pg Rent:- ₹7,500p/m ",
                            style: GoogleFonts.inter(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "One Time Security Deposit:- ₹7,500",
                            style: GoogleFonts.inter(
                                fontSize: 18 * ffem,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'Facilties',
                  style: GoogleFonts.inter(
                      color: const Color(0xff1F0A68),
                      fontSize: 20 * ffem,
                      fontWeight: FontWeight.w600),
                ),
                facilityItemGrid(facilities, context)
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget facilityItemGrid(List<String> facilityNames, BuildContext context) {
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: facilityNames.map((facilityName) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 3 - 20,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check,
              color: Colors.green,
              size: 28,
            ),
            const SizedBox(width: 5),
            Text(
              facilityName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
