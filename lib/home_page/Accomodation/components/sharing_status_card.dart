import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      securtyAmount:
                          "₹ ${data['rooms'][index]['deposit_amount'].toString()}",
                      isAvailable: data['rooms'][index]['available'],
                      facilities: data['rooms'][index]['details'],
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class SharingStatusCard extends StatelessWidget {
  final String roomType, availability, price, securtyAmount;
  final dynamic facilities;
  final bool isAvailable;
  const SharingStatusCard({
    super.key,
    required this.roomType,
    required this.availability,
    required this.price,
    required this.isAvailable,
    required this.facilities,
    required this.securtyAmount,
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
                                pgRent: price,
                                oneTimeDepositAmount: securtyAmount,
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
  final String pgRent;
  final String oneTimeDepositAmount;

  const PgDialog(
      {super.key,
      required this.facilities,
      required this.pgRent,
      required this.oneTimeDepositAmount});

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
                          "Pg Rent:- $pgRent/m ",
                          style: GoogleFonts.inter(
                              fontSize: 18 * ffem, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "One Time Security Deposit:- $oneTimeDepositAmount",
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
