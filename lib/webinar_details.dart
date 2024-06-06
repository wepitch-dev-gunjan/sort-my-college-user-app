// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:myapp/other/constants.dart';
// import 'package:myapp/webinar_page/model/webinar_details_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class WebinarDetailsPage1 extends StatefulWidget {
//   final String webinarId;

//   const WebinarDetailsPage1({super.key, required this.webinarId});

//   @override
//   _WebinarDetailsPage1State createState() => _WebinarDetailsPage1State();
// }

// class _WebinarDetailsPage1State extends State<WebinarDetailsPage1> {
//   List<WebinarDetailsModel> _webinarDetails = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchWebinarDetails();
//   }

//   Future<List<WebinarDetailsModel>> getWebinarDetailsData(String id) async {
//     var url = Uri.parse("${AppConstants.baseUrl}/admin/webinar/webinar-for-user/$id");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString("auth").toString();
//     final response = await http.get(url,headers: {
//       //"Content-Type": "application/json",
//       "Authorization": token,
//     });
//     var data;
//     if (response.statusCode == 200) {
//       data = jsonDecode(response.body.toString());
//       return List<WebinarDetailsModel>.from(
//           data.map((x) => WebinarDetailsModel.fromJson(x)));
//     }
//     return [];
//   }


//   Future<void> _fetchWebinarDetails() async {
//     try {
//       List<WebinarDetailsModel> webinarDetails = await getWebinarDetailsData(widget.webinarId);
//       setState(() {
//         _webinarDetails = webinarDetails;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching webinar details: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Webinar Details'),
//       ),
//       body: _isLoading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : _webinarDetails.isNotEmpty
//           ? ListView.builder(
//         itemCount: _webinarDetails.length,
//         itemBuilder: (context, index) {
//           WebinarDetailsModel webinar = _webinarDetails[index];
//           return ListTile(
//             title: Text(webinar.webinarTitle!),
//             subtitle: Text(webinar.webinarBy!),
//             // Add more widgets to display other details as needed
//           );
//         },
//       )
//           : const Center(
//         child: Text('No webinar details available'),
//       ),
//     );
//   }
// }
