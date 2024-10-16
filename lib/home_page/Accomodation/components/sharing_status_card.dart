
import 'package:flutter/material.dart';

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
    // double width = MediaQuery.of(context).size.width;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff1F0A68)),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomType,
                    style: TextStyle(
                        fontSize: 20 * ffem, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                width: 2,
                // height: 50,
                color: Colors.black,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                        fontSize: 20 * ffem, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      // Add action for "View Details"
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
