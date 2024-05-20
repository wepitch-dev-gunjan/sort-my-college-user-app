import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:myapp/page-1/select_gender_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDobNew extends StatefulWidget {
  const SelectDobNew({Key? key}) : super(key: key);

  @override
  State<SelectDobNew> createState() => _SelectDobNewState();
}

class _SelectDobNewState extends State<SelectDobNew> {
  late String date;
  String dob = "";

  @override
  void initState() {
    super.initState();
    date = "DD/MM/YYYY";
  }

  openDatePicker() async {
    var now = DateTime.now();
    var seventySevenYearsAgo = now.subtract(const Duration(days: 74 * 365));
    var firstDate = seventySevenYearsAgo;
    showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 460,
              width: 340,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    onSurface: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                  ),
                ),
                child: child!,
              ),
            ),
          ],
        );
      },
      context: context,
      firstDate: firstDate,
      lastDate: now,
    ).then((value) {
      if (value != null) {
        date = DateFormat("d/M/yyyy").format(value).toString();
        setState(() {});
      }
    });
  }


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
              const Text('Question 1/3'),
              Image.asset('assets/page-1/images/dob.jpg'),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff1F0A68), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 26, left: 20, right: 20, bottom: 140),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "What's your date of birth?",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text(
                            'DD/MM/YYYY',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          customButton(
                            onPressed: openDatePicker,
                            title: date,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, top: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (date == "DD/MM/YYYY") {
                          EasyLoading.showToast("Please select your date of birth.",
                              toastPosition: EasyLoadingToastPosition.bottom);
                        } else {
                          var selectedDate = DateFormat("d/M/yyyy").parse(date);
                          var now = DateTime.now();
                          var twelveYearsAgo = now.subtract(const Duration(days: 12 * 365));
                          if (selectedDate.isBefore(twelveYearsAgo)) {
                            var prefs = await SharedPreferences.getInstance();
                            final splittedate = date.split('/');
                            dob = "${splittedate[2]}-${splittedate[1]}-${splittedate[0]}";
                            prefs.setString("date_of_birth", dob);
                            if (!mounted) return;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SelectGenderNew(),
                              ),
                            );
                          } else {
                            EasyLoading.showToast("You must be at least 12 years old to proceed.",
                                toastPosition: EasyLoadingToastPosition.bottom);
                          }
                        }
                      },
                      child: const Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 40,
                        color: Color(0xff1F0A68),
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

  Widget customButton({
    required VoidCallback onPressed,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: SizedBox(
        height: 50,
        width: 200,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(color: Color(0xff1F0A68)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
