import 'package:flutter/material.dart';
import '../components/commons.dart';

class AllFacultiesScreen extends StatefulWidget {
  final dynamic facultiesData;
  const AllFacultiesScreen({super.key, required this.facultiesData});

  @override
  State<AllFacultiesScreen> createState() => _AllFacultiesScreen();
}

class _AllFacultiesScreen extends State<AllFacultiesScreen> {
  @override
  Widget build(BuildContext context) {
    // log("facultieData=$faculties");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const EpAppBar(title: "Faculties"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < 5; i++) const FacultiesCard(),
          ],
        ),
      ),
    );
  }
}

class FacultiesCard extends StatelessWidget {
  const FacultiesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: const DecorationImage(
                      image: AssetImage("assets/page-1/images/women.png"),
                    ),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Dr. Nidhi Gupta ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const Text(
                        "MBBS and MS in Human Anatomy ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: const Color(0xff1F0A68),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 5,
                            bottom: 2,
                            top: 1,
                          ),
                          child: Text(
                            "Introduction",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PointerText(text: "Experience : 25+ years."),
                                PointerText(
                                    text:
                                        "Qualification : MBBS and MS in Human Anatomy."),
                                PointerText(text: "Graduated from : BHU.")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PointerText extends StatelessWidget {
  final String text;
  const PointerText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "\u2022 ",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
