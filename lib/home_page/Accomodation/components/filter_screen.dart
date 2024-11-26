import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/other/api_service.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  @override
  FilterScreenState createState() => FilterScreenState();
}

// class FilterScreenState extends State<FilterScreen> {
//   List cities = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     getcities();
//     super.initState();
//   }

//   getcities() async {
//     final res = await ApiService.getCities();
//     setState(() {
//       cities = res;
//       isLoading = false;
//     });
//   }

//   String selectedCategory = 'City';
//   String searchQuery = '';
//   Map<String, List<String>> filterOptions = {
//     'City': ['Jaipur', 'Mumbai', 'Pune', 'Chennai', 'Delhi'],
//     'Gender': ['Male', 'Female'],
//     'Occupancy Type': ['Single', 'Double', 'Triple'],
//     'Budget': ['Low', 'Medium', 'High'],
//     'Near By Colleges': ['College A', 'College B', 'College C'],
//   };

//   // Dynamically generated selected options
//   late Map<String, List<bool>> selectedOptions;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize selectedOptions dynamically
//     selectedOptions = {};
//     for (var category in filterOptions.keys) {
//       selectedOptions[category] =
//           List<bool>.filled(filterOptions[category]!.length, false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 460;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;

//     // Get the filtered options based on the search query
//     List<String> filteredOptions = filterOptions[selectedCategory]!
//         .where((option) =>
//             option.toLowerCase().contains(searchQuery.toLowerCase()))
//         .toList();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: 40,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Filters',
//           style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 // Clear all selected options
//                 for (var key in selectedOptions.keys) {
//                   selectedOptions[key] =
//                       List<bool>.filled(selectedOptions[key]!.length, false);
//                 }
//               });
//             },
//             child: Text(
//               'CLEAR ALL',
//               style: GoogleFonts.inter(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.height,
//             height: 0.5,
//             color: Colors.black12,
//           ),
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: ListView(
//                     children: filterOptions.keys.map((category) {
//                       bool isSelected = selectedCategory == category;
//                       return Column(
//                         children: [
//                           ListTile(
//                             title: Text(
//                               category,
//                               style: TextStyle(
//                                 color: isSelected ? Colors.white : Colors.black,
//                               ),
//                             ),
//                             tileColor: isSelected
//                                 ? const Color(0xff1F0A68)
//                                 : Colors.white,
//                             onTap: () {
//                               setState(() {
//                                 selectedCategory = category;
//                                 searchQuery = ''; // Reset search query
//                               });
//                             },
//                           ),
//                           Container(
//                             width: double.infinity,
//                             height: 1,
//                             color: Colors.black12,
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Container(
//                   width: 0.5,
//                   height: MediaQuery.of(context).size.height,
//                   color: Colors.black12,
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     children: [
//                       if (selectedCategory == 'City' ||
//                           selectedCategory == 'Near By Colleges')
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CupertinoSearchTextField(
//                             onChanged: (value) {
//                               setState(() {
//                                 searchQuery = value;
//                               });
//                             },
//                           ),
//                         ),

//                       // Checkbox List
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: filteredOptions.length,
//                           itemBuilder: (context, index) {
//                             String option = filteredOptions[index];
//                             int originalIndex = filterOptions[selectedCategory]!
//                                 .indexOf(option); // Get the original index
//                             return CheckboxListTile(
//                               controlAffinity: ListTileControlAffinity.leading,
//                               value: selectedOptions[selectedCategory]![
//                                   originalIndex],
//                               title: Text(option),
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   selectedOptions[selectedCategory]![
//                                       originalIndex] = value!;
//                                 });
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         padding: EdgeInsets.zero,
//         height: 50,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 60,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         width: 0.5,
//                         color: Colors.black12,
//                       )),
//                   child: Text(
//                     "CLOSE",
//                     style: GoogleFonts.inter(
//                       fontSize: 15 * ffem,
//                       color: const Color(0xff7F7E85),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   // Apply action
//                 },
//                 child: Container(
//                   color: const Color(0xff1F0A68),
//                   alignment: Alignment.center,
//                   height: 60.2,
//                   child: Text(
//                     "APPLY",
//                     style: GoogleFonts.inter(
//                       fontSize: 15 * ffem,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class FilterScreenState extends State<FilterScreen> {
  List<String> cities = [];
  List<String> colleges = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCities();
    getColleges();
    // Initialize selectedOptions dynamically
    selectedOptions = {};
    for (var category in filterOptions.keys) {
      selectedOptions[category] =
          List<bool>.filled(filterOptions[category]!.length, false);
    }
  }

  getCities() async {
    final res = await ApiService.getCities();
    setState(() {
      cities = res['cities'].cast<String>(); // Ensure it's a List<String>
      filterOptions['City'] = cities; // Dynamically update 'City' options
      selectedOptions['City'] =
          List<bool>.filled(cities.length, false); // Update selectedOptions
      isLoading = false;
    });
  }

  getColleges() async {
    final res = await ApiService.getColleges();
    setState(() {
      colleges = res['colleges'].cast<String>(); // Ensure it's a List<String>
      filterOptions['Near By Colleges'] =
          colleges; // Dynamically update 'City' options
      selectedOptions['Near By Colleges'] =
          List<bool>.filled(colleges.length, false); // Update selectedOptions
      isLoading = false;
    });
  }

  String selectedCategory = 'City';
  String searchQuery = '';
  Map<String, List<String>> filterOptions = {
    'City': [], // Initially empty, will be updated with fetched cities
    'Gender': ['Male', 'Female'],
    'Occupancy Type': ['Single', 'Double', 'Triple'],
    'Budget': ['Low', 'Medium', 'High'],
    'Near By Colleges': [],
  };

  late Map<String, List<bool>> selectedOptions;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    // Get the filtered options based on the search query
    List<String> filteredOptions = filterOptions[selectedCategory]!
        .where((option) =>
            option.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Filters',
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                // Clear all selected options
                for (var key in selectedOptions.keys) {
                  selectedOptions[key] =
                      List<bool>.filled(selectedOptions[key]!.length, false);
                }
              });
            },
            child: Text(
              'CLEAR ALL',
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  tileColor: isSelected
                                      ? const Color(0xff1F0A68)
                                      : Colors.white,
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = category;
                                      searchQuery = ''; // Reset search query
                                    });
                                  },
                                ),
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
                                  int originalIndex =
                                      filterOptions[selectedCategory]!.indexOf(
                                          option); // Get the original index
                                  return CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
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
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 0.5,
                        color: Colors.black12,
                      )),
                  child: Text(
                    "CLOSE",
                    style: GoogleFonts.inter(
                      fontSize: 15 * ffem,
                      color: const Color(0xff7F7E85),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Collect selected items into a map
                  Map<String, List<String>> selectedItems = {};
                  selectedOptions.forEach((category, values) {
                    List<String> selected = [];
                    for (int i = 0; i < values.length; i++) {
                      if (values[i]) {
                        selected.add(filterOptions[category]![i]);
                      }
                    }
                    if (selected.isNotEmpty) {
                      selectedItems[category] = selected;
                    }
                  });

                  log("Selected Items =>> $selectedItems");
                  Navigator.pop(context, selectedItems);
                },
                child: Container(
                  color: const Color(0xff1F0A68),
                  alignment: Alignment.center,
                  height: 60.2,
                  child: Text(
                    "APPLY",
                    style: GoogleFonts.inter(
                      fontSize: 15 * ffem,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// class FilterScreenState extends State<FilterScreen> {
//   String selectedCategory = 'City';
//   String searchQuery = '';
//   Map<String, List<String>> filterOptions = {
//     'City': ['Jaipur', 'Mumbai', 'Pune', 'Chennai', 'Delhi'],
//     'Gender': ['Male', 'Female'],
//     'Occupancy Type': ['Single', 'Double', 'Triple'],
//     'Budget': ['Low', 'Medium', 'High'],
//     'Near By Colleges': ['College A', 'College B', 'College C'],
//   };

//   // To manage the state of checkboxes
//   Map<String, List<bool>> selectedOptions = {
//     'City': [false, false, false, false, false],
//     'Gender': [false, false],
//     'Occupancy Type': [false, false, false],
//     'Budget': [false, false, false],
//     'Near By Colleges': [false, false, false],
//   };

//   @override
//   Widget build(BuildContext context) {
//     double baseWidth = 460;
//     double fem = MediaQuery.of(context).size.width / baseWidth;
//     double ffem = fem * 0.97;

//     // Get the filtered options based on the search query
//     List<String> filteredOptions = filterOptions[selectedCategory]!
//         .where((option) =>
//             option.toLowerCase().contains(searchQuery.toLowerCase()))
//         .toList();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         toolbarHeight: 40,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Filters',
//           style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 selectedOptions.forEach((key, value) {
//                   for (int i = 0; i < value.length; i++) {
//                     value[i] = false;
//                   }
//                 });
//               });
//             },
//             child: Text(
//               'CLEAR ALL',
//               style: GoogleFonts.inter(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.height,
//             height: 0.5,
//             color: Colors.black12,
//           ),
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: ListView(
//                     children: filterOptions.keys.map((category) {
//                       bool isSelected = selectedCategory == category;
//                       return Column(
//                         children: [
//                           ListTile(
//                             title: Text(
//                               category,
//                               style: TextStyle(
//                                 color: isSelected ? Colors.white : Colors.black,
//                               ),
//                             ),
//                             tileColor: isSelected
//                                 ? const Color(0xff1F0A68)
//                                 : Colors.white,
//                             onTap: () {
//                               setState(() {
//                                 selectedCategory = category;
//                                 searchQuery = ''; // Reset search query
//                               });
//                             },
//                           ),
//                           Container(
//                             width: double.infinity,
//                             height: 1,
//                             color: Colors.black12,
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 Container(
//                   width: 0.5,
//                   height: MediaQuery.of(context).size.height,
//                   color: Colors.black12,
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Column(
//                     children: [
//                       if (selectedCategory == 'City' ||
//                           selectedCategory == 'Near By Colleges')
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: CupertinoSearchTextField(
//                             onChanged: (value) {
//                               setState(() {
//                                 searchQuery = value;
//                               });
//                             },
//                           ),
//                         ),

//                       // Checkbox List
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: filteredOptions.length,
//                           itemBuilder: (context, index) {
//                             String option = filteredOptions[index];
//                             int originalIndex = filterOptions[selectedCategory]!
//                                 .indexOf(option); // Get the original index
//                             return CheckboxListTile(
//                               controlAffinity: ListTileControlAffinity.leading,
//                               value: selectedOptions[selectedCategory]![
//                                   originalIndex],
//                               title: Text(option),
//                               onChanged: (bool? value) {
//                                 setState(() {
//                                   selectedOptions[selectedCategory]![
//                                       originalIndex] = value!;
//                                 });
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         padding: EdgeInsets.zero,
//         height: 50,
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   height: 60,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border.all(
//                         width: 0.5,
//                         color: Colors.black12,
//                       )),
//                   child: Text(
//                     "CLOSE",
//                     style: GoogleFonts.inter(
//                       fontSize: 15 * ffem,
//                       color: const Color(0xff7F7E85),
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {},
//                 child: Container(
//                   color: const Color(0xff1F0A68),
//                   alignment: Alignment.center,
//                   height: 60.2,
//                   child: Text(
//                     "APPLY",
//                     style: GoogleFonts.inter(
//                       fontSize: 15 * ffem,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }