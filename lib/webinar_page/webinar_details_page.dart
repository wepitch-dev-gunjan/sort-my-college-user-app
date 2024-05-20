import 'package:flutter/material.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:share_plus/share_plus.dart';

class WebinarDetailsPage extends StatefulWidget {
  const WebinarDetailsPage({super.key});

  @override
  State<WebinarDetailsPage> createState() => _WebinarDetailsPageState();
}

class _WebinarDetailsPageState extends State<WebinarDetailsPage> {
  // late SharedPreferences _prefs;
  // bool _isRegistrationStarting = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _initializeSharedPreferences();
  // }
  //
  // Future<void> _initializeSharedPreferences() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   bool isStarting = _prefs.getBool('isRegistrationStarting') ?? false;
  //
  //   setState(() {
  //     _isRegistrationStarting = isStarting;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 320,
                    child: Stack(
                      children: [
                        Container(
                          color: const Color(0xffffffff).withOpacity(0.8),
                          width: double.infinity,
                          height: 280,
                          child: SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xFF1F0A68),
                                      size: 25,
                                    ),
                                  ),
                                  Text('Webinar Details',style: SafeGoogleFont("Inter",
                                      fontSize: 18, fontWeight: FontWeight.w600,color: ColorsConst.appBarColor),),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: (){
                                      Share.share('https://play.google.com/store/apps/details?id=com.sortmycollege');
                                    },
                                    child: Image.asset(
                                      "assets/page-1/images/share.png",
                                      color: const Color(0xFF1F0A68),
                                      height: 23,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 28.0, right: 20, left: 20),
                              child: Container(
                                height: 196,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/page-1/images/webinarBanner.png",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 20, 12, 15),
                        child: Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Learn more about CUET and IPMAT",
                                style: SafeGoogleFont("Inter",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff414040)),
                              ),
                              Text(
                                "60 min",
                                style: SafeGoogleFont("Inter",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: fontColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Row(
                          children: [
                            Text(
                              "Webinar by",
                              style: SafeGoogleFont(
                                "Inter",
                                fontSize: 12,
                                color: fontColor,
                              ),
                            ),
                            Text(
                              " Allen Career Institute",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  color: fontColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 9, 15, 8),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/page-1/images/clock.png",
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "02:00 PM Onwards \n 15th Sep",
                              style: SafeGoogleFont(
                                "Inter",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // const Spacer(),
                            // Image.asset(
                            //   "assets/page-1/images/persons.png",
                            // ),
                            // const SizedBox(
                            //   width: 3,
                            // ),
                            // Text(
                            //   "44/100",
                            //   style: SafeGoogleFont(
                            //     "Inter",
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w500,
                            //     color: fontColor,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Container(
                          height: 1,
                          color: const Color(0xffAFAFAF).withOpacity(0.54),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Details -",
                              style: SafeGoogleFont(
                                "Inter",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              "\u2022 Guideline will always give right direction in carrier path \n\u2022 Our Councillor is experienced and having industry experience \n\u2022 Session will give you confidence and carrier boost in competitive world\n\u2022 This will open new gateway  for you future journey",
                              style: SafeGoogleFont("Inter",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  height: 1.64),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 19),
                        child: Text(
                          "What will you Learn?",
                          style: SafeGoogleFont(
                            "Inter",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 88,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? 20 : 17,
                              ),
                              height: 88,
                              width: 144,
                              decoration: BoxDecoration(
                                color:
                                const Color(0xffD9D9D9).withOpacity(0.65),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(14, 11, 0, 11),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: SafeGoogleFont(
                                            "Inter",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      index == 0 ? "Detailed information"
                                          : index == 1 ? "Upgrade Knowledge" : "Interactive learning",
                                      style: SafeGoogleFont(
                                        "Inter",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xff414040),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 19, 15, 19),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Speaker Profile",
                          style: SafeGoogleFont(
                            "Inter",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Companies of all types and sizes rely on user experience (UX) designers to help..",
                          style: SafeGoogleFont(
                            "Inter",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 11.0,
            ),
            child: customButton(
              context: context,
              onPressed: () {},
              title: 'Join Now',
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

const fontColor = Color(0xff8E8989);

Widget customButton(
    {required BuildContext context,
      required VoidCallback onPressed,
      required String title}) {
  return SizedBox(
    width: double.infinity,
    height: 47,
    child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff1F0A68),
        ),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Inter",
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        )),
  );
}
