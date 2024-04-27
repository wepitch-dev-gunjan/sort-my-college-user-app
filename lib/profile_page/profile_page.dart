import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/profile_page/widget/profile_edit_dialog.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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

  void getAllInfo() async {
    ApiService.get_profile().then((value) => loadDefaultValue());
  }

  void loadDefaultValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("name") ?? "N/A";
    phoneNumber = prefs.getString("phone_number") ?? "N/A";
    dob = prefs.getString("date_of_birth") ?? "N/A";
    gender = prefs.getString("gender") ?? "N/A";
    eduLevel = prefs.getString("education_level") ?? "N/A";

    if(prefs.getString("profile_pic") == null)
     {
       // load local pic
       path = prefs.getString("profile_pic_local");
     }
    else{
      path = prefs.getString("profile_pic") ?? "N/A";
    }
    setState(() {});
  }

  void saveImagePathToPrefs(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profile_pic_local", path);
    setState(() {
    });

  }

  File? image ;
  final _picker = ImagePicker();
  bool showSpinner = false ;

  Future getImage() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      path = xFile.path;
      image = File(xFile.path);
      saveimgmethod();


      //await uploadImage().then((value) => saveimgmethod());

    }


  }


  Future<void> uploadImage ()async{

    setState(() {
      showSpinner = true ;
    });

    var stream  = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', uri);


    var multiport = http.MultipartFile(
        'profile_pic',
        stream,
        length);

    request.files.add(multiport);
    var response = await request.send() ;

    print(response.stream.toString());

    if(response.statusCode == 200){
      setState(() {
        showSpinner = false ;
      });

      //print('image uploaded');
      Fluttertoast.showToast(msg: 'image uploaded successfully');

    }
    else {
      //print('failed');
      Fluttertoast.showToast(msg: 'Something went wrong while uploading image');
      setState(() {
        showSpinner = false ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: PopScope(
        canPop: false,
        onPopInvoked : (didPop){
          // logic
          SystemNavigator.pop();
        },
        child: Scaffold(
          backgroundColor: ColorsConst.whiteColor,
          appBar: AppBar(
            surfaceTintColor: ColorsConst.whiteColor,
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xffffffff),
            foregroundColor: Colors.white,
            titleSpacing: 28,
            title: Text(
              "My Profile",
              style: SafeGoogleFont("Inter",
                  fontSize: 18, fontWeight: FontWeight.w600,color: ColorsConst.appBarColor),
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
                          height: 130,
                          width: 140,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: path != null
                                ?  path.toString().contains("https")
                                ?  Image.network(
                                    path.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace)
                                   {
                                    //print("Exception >> ${exception.toString()}");
                                    return Image.asset(
                                    'assets/page-1/images/profilepic.jpg',
                                     fit: BoxFit.cover,
                                    );
                              },
                            )
                             : Image.file(File(path!), fit: BoxFit.cover)
                                : Image.asset('assets/page-1/images/profilepic.jpg'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () async {

                              /* ImagePicker imagePicker = ImagePicker();
                               XFile? xFile = await imagePicker.pickImage(
                                 source: ImageSource.gallery,
                               );
                               if (xFile != null) {
                                 path = xFile.path;
                                 saveImagePathToPrefs(path!);


                                 //setState(() {});
                               } */

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
                  itemProfile('Phone Number', phoneNumber, CupertinoIcons.phone),
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
                    padding: const EdgeInsets.only(left: 26,right: 26,top: 20),
                    child: SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return const ProfileEditDialog();
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

}
