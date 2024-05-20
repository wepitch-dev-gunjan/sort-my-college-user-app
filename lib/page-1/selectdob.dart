import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:myapp/home_page/homepagecontainer.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDob extends StatefulWidget {
  const SelectDob({super.key});

  @override
  State<SelectDob> createState() => _SelectDobState();
}

class _SelectDobState extends State<SelectDob> {
  String date = "DD/MM/YYYY";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 86),
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
              //   child: Text(
              //     'All in one platform for student',
              //     textAlign: TextAlign.center,
              //     style: SafeGoogleFont(
              //       'Roboto',
              //       fontSize: 15,
              //       fontWeight: FontWeight.w700,
              //       height: 1.1725,
              //       color: const Color(0xff1f0a68),
              //     ),
              //   ),
              // ),
              Text(
                "Date of Birth",
                style: SafeGoogleFont(
                  "Montserrat",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              customButton(
                onPressed: () {
                  var now = DateTime.now();
                  var firstDate = DateTime(1999);
                  // var lastDate = DateTime(2010);

                  showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: firstDate,
                          lastDate: now)
                      .then((value) {
                    date = DateFormat("d/M/yyyy").format(value!).toString();
                    setState(() {});
                  });
                },
                title: date,
              ),
              const Spacer(),
              nextButton(
                  onPressed: () async {
                    if (date == "DD/MM/YYYY") {
                      EasyLoading.showToast("Please Select the date...",
                          toastPosition: EasyLoadingToastPosition.bottom);
                    } else {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setString("date", date);

                      if (!mounted) return;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePageContainer()));
                    }
                  },
                  title: "Next")
            ],
          ),
        ),
      ),
    );
  }
}

Widget customButton({
  required VoidCallback onPressed,
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: SizedBox(
      height: 70,
      width: 200,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xffD9D9D9),
            foregroundColor: Colors.black,
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
            fontSize: 20,
          ),
        )),
  );
}
