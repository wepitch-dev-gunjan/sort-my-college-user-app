import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/profile_page/widget/drop_down_dialog.dart';
import 'package:myapp/profile_page/widget/edit_dob_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/utils.dart';

class ProfileEditDialog extends StatefulWidget {
  final String name;
  final String education;
  final String gender, dob;
  const ProfileEditDialog(
      {super.key,
      required this.name,
      required this.education,
      required this.gender,
      required this.dob});

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  String? currentEducation;
  String? currentGender;
  String? currentDob;
  String username = "";

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _educontroller = TextEditingController();
  final TextEditingController _dobcontroller = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namecontroller.text = widget.name;
    _educontroller.text = widget.education;
    _dobcontroller.text = widget.dob;
    _genderController.text = widget.gender;
    loaddefaultValue();
  }

  void loaddefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentEducation = prefs.getString('education_level');
    currentGender = prefs.getString('gender');
    currentDob = prefs.getString('date_of_birth');
    username = prefs.getString("name") ?? "N/A";
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 430;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Edit User Detail'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: TextFormField(
                cursorColor: Colors.black,
                controller: _namecontroller,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(40),
                ],
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black, fontSize: 15.0),
                  hintText: "Enter Your Full Name",
                  border: OutlineInputBorder(),
                ),
                style: SafeGoogleFont(
                  'Roboto',
                  fontSize: 18 * ffem,
                  fontWeight: FontWeight.w400,
                  height: 1.1810 * ffem / fem,
                  color: const Color(0xff000000),
                ),
              ),
            ),
            TextField(
              readOnly: true,
              controller: _educontroller,
              decoration: const InputDecoration(
                labelText: 'Education',
                border: OutlineInputBorder(),
              ),
              onTap: () {
                showEducationDropdown(context);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              readOnly: true,
              controller: _genderController,
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                showGenderDropdown(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            EditDobWidget(
              dob: widget.dob,
              callback: (String dob) {
                setState(() {
                  currentDob = dob;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1F0A68)),
          onPressed: saveDetails,
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        )
        // TextButton(
        //   onPressed: saveDetails,
        //   child: const Text('Save'),
        // ),
      ],
    );
  }

  Future<void> saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', _namecontroller.text.toString());

    if (currentEducation != null) {
      prefs.setString('education_level', currentEducation!);
    }

    if (currentGender != null) {
      prefs.setString('gender', currentGender!);
    }

    if (currentDob != null) {
      prefs.setString('date_of_birth', currentDob!);
    }

    ApiService.save_profile(
      name: prefs.getString('name'),
      dob: prefs.getString("date_of_birth"),
      gender: prefs.getString("gender"),
      edulevel: prefs.getString("education_level"),
    ).then((value) => Navigator.pop(context));
  }

  

  void showEducationDropdown(BuildContext context) async {
    List<String> educationList = [
      "School",
      "College",
      "Graduated",
    ];

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DropDownDialog(
          callback: (value) {
            setState(() {
              if (value == "School") {
                currentEducation = "Student";
              } else if (value == "Graduated") {
                currentEducation = "Graduated";
              } else {
                currentEducation = value;
              }
              // Update the controller text
              _educontroller.text = currentEducation!;
            });
          },
          itemList: educationList,
          label: 'Select Education',
        );
      },
    );
  }

  void showGenderDropdown(BuildContext context) async {
    List<String> genderList = ['Male', 'Female', 'Other'];
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DropDownDialog(
          callback: (value) {
            setState(() {
              currentGender = value;
              // Update the controller text
              _genderController.text = currentGender!;
            });
          },
          itemList: genderList,
          label: 'Select Gender',
        );
      },
    );
  }
}
