import 'package:flutter/material.dart';
import 'package:myapp/page-1/edulevel_new.dart';
import 'package:myapp/slide_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class SelectGenderNew extends StatefulWidget {
  const SelectGenderNew({super.key});

  @override
  State<SelectGenderNew> createState() => _SelectGenderNewState();
}

class _SelectGenderNewState extends State<SelectGenderNew> {
  int selectedIndex = 0;
  static List<String> list = ["Male", "Female", "Other"];
  String selectedOption = list[0];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Question 2/3'),
              Image.asset("assets/page-1/images/slide.jpg"),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff1F0A68), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 26,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select your gender',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width * 0.7,
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
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Future.delayed(const Duration(microseconds: 0), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  QNAScreen()));
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                                child: Icon(
                              Icons.arrow_circle_left_outlined,
                              size: 40,
                              color: Color(0xff1F0A68),
                            ))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString("gender", selectedOption);
                        if (!mounted) return;
                        Future.delayed(const Duration(microseconds: 0), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EducationLevelNew()));
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                                child: Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 40,
                              color: Color(0xff1F0A68),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
      height: 50,
      width: 270,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            elevation: 0,
            side: BorderSide(color: Color(0xff1F0A68)),
            backgroundColor: isActive ? const Color(0xff1F0A68) : Colors.white,
            foregroundColor: isActive ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
        child: Text(
          title,
          style: SafeGoogleFont(
            "Montserrat",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}
