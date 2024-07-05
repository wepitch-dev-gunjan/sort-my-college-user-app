import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/home_page/entrance_preparation/components/commons.dart';

class CommingSoonPage extends StatelessWidget {
  const CommingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.asset(
            //   "assets/page-1/images/smcLogo.png",
            //   height: 70,
            //   // width: 100,
            // ),
            Image.asset(
              "assets/page-1/images/commingSoon.png",
              height: 300,
              width: 300,
            ),
            Text(
              "LAUNCHING\n SOON!",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Welcome to "),
                Text("Sort My College",
                    style: GoogleFonts.roboto(
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.w500))),
              ],
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: 50,
            child: Btn(
              onTap: () {
                Navigator.pop(context);
              },
              btnName: "GO HOME",
              btnColor: const Color(0xff1F0A68),
              textColor: Colors.white,
            )),
      ),
    );
  }
}
