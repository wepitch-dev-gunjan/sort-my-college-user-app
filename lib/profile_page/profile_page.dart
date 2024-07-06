import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/constants.dart';
import 'package:myapp/page-1/account_delete.dart';
import 'package:myapp/profile_page/widget/profile_edit_dialog.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? path;
  String username = "";
  String phoneNumber = "";
  String dob = "";
  String gender = "";
  String eduLevel = "";
  var value;

  @override
  void initState() {
    super.initState();
    getAllInfo();
  }

  getAllInfo() async {
    await ApiService.get_profile().then((value) => loadDefaultValue());
  }

  loadDefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("name") ?? "N/A";
    phoneNumber = prefs.getString("phone_number") ?? "N/A";
    dob = prefs.getString("date_of_birth") ?? "N/A";
    gender = prefs.getString("gender") ?? "N/A";
    eduLevel = prefs.getString("education_level") ?? "N/A";
    if (prefs.getString("profile_pic") == null) {
      // load local pic
      setState(() {
        path = prefs.getString("profile_pic_local");
      });
    } else {
      setState(() {
        path = prefs.getString("profile_pic") ?? "N/A";
      });
    }
    setState(() {
      showSpinner = false;
    });
  }

  void saveImagePathToPrefs(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profile_pic_local", path);
    setState(() {});
  }

  File? image;
  // final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (xFile != null) {
      path = xFile.path;
      File image = File(xFile.path);
      await uploadImage(image).then((value) => saveimgmethod());
      return image;
    }
  }

  Future<void> uploadImage(File? image) async {
    if (image == null) {
      Fluttertoast.showToast(msg: 'No image selected');
      return;
    }

    Dio dio = Dio();
    setState(() {
      showSpinner = true;
    });

    try {
      var uri = '${AppConstants.baseUrl}/user/';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? '';

      if (token.isEmpty) {
        Fluttertoast.showToast(msg: 'Token is not available');
        setState(() {
          showSpinner = false;
        });
        return;
      }

      final headers = {
        "Authorization": token,
      };

      FormData formData = FormData.fromMap({
        'profile_pic':
            await MultipartFile.fromFile(image.path, filename: 'upload.jpg'),
      });

      final response = await dio.put(uri,
          options: Options(headers: headers), data: formData);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Image uploaded successfully');
        await ApiService.get_profile().then((value) => loadDefaultValue());
      } else {
        Fluttertoast.showToast(
            msg: 'Something went wrong while uploading image');
      }
    } catch (e) {
      log('Error uploading image: $e');
      Fluttertoast.showToast(msg: 'Error uploading image');
    } finally {
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          // logic
          SystemNavigator.pop();
        },
        child: Scaffold(
          backgroundColor: ColorsConst.whiteColor,
          appBar: AppBar(
            centerTitle: false,
            surfaceTintColor: ColorsConst.whiteColor,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xffffffff),
            foregroundColor: Colors.white,
            // titleSpacing: 28,
            title: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "My Profile",
                style: SafeGoogleFont("Inter",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: ColorsConst.appBarColor),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: path != null
                                ? path.toString().contains("https")
                                    ? Image.network(
                                        path.toString(),
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.low,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            'assets/page-1/images/book.jpg',
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.file(File(path!), fit: BoxFit.cover)
                                : Image.asset(
                                    'assets/page-1/images/profilepic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {
                              await getImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff1F0A68),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemProfile('Name', username, CupertinoIcons.person),
                  const Divider(),
                  itemProfile(
                      'Phone Number', phoneNumber, CupertinoIcons.phone),
                  const Divider(),
                  itemProfile('Date Of Birth', dob, CupertinoIcons.calendar),
                  const Divider(),
                  itemProfile('Gender', gender, CupertinoIcons.person),
                  const Divider(),
                  itemProfile('Education', eduLevel, CupertinoIcons.book),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 26, right: 26, top: 20),
                    child: SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return ProfileEditDialog(name: username);
                                });
                            getAllInfo();
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(2),
                              backgroundColor: const Color(0xff1F0A68)),
                          child: const Text('Edit Profile')),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 26, right: 26, top: 10),
                    child: SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Alert!'),
                                  content: const Text(
                                      'Are you sure want to Delete account!'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No')),
                                    TextButton(
                                      onPressed: () async {
                                        await _accountDelete();
                                      },
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(2),
                              backgroundColor: const Color(0xff1F0A68)),
                          child: const Text('Delete Account')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  itemProfile(
    String title,
    String subtitle,
    IconData iconData,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }

  saveimgmethod() {
    saveImagePathToPrefs(path!);
  }

  Future _accountDelete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await EasyLoading.show(
      dismissOnTap: false,
    );

    Future.delayed(const Duration(seconds: 1), () async {
      await prefs.clear();
      EasyLoading.dismiss();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AccountDelete()),
          (route) => false,
        );
      }
    });
  }
}
