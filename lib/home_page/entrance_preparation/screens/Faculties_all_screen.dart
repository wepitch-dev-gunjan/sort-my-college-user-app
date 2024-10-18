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
      appBar: const CusAppBar(title: "Faculties"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.facultiesData.length,
                itemBuilder: (context, index) {
                  return FacultiesCard(
                    data: widget.facultiesData[index],
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class FacultiesCard extends StatelessWidget {
  final dynamic data;
  const FacultiesCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          Material(
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
                    // Container(
                    //   height: 110,
                    //   width: 100,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(5),
                    //     image: DecorationImage(
                    //       image: NetworkImage(data['display_pic']),
                    //     ),
                    //     color: Colors.white,
                    //   ),
                    // ),
                    SizedBox(
                      width: 95 * fem,
                      height: 104 * fem,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75 * fem),
                        child: Image.network(
                          "${data['display_pic']}",
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/page-1/images/comming_soon.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            data['qualifications'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: Container(
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
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    PointerText(
                                        text:
                                            "Experience : ${data['experience_in_years']}+ years."),
                                    PointerText(
                                        text:
                                            "Qualification : ${data['qualifications']}"),
                                    PointerText(
                                        text:
                                            "Graduated from : ${data['graduated_from'][0]}")
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
        ],
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
