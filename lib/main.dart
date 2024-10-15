import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myapp/home_page/notification_page/news/provider/news_provider1.dart';
import 'package:myapp/home_page/notification_page/news/service/news_service.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/service/news_api_service.dart';
import 'package:myapp/other/provider/counsellor_details_provider.dart';
import 'package:myapp/other/provider/follower_provider.dart';
import 'package:myapp/other/provider/user_booking_provider.dart';
import 'package:myapp/page-1/shared.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/utils/common.dart';
import 'package:provider/provider.dart';

import 'page-1/splash_screen_1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  bool? isLoggedIn = await MyApp.loggIn();
  runApp(MyApp(isLoggedIn: isLoggedIn!));
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
            create: (context) => CounsellorDetailsProvider()),
        ChangeNotifierProvider(create: (context) => UserBookingProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                NewsProvider(newsApiService: NewsApiService())),
        ChangeNotifierProvider(
            create: (context) => NewsProvider1(newsService: NewsService())),
      ],
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        child: GetMaterialApp(
          title: 'SMC App',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: snackbarKey,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(primarySwatch: Colors.grey),
          home: SplashScreen1(isLoggedIn: isLoggedIn),
          // home: FilterScreen(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String selectedCategory = 'City'; // Default category
  String searchQuery = ''; // To filter search results

  Map<String, List<String>> filterOptions = {
    'City': ['Jaipur', 'Mumbai', 'Pune', 'Chennai', 'Delhi'],
    'Gender': ['Male', 'Female'],
    'Occupancy Type': ['Single', 'Double', 'Triple'],
    'Budget': ['Low', 'Medium', 'High'],
    'Near By Colleges': ['College A', 'College B', 'College C'],
  };

  // To manage the state of checkboxes
  Map<String, List<bool>> selectedOptions = {
    'City': [false, false, false, false, false],
    'Gender': [false, false],
    'Occupancy Type': [false, false, false],
    'Budget': [false, false, false],
    'Near By Colleges': [false, false, false],
  };

  @override
  Widget build(BuildContext context) {
    // Get the filtered options based on the search query
    List<String> filteredOptions = filterOptions[selectedCategory]!
        .where((option) =>
            option.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {
              // Clear all checkboxes
              setState(() {
                selectedOptions.forEach((key, value) {
                  for (int i = 0; i < value.length; i++) {
                    value[i] = false;
                  }
                });
              });
            },
            child: const Text(
              'CLEAR ALL',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.height,
            height: 0.5,
            color: Colors.black12,
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: filterOptions.keys.map((category) {
                      bool isSelected = selectedCategory == category;
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            tileColor:
                                isSelected ? Color(0xff1F0A68) : Colors.white,
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                                searchQuery = ''; // Reset search query
                              });
                            },
                          ),
                          // Line separator under each category
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.black12,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: 0.5,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black12,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Show search bar only for City or Near By Colleges
                      if (selectedCategory == 'City' ||
                          selectedCategory == 'Near By Colleges')
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoSearchTextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                          ),
                        ),

                      // Checkbox List
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredOptions.length,
                          itemBuilder: (context, index) {
                            String option = filteredOptions[index];
                            int originalIndex = filterOptions[selectedCategory]!
                                .indexOf(option); // Get the original index
                            return CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: selectedOptions[selectedCategory]![
                                  originalIndex],
                              title: Text(option),
                              onChanged: (bool? value) {
                                setState(() {
                                  selectedOptions[selectedCategory]![
                                      originalIndex] = value!;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close filter screen
              },
              child: Text('CLOSE'),
            ),
            ElevatedButton(
              onPressed: () {
                // Apply filter logic here
              },
              child: Text('APPLY'),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CarouselWithIcon(),
//     );
//   }
// }

// class CarouselWithIcon extends StatefulWidget {
//   @override
//   _CarouselWithIconState createState() => _CarouselWithIconState();
// }

// class _CarouselWithIconState extends State<CarouselWithIcon> {
//   int _currentIndex = 0;

//   final List<String> _carouselTexts = [
//     "Find Your Ideal Student Accommodation",
//     "Compare Prices and Features",
//     "Secure Your Booking Now",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Main container with text, icon, and dots
//               Container(
//                 height: 100, // Adjust height as per your design
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           // Carousel Slider for text
//                           Expanded(
//                             child: CarouselSlider(
//                               options: CarouselOptions(
//                                 autoPlay: true,
//                                 enlargeCenterPage: true,
//                                 viewportFraction: 1.0, // Show only one item
//                                 onPageChanged: (index, reason) {
//                                   setState(() {
//                                     _currentIndex = index;
//                                   });
//                                 },
//                               ),
//                               items: _carouselTexts.map((text) {
//                                 return Builder(
//                                   builder: (BuildContext context) {
//                                     return Center(
//                                       child: Text(
//                                         text,
//                                         style: const TextStyle(fontSize: 16),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     );
//                                   },
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                           // Static Icon on the right
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 20.0),
//                             child: Icon(
//                               Icons.home,
//                               size: 50, // Adjust icon size
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     // Dots indicator inside the container
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: _carouselTexts.map((text) {
//                           int index = _carouselTexts.indexOf(text);
//                           return Container(
//                             width: 8.0,
//                             height: 8.0,
//                             margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: _currentIndex == index
//                                   ? Colors.black
//                                   : Colors.grey,
//                             ),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
