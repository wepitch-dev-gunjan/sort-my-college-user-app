import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/profile_page/widget/drop_down_dialog.dart';
import 'package:myapp/profile_page/widget/edit_dob_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditDialog extends StatefulWidget {
  const ProfileEditDialog({super.key});

  @override
  State<ProfileEditDialog> createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  String? currentEducation;
  String? currentGender;
  String? currentDob;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddefaultValue();

  }

  void loaddefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentEducation = prefs.getString('education_level');
    currentGender = prefs.getString('gender');
    currentDob = prefs.getString('date_of_birth');

  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit User Detail'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              readOnly: true,
              controller: TextEditingController(text: currentEducation),
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
              controller: TextEditingController(text: currentGender),
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: saveDetails,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> saveDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool valueSaved = false;

    if (currentEducation != null) {
      prefs.setString('education_level', currentEducation!);
      valueSaved = true;
    }

    if (currentGender != null) {
      prefs.setString('gender', currentGender!);
      valueSaved = true;
    }

    if (currentDob != null) {
      prefs.setString('date_of_birth', currentDob!);
      valueSaved = true;
    }


    ApiService.save_profile(
        prefs.getString("name"),
        prefs.getString("date_of_birth"),
        prefs.getString("gender"),
        prefs.getString("education_level")).then((value) => Navigator.pop(context));

  }


  void showEducationDropdown(BuildContext context) async {
    List<String> educationList = [
      "School",
      "College",
      "Graduation",
    ];

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DropDownDialog(
          callback: (value) {
            setState(() {
              if (value == "School") {
                currentEducation = "Student";
              } else {
                currentEducation = value;
              }
              if (value == "Graduation") {
                currentEducation = "Graduated";
              } else {
                currentEducation = value;
              }
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
            });
          },
          itemList: genderList,
          label: 'Select Gender',
        );
      },
    );
  }
}
