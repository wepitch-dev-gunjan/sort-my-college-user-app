import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              child:const  Text('CLOSE'),
            ),
            ElevatedButton(
              onPressed: () {
                // Apply filter logic here
              },
              child:const  Text('APPLY'),
            ),
          ],
        ),
      ),
    );
  }
}
