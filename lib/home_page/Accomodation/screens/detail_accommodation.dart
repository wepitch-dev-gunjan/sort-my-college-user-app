import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../shared/colors_const.dart';
import '../../../utils/share_links.dart';
import '../../entrance_preparation/components/commons.dart';

class DetailAccommodation extends StatelessWidget {
  const DetailAccommodation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: CusAppBar(
        title: 'Ram Niwas PG',
        action: [
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  shareLinks();
                },
                child: Image.asset(
                  "assets/page-1/images/share.png",
                  color: const Color(0xff1F0A68),
                  height: 23,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset("assets/accommodation/testimage.png"),
            const SizedBox(height: 15.0),
            const RoomOffered(
                roomType: "Single Share",
                availability: "Available",
                price: "5000",
                isAvailable: true),
            const SizedBox(height: 15.0),
            const RoomOffered(
                roomType: "Double Share",
                availability: "Not Available",
                price: "5000",
                isAvailable: false)
          ],
        ),
      )),
    );
  }
}

class RoomOffered extends StatelessWidget {
  final String roomType, availability, price;
  final bool isAvailable;
  const RoomOffered(
      {super.key,
      required this.roomType,
      required this.availability,
      required this.price,
      required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double width = MediaQuery.of(context).size.width;
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
