import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
import 'package:myapp/home_page/notification_page/news/service/news_service.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/service/news_api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/dependency_injection.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/page-1/splash_screen_1.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isLoggedIn = await MyApp.loggIn();
  runApp(MyApp(isLoggedIn: isLoggedIn!));
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  static Future<bool?> loggIn() async {
    return await SharedPre.getAuthLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FollowerProvider()),
        ChangeNotifierProvider(
          create: (context) => CounsellorDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserBookingProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) =>
                NewsProvider(newsApiService: NewsApiService())),
        ChangeNotifierProvider(
            create: (context) => NewsProvider1(newsService: NewsService())),
      ],
      child: GetMaterialApp(
        title: 'SMC App',
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: SplashScreen1(isLoggedIn: isLoggedIn),
        builder: EasyLoading.init(),
      ),
    );
  }
}










// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Selectable Buttons')),
//         body: Center(child: SelectableButtons()),
//       ),
//     );
//   }
// }

// class SelectableButtons extends StatefulWidget {
//   @override
//   _SelectableButtonsState createState() => _SelectableButtonsState();
// }

// class _SelectableButtonsState extends State<SelectableButtons> {
//   int? selectedButtonIndex;

//   void _onButtonPressed(int index) {
//     setState(() {
//       selectedButtonIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(5, (index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ElevatedButton(
//             onPressed: () => _onButtonPressed(index),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: selectedButtonIndex == index ? Colors.blue : Colors.grey,
//             ),
//             child: Text('Button ${index + 1}'),
//           ),
//         );
//       }),
//     );
//   }
// }



//   Future getImage() async {
//     ImagePicker imagePicker = ImagePicker();
//     XFile? xFile = await imagePicker.pickImage(
//       source: ImageSource.gallery,
//     );

//     if (xFile != null) {
//       path = xFile.path;
//       File image = File(xFile.path);
//       await uploadImage(image).then((value) => saveimgmethod());
//       return image;
//     }
//   }
// Future<void> uploadImage(File? image) async {
//   if (image == null) {
//     Fluttertoast.showToast(msg: 'No image selected');
//     return;
//   }

//   Dio dio = Dio();
//   setState(() {
//     showSpinner = true;
//   });

//   try {
//     var uri = '${AppConstants.baseUrl}/user/';
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString("token") ?? '';

//     if (token.isEmpty) {
//       Fluttertoast.showToast(msg: 'Token is not available');
//       setState(() {
//         showSpinner = false;
//       });
//       return;
//     }

//     Uint8List imageBytes = await image.readAsBytes();

//     String base64String = base64Encode(imageBytes);

//     final headers = {
//       "Authorization": token,
//       "Content-Type": "application/json",
//     };

//     final data = {
//       'profile_pic': base64String,
//     };

//     final response = await dio.put(uri,
//         options: Options(headers: headers), data: data);

//     if (response.statusCode == 200) {
//       Fluttertoast.showToast(msg: 'Image uploaded successfully');
//       await ApiService.get_profile().then((value) => loadDefaultValue());
//     } else {
//       Fluttertoast.showToast(
//           msg: 'Something went wrong while uploading image');
//     }
//   } catch (e) {
//     log('Error uploading image: $e');
//     Fluttertoast.showToast(msg: 'Error uploading image');
//   } finally {
//     setState(() {
//       showSpinner = false;
//     });
//   }
// }