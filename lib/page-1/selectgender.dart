import 'package:flutter/material.dart';
import 'package:myapp/page-1/selectdob.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  int selectedIndex = 0;
  static List<String> list = ["Male", "Female", "Others"];
  String selectedOption = list[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 72),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // sortmycollegelogo1WFT (1115:272)
                width: 274,
                height: 70,
                padding: const EdgeInsets.all(0),

                margin: const EdgeInsets.fromLTRB(0, 0, 0, 24),

                child: Image.asset(
                  'assets/page-1/images/sortmycollege-logo-1.png',
                  fit: BoxFit.fitWidth,
                  height: 80,
                ),
              ),
              // Container(
              //   // sortyourentirecollegejourneyDQ (1115:271)
              //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              //   // child: Text(
              //   //   'All in one platform for student',
              //   //   textAlign: TextAlign.center,
              //   //   style: SafeGoogleFont(
              //   //     'Roboto',
              //   //     fontSize: 15,
              //   //     fontWeight: FontWeight.w700,
              //   //     height: 1.1725,
              //   //     color: const Color(0xff1f0a68),
              //   //   ),
              //   // ),
              // ),
              Text(
                "Select Your Gender",
                style: SafeGoogleFont(
                  "Montserrat",
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                // color: Colors.red,
                height: 320,
                width: 200,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      String title = list[index];
                      return customButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = index;
                            selectedOption = title;
                          });
                        },
                        title: title,
                        isActive: selectedIndex == index,
                      );
                    }),
              ),
              const Spacer(),
              nextButton(
                  onPressed: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString("gender", selectedOption);
                    if (!mounted) return;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectDob()));
                  },
                  title: "Next")
            ],
          ),
        ),
      ),
    );
  }
}

Widget customButton(
    {required VoidCallback onPressed,
    required String title,
    required bool isActive}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: SizedBox(
      height: 70,
      width: 270,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            backgroundColor:
                isActive ? const Color(0xff1F0A68) : const Color(0xffD9D9D9),
            foregroundColor: isActive ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Montserrat",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget nextButton({required VoidCallback onPressed, required String title}) {
  return SizedBox(
    height: 45,
    width: 326,
    child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color(0xff1F0A68),
            foregroundColor: Colors.white),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Roboto",
            fontSize: 18,
          ),
        )),
  );
}
