import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../other/api_service.dart';

class FilterScreen extends StatefulWidget {
  final List<String> cities;

  const FilterScreen({super.key, required this.cities});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> with WidgetsBindingObserver {
  bool isLoading = true;
  String selectedCategory = 'City';
  String searchQuery = '';
  Map<String, List<String>> filterOptions = {
    'City': [],
    'Gender': ['Boys', 'Girls'],
    'Occupancy Type': ['Single', 'Double', 'Triple'],
    'Budget': [],
    'Near By Colleges': [],
  };

  late Map<String, List<bool>> selectedOptions;
  RangeValues budgetRange = const RangeValues(1000, 100000);
  bool isFetchingColleges = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    filterOptions['City'] = widget.cities;

    selectedOptions = {};
    for (var category in filterOptions.keys) {
      selectedOptions[category] = List<bool>.filled(filterOptions[category]!.length, false);
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
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      _clearFilters();
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

  // Modified to use ApiService.getColleges
  Future<List<String>> _fetchColleges() async {
    // Get selected cities
    List<String> selectedCities = [];
    for (int i = 0; i < selectedOptions['City']!.length; i++) {
      if (selectedOptions['City']![i]) {
        selectedCities.add(filterOptions['City']![i]);
      }
    }
    try {
      final res = await ApiService.getColleges(citys: selectedCities);
      return res['colleges'].cast<String>();
    } catch (e) {
    //  log('Error fetching colleges: $e');
      return [];
    }
  }

  Future<void> _loadColleges() async {
    if (filterOptions['Near By Colleges']!.isEmpty || selectedCategory == 'Near By Colleges') {
      setState(() {
        isFetchingColleges = true;
      });
      try {
        final colleges = await _fetchColleges();
        if (!mounted) return; // Check if widget is still mounted
        setState(() {
          filterOptions['Near By Colleges'] = colleges;
          selectedOptions['Near By Colleges'] = List<bool>.filled(colleges.length, false);
          isFetchingColleges = false;
        });
      } catch (e) {
        if (!mounted) return;
        setState(() {
          isFetchingColleges = false;
        });
         // log('Error in _loadColleges: $e');
        // Optionally show a snackbar or error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load colleges: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    List<String> filteredOptions = filterOptions[selectedCategory]!
        .where((option) => option.toLowerCase().contains(searchQuery.toLowerCase()))
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
                budgetRange = const RangeValues(1000, 100000);
                filterOptions['Budget'] = [];
                filterOptions['Near By Colleges'] = [];
                selectedOptions['Near By Colleges'] = [];
              });
              await _clearFilters();
            },
            child: Text(
              'CLEAR ALL',
              style: GoogleFonts.inter(
                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
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
                                      color: isSelected ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  tileColor:
                                      isSelected ? const Color(0xff1F0A68) : Colors.white,
                                  onTap: () async {
                                    setState(() {
                                      selectedCategory = category;
                                      searchQuery = '';
                                    });
                                    if (category == 'Near By Colleges') {
                                      await _loadColleges();
                                    }
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    child: Text(
                                      'Select Budget Range',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text(
                                      '₹${budgetRange.start.toInt()} - ₹${budgetRange.end.toInt()}',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  RangeSlider(
                                    values: budgetRange,
                                    min: 1000,
                                    max: 100000,
                                    divisions: ((100000 - 1000) / 1000).round(),
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
                            if (selectedCategory != 'Budget')
                              Expanded(
                                child: isFetchingColleges &&
                                        selectedCategory == 'Near By Colleges'
                                    ? const Center(
                                        child:
                                            CircularProgressIndicator(strokeWidth: 2))
                                    : ListView.builder(
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

// class FilterScreenState extends State<FilterScreen>
//     with WidgetsBindingObserver {
//   bool isLoading = true;
//   String selectedCategory = 'City';
//   String searchQuery = '';
//   Map<String, List<String>> filterOptions = {
//     'City': [],
//     'Gender': ['Boys', 'Girls'],
//     'Occupancy Type': ['Single', 'Double', 'Triple'],
//     'Budget': [],
//     'Near By Colleges': [],
//   };

//   late Map<String, List<bool>> selectedOptions;
//   RangeValues budgetRange = const RangeValues(1000, 100000);

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     filterOptions['City'] = widget.cities;
//     filterOptions['Near By Colleges'] = widget.colleges;

//     selectedOptions = {};
//     for (var category in filterOptions.keys) {
//       selectedOptions[category] =
//           List<bool>.filled(filterOptions[category]!.length, false);
//     }

//     _loadFilters();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.detached) {
//       _clearFilters(); // Clear filters when app is terminated or goes to background
//     }
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
//           '${budgetRange.start.toInt()}',
//           '${budgetRange.end.toInt()}',
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
//                 // Reset budget range and clear budget options
//                 budgetRange = const RangeValues(1000, 100000);
//                 filterOptions['Budget'] = [];
//               });
//               await _clearFilters();
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
//           ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
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
//                                       searchQuery = '';
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
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 15, vertical: 8),
//                                     child: Text(
//                                       'Select Budget Range',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5.0),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 15.0),
//                                     child: Text(
//                                       '₹${budgetRange.start.toInt()} - ₹${budgetRange.end.toInt()}',
//                                       style: GoogleFonts.inter(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ),
//                                   RangeSlider(
//                                     values: budgetRange,
//                                     min: 1000,
//                                     max: 100000,
//                                     divisions: ((100000 - 1000) / 1000).round(),
//                                     activeColor: const Color(0xff1F0A68),
//                                     inactiveColor: Colors.grey,
//                                     labels: RangeLabels(
//                                       '${budgetRange.start.toInt()}',
//                                       '${budgetRange.end.toInt()}',
//                                     ),
//                                     onChanged: (RangeValues values) {
//                                       setState(() {
//                                         budgetRange = values;
//                                         filterOptions['Budget'] = [
//                                           '${budgetRange.start.toInt()}',
//                                           '${budgetRange.end.toInt()}',
//                                         ];
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
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
//                 onTap: () async {
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

//                   if (filterOptions['Budget'] != null &&
//                       filterOptions['Budget']!.isNotEmpty) {
//                     selectedItems['Budget'] = filterOptions['Budget']!;
//                   }

//                   log("Selected Items =>> $selectedItems");
//                   await _saveFilters();
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
