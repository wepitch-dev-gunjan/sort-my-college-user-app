import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharingStatusCard extends StatelessWidget {
  final String roomType, availability, price;
  final dynamic facilities;
  final bool isAvailable;
  const SharingStatusCard({
    super.key,
    required this.roomType,
    required this.availability,
    required this.price,
    required this.isAvailable,
    required this.facilities,
  });

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
                              return PgDialog(
                                facilities: facilities,
                              );
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
  final dynamic facilities;

  const PgDialog({super.key, required this.facilities});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21.0),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [],
                        ),
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
                              fontSize: 18 * ffem, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "One Time Security Deposit:- ₹7,500",
                          style: GoogleFonts.inter(
                              fontSize: 18 * ffem, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Facilties',
                style: GoogleFonts.inter(
                    fontSize: 20 * ffem,
                    color: const Color(0xff1F0A68),
                    fontWeight: FontWeight.w600),
              ),
              facilityItemGrid(facilities, context)
            ],
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
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget facilityItemGrid(List<dynamic> facilityNames, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 25),
    child: Wrap(
      spacing: 20,
      runSpacing: 15,
      children: List.generate(facilityNames.length, (index) {
        var facilityName = facilityNames[index];
        return SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/accommodation/check 10.png",
                width: 22,
                height: 18,
              ),
              const SizedBox(width: 5),
              Text(
                facilityName,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );
}
