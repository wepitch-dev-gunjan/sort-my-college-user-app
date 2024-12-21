import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  final List<String> cities;
  final List<String> colleges;

  const FilterScreen({super.key, required this.cities, required this.colleges});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen>
    with WidgetsBindingObserver {
  bool isLoading = true;
  String selectedCategory = 'City';
  String searchQuery = '';
  Map<String, List<String>> filterOptions = {
    'City': [],
    'Gender': ['Male', 'Female'],
    'Occupancy Type': ['Single', 'Double', 'Triple'],
    'Budget': [],
    'Near By Colleges': [],
  };

  late Map<String, List<bool>> selectedOptions;
  RangeValues budgetRange = const RangeValues(1000, 100000);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    filterOptions['City'] = widget.cities;
    filterOptions['Near By Colleges'] = widget.colleges;

    selectedOptions = {};
    for (var category in filterOptions.keys) {
      selectedOptions[category] =
          List<bool>.filled(filterOptions[category]!.length, false);
    }

    _loadFilters();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _clearFilters(); // Clear filters when app is terminated or goes to background
    }
  }

  Future<void> _loadFilters() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedFilters = prefs.getString('selectedFilters');
    String? savedBudget = prefs.getString('budgetRange');

    if (savedFilters != null) {
      setState(() {
        selectedOptions = Map<String, List<bool>>.from(
          jsonDecode(savedFilters).map(
            (key, value) => MapEntry(key, List<bool>.from(value)),
          ),
        );
      });
    }

    if (savedBudget != null) {
      setState(() {
        List<double> budgetValues =
            List<double>.from(jsonDecode(savedBudget).map((e) => e.toDouble()));
        budgetRange = RangeValues(budgetValues[0], budgetValues[1]);
        filterOptions['Budget'] = [
          '${budgetRange.start.toInt()}',
          '${budgetRange.end.toInt()}',
        ];
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedFilters', jsonEncode(selectedOptions));
    await prefs.setString(
        'budgetRange', jsonEncode([budgetRange.start, budgetRange.end]));
  }

  Future<void> _clearFilters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('selectedFilters');
    await prefs.remove('budgetRange');
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

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
            onPressed: () async {
              setState(() {
                for (var key in selectedOptions.keys) {
                  selectedOptions[key] =
                      List<bool>.filled(selectedOptions[key]!.length, false);
                }
              });
              await _clearFilters();
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
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
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
                                      searchQuery = '';
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
                            if (selectedCategory == 'Budget')
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Budget Range: ₹${budgetRange.start.toInt()} - ₹${budgetRange.end.toInt()}',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    RangeSlider(
                                      values: budgetRange,
                                      min: 1000,
                                      max: 100000,
                                      divisions: ((100000 - 1000) / 1000)
                                          .round(), // 99 divisions
                                      activeColor: const Color(0xff1F0A68),
                                      inactiveColor: Colors.grey,
                                      labels: RangeLabels(
                                        '${budgetRange.start.toInt()}',
                                        '${budgetRange.end.toInt()}',
                                      ),
                                      onChanged: (RangeValues values) {
                                        setState(() {
                                          budgetRange = values;
                                          filterOptions['Budget'] = [
                                            '${budgetRange.start.toInt()}',
                                            '${budgetRange.end.toInt()}',
                                          ];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            if (selectedCategory != 'Budget')
                              Expanded(
                                child: ListView.builder(
                                  itemCount: filteredOptions.length,
                                  itemBuilder: (context, index) {
                                    String option = filteredOptions[index];
                                    int originalIndex =
                                        filterOptions[selectedCategory]!
                                            .indexOf(option);
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
                onTap: () async {
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

                  if (filterOptions['Budget'] != null &&
                      filterOptions['Budget']!.isNotEmpty) {
                    selectedItems['Budget'] = filterOptions['Budget']!;
                  }

                  log("Selected Items =>> $selectedItems");
                  await _saveFilters();
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

// class FilterScreen extends StatefulWidget {
//   final List<String> cities;
//   final List<String> colleges;

//   const FilterScreen({super.key, required this.cities, required this.colleges});

//   @override
//   FilterScreenState createState() => FilterScreenState();
// }



// class FilterScreenState extends State<FilterScreen> {
//   bool isLoading = true;

//   String selectedCategory = 'City';
//   String searchQuery = '';
//   Map<String, List<String>> filterOptions = {
//     'City': [],
//     'Gender': ['Male', 'Female'],
//     'Occupancy Type': ['Single', 'Double', 'Triple'],
//     'Budget': [], // Initially empty
//     'Near By Colleges': [],
//   };

//   late Map<String, List<bool>> selectedOptions;
//   RangeValues budgetRange = const RangeValues(1000, 10000); // Budget range slider values

//   @override
//   void initState() {
//     super.initState();

//     filterOptions['City'] = widget.cities;
//     filterOptions['Near By Colleges'] = widget.colleges;

//     selectedOptions = {};
//     for (var category in filterOptions.keys) {
//       selectedOptions[category] =
//           List<bool>.filled(filterOptions[category]!.length, false);
//     }

//     _loadFilters();
//   }

//   Future<void> _loadFilters() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? savedFilters = prefs.getString('selectedFilters');
//     String? savedBudget = prefs.getString('budgetRange');

//     if (savedFilters != null) {
//       setState(() {
//         selectedOptions = Map<String, List<bool>>.from(
//           jsonDecode(savedFilters).map(
//             (key, value) => MapEntry(key, List<bool>.from(value)),
//           ),
//         );
//       });
//     }

//     if (savedBudget != null) {
//       setState(() {
//         List<double> budgetValues =
//             List<double>.from(jsonDecode(savedBudget).map((e) => e.toDouble()));
//         budgetRange = RangeValues(budgetValues[0], budgetValues[1]);
//         filterOptions['Budget'] = [
//           '₹${budgetRange.start.toInt()}',
//           '₹${budgetRange.end.toInt()}',
//         ];
//       });
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> _saveFilters() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('selectedFilters', jsonEncode(selectedOptions));
//     await prefs.setString(
//         'budgetRange', jsonEncode([budgetRange.start, budgetRange.end]));
//   }

//   Future<void> _clearFilters() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('selectedFilters');
//     await prefs.remove('budgetRange');
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
//             onPressed: () async {
//               setState(() {
//                 for (var key in selectedOptions.keys) {
//                   selectedOptions[key] =
//                       List<bool>.filled(selectedOptions[key]!.length, false);
//                 }
//               });
//               await _clearFilters(); // Clear filters from SharedPreferences
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
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ))
//           : Column(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.height,
//                   height: 0.5,
//                   color: Colors.black12,
//                 ),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: ListView(
//                           children: filterOptions.keys.map((category) {
//                             bool isSelected = selectedCategory == category;
//                             return Column(
//                               children: [
//                                 ListTile(
//                                   title: Text(
//                                     category,
//                                     style: TextStyle(
//                                       color: isSelected
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                   ),
//                                   tileColor: isSelected
//                                       ? const Color(0xff1F0A68)
//                                       : Colors.white,
//                                   onTap: () {
//                                     setState(() {
//                                       selectedCategory = category;
//                                       searchQuery = ''; // Reset search query
//                                     });
//                                   },
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 1,
//                                   color: Colors.black12,
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Container(
//                         width: 0.5,
//                         height: MediaQuery.of(context).size.height,
//                         color: Colors.black12,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           children: [
//                             if (selectedCategory == 'City' ||
//                                 selectedCategory == 'Near By Colleges')
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CupertinoSearchTextField(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       searchQuery = value;
//                                     });
//                                   },
//                                 ),
//                               ),

//                             // Budget Range Slider
//                             if (selectedCategory == 'Budget')
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       'Budget Range: ₹${budgetRange.start.toInt()} - ₹${budgetRange.end.toInt()}',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     RangeSlider(
//                                       values: budgetRange,
//                                       min: 1000,
//                                       max: 10000,
//                                       divisions: 18,
//                                       activeColor: const Color(0xff1F0A68),
//                                       inactiveColor: Colors.grey,
//                                       labels: RangeLabels(
//                                         '₹${budgetRange.start.toInt()}',
//                                         '₹${budgetRange.end.toInt()}',
//                                       ),
//                                       onChanged: (RangeValues values) {
//                                         setState(() {
//                                           budgetRange = values;

//                                           // Dynamically update the Budget list in filterOptions
//                                           filterOptions['Budget'] = [
//                                             '₹${budgetRange.start.toInt()}',
//                                             '₹${budgetRange.end.toInt()}',
//                                           ];
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                             // Checkbox List
//                             if (selectedCategory != 'Budget')
//                               Expanded(
//                                 child: ListView.builder(
//                                   itemCount: filteredOptions.length,
//                                   itemBuilder: (context, index) {
//                                     String option = filteredOptions[index];
//                                     int originalIndex =
//                                         filterOptions[selectedCategory]!
//                                             .indexOf(option); // Get the original index
//                                     return CheckboxListTile(
//                                       controlAffinity:
//                                           ListTileControlAffinity.leading,
//                                       value: selectedOptions[selectedCategory]![originalIndex],
//                                       title: Text(option),
//                                       onChanged: (bool? value) {
//                                         setState(() {
//                                           selectedOptions[selectedCategory]![originalIndex] = value!;
//                                         });
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
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
//                 onTap: () async {
//                   // Collect selected items into a map
//                   Map<String, List<String>> selectedItems = {};
//                   selectedOptions.forEach((category, values) {
//                     List<String> selected = [];
//                     for (int i = 0; i < values.length; i++) {
//                       if (values[i]) {
//                         selected.add(filterOptions[category]![i]);
//                       }
//                     }
//                     if (selected.isNotEmpty) {
//                       selectedItems[category] = selected;
//                     }
//                   });

//                   // Add Budget range to selectedItems
//                   if (filterOptions['Budget'] != null && filterOptions['Budget']!.isNotEmpty) {
//                     selectedItems['Budget'] = filterOptions['Budget']!;
//                   }

//                   log("Selected Items =>> $selectedItems");
//                   await _saveFilters(); // Save filters before navigating away
//                   Navigator.pop(context, selectedItems);
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



// class FilterScreenState extends State<FilterScreen> {
//   bool isLoading = true;

//   String selectedCategory = 'City';
//   String searchQuery = '';
//   Map<String, List<String>> filterOptions = {
//     'City': [],
//     'Gender': ['Male', 'Female'],
//     'Occupancy Type': ['Single', 'Double', 'Triple'],
//     'Budget': ['Low', 'Medium', 'High'],
//     'Near By Colleges': [],
//   };

//   late Map<String, List<bool>> selectedOptions;

//   @override
//   void initState() {
//     super.initState();

//     filterOptions['City'] = widget.cities;
//     filterOptions['Near By Colleges'] = widget.colleges;

//     selectedOptions = {};
//     for (var category in filterOptions.keys) {
//       selectedOptions[category] =
//           List<bool>.filled(filterOptions[category]!.length, false);
//     }

//     setState(() {
//       isLoading = false;
//     });
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
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ))
//           : Column(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.height,
//                   height: 0.5,
//                   color: Colors.black12,
//                 ),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: ListView(
//                           children: filterOptions.keys.map((category) {
//                             bool isSelected = selectedCategory == category;
//                             return Column(
//                               children: [
//                                 ListTile(
//                                   title: Text(
//                                     category,
//                                     style: TextStyle(
//                                       color: isSelected
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                   ),
//                                   tileColor: isSelected
//                                       ? const Color(0xff1F0A68)
//                                       : Colors.white,
//                                   onTap: () {
//                                     setState(() {
//                                       selectedCategory = category;
//                                       searchQuery = ''; // Reset search query
//                                     });
//                                   },
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 1,
//                                   color: Colors.black12,
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Container(
//                         width: 0.5,
//                         height: MediaQuery.of(context).size.height,
//                         color: Colors.black12,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           children: [
//                             if (selectedCategory == 'City' ||
//                                 selectedCategory == 'Near By Colleges')
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CupertinoSearchTextField(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       searchQuery = value;
//                                     });
//                                   },
//                                 ),
//                               ),

//                             // Checkbox List
//                             Expanded(
//                               child: ListView.builder(
//                                 itemCount: filteredOptions.length,
//                                 itemBuilder: (context, index) {
//                                   String option = filteredOptions[index];
//                                   int originalIndex =
//                                       filterOptions[selectedCategory]!.indexOf(
//                                           option); // Get the original index
//                                   return CheckboxListTile(
//                                     controlAffinity:
//                                         ListTileControlAffinity.leading,
//                                     value: selectedOptions[selectedCategory]![
//                                         originalIndex],
//                                     title: Text(option),
//                                     onChanged: (bool? value) {
//                                       setState(() {
//                                         selectedOptions[selectedCategory]![
//                                             originalIndex] = value!;
//                                       });
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
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
//                   // Collect selected items into a map
//                   Map<String, List<String>> selectedItems = {};
//                   selectedOptions.forEach((category, values) {
//                     List<String> selected = [];
//                     for (int i = 0; i < values.length; i++) {
//                       if (values[i]) {
//                         selected.add(filterOptions[category]![i]);
//                       }
//                     }
//                     if (selected.isNotEmpty) {
//                       selectedItems[category] = selected;
//                     }
//                   });

//                   log("Selected Items =>> $selectedItems");
//                   Navigator.pop(context, selectedItems);
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

// class FilterScreenState extends State<FilterScreen> {
//   bool isLoading = true;

//   String selectedCategory = 'City';
//   String searchQuery = '';
//   Map<String, List<String>> filterOptions = {
//     'City': [],
//     'Gender': ['Male', 'Female'],
//     'Occupancy Type': ['Single', 'Double', 'Triple'],
//     'Budget': ['Low', 'Medium', 'High'],
//     'Near By Colleges': [],
//   };

//   late Map<String, List<bool>> selectedOptions;
//   RangeValues budgetRange =
//       const RangeValues(1000, 10000); // Budget range slider values

//   @override
//   void initState() {
//     super.initState();

//     filterOptions['City'] = widget.cities;
//     filterOptions['Near By Colleges'] = widget.colleges;

//     selectedOptions = {};
//     for (var category in filterOptions.keys) {
//       selectedOptions[category] =
//           List<bool>.filled(filterOptions[category]!.length, false);
//     }

//     setState(() {
//       isLoading = false;
//     });
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
//                 for (var key in selectedOptions.keys) {
//                   selectedOptions[key] =
//                       List<bool>.filled(selectedOptions[key]!.length, false);
//                 }
//                 budgetRange = const RangeValues(1000, 10000);
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
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(
//               strokeWidth: 2,
//             ))
//           : Column(
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.height,
//                   height: 0.5,
//                   color: Colors.black12,
//                 ),
//                 Expanded(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: ListView(
//                           children: filterOptions.keys.map((category) {
//                             bool isSelected = selectedCategory == category;
//                             return Column(
//                               children: [
//                                 ListTile(
//                                   title: Text(
//                                     category,
//                                     style: TextStyle(
//                                       color: isSelected
//                                           ? Colors.white
//                                           : Colors.black,
//                                     ),
//                                   ),
//                                   tileColor: isSelected
//                                       ? const Color(0xff1F0A68)
//                                       : Colors.white,
//                                   onTap: () {
//                                     setState(() {
//                                       selectedCategory = category;
//                                       searchQuery = ''; // Reset search query
//                                     });
//                                   },
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: 1,
//                                   color: Colors.black12,
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                       Container(
//                         width: 0.5,
//                         height: MediaQuery.of(context).size.height,
//                         color: Colors.black12,
//                       ),
//                       Expanded(
//                         flex: 3,
//                         child: Column(
//                           children: [
//                             if (selectedCategory == 'City' ||
//                                 selectedCategory == 'Near By Colleges')
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CupertinoSearchTextField(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       searchQuery = value;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             if (selectedCategory == 'Budget')
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       'Budget Range: ₹${budgetRange.start.toInt()} - ₹${budgetRange.end.toInt()}',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     RangeSlider(
//                                       values: budgetRange,
//                                       min: 1000,
//                                       max: 10000,
//                                       divisions: 18,
//                                       activeColor: const Color(0xff1F0A68),
//                                       inactiveColor: Colors.grey,
//                                       labels: RangeLabels(
//                                         '₹${budgetRange.start.toInt()}',
//                                         '₹${budgetRange.end.toInt()}',
//                                       ),
//                                       onChanged: (RangeValues values) {
//                                         setState(() {
//                                           budgetRange = values;
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),

//                             // Checkbox List
//                             if (selectedCategory != 'Budget')
//                               Expanded(
//                                 child: ListView.builder(
//                                   itemCount: filteredOptions.length,
//                                   itemBuilder: (context, index) {
//                                     String option = filteredOptions[index];
//                                     int originalIndex =
//                                         filterOptions[selectedCategory]!
//                                             .indexOf(option);
//                                     return CheckboxListTile(
//                                       controlAffinity:
//                                           ListTileControlAffinity.leading,
//                                       value: selectedOptions[selectedCategory]![
//                                           originalIndex],
//                                       title: Text(option),
//                                       onChanged: (bool? value) {
//                                         setState(() {
//                                           selectedOptions[selectedCategory]![
//                                               originalIndex] = value!;
//                                         });
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
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
//                   // Collect selected items into a map
//                   Map<String, dynamic> selectedItems = {};
//                   selectedOptions.forEach((category, values) {
//                     List<String> selected = [];
//                     for (int i = 0; i < values.length; i++) {
//                       if (values[i]) {
//                         selected.add(filterOptions[category]![i]);
//                       }
//                     }
//                     if (selected.isNotEmpty) {
//                       selectedItems[category] = selected;
//                     }
//                   });
//                   selectedItems['Budget'] = {
//                     'start': budgetRange.start.toInt(),
//                     'end': budgetRange.end.toInt(),
//                   };

//                   log("Selected Items =>> $selectedItems");
//                   Navigator.pop(context, selectedItems);

             
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
