// // import 'package:flutter/material.dart';
// //
// // class Botom extends StatefulWidget {
// //   const Botom({super.key});
// //
// //   @override
// //   State<Botom> createState() => _BotomState();
// // }
// //
// // class _BotomState extends State<Botom> {
// //   String currentGender = 'Male';
// //   String currentEducation = 'Bachelor';
// //
// //   List<String> genderList = ['Male', 'Female', 'Other'];
// //   List<String> educationList = ['Bachelor', 'Master', 'PhD', 'Other'];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         DropdownButton<String>(
// //           value: currentEducation,
// //           onChanged: (String? item) {
// //             currentEducation = item!;
// //             setState(() {});
// //           },
// //           items: educationList.map(
// //             (e) {
// //               return DropdownMenuItem(
// //                 value: e,
// //                 child: Text(e),
// //               );
// //             },
// //           ).toList(),
// //         ),
// //         const SizedBox(
// //           height: 16,
// //         ),
// //         DropdownButton<String>(
// //           value: currentGender,
// //           onChanged: (String? item) {
// //             currentGender = item!;
// //             setState(() {});
// //           },
// //           items: genderList.map(
// //             (e) {
// //               return DropdownMenuItem(
// //                 value: e,
// //                 child: Text(e),
// //               );
// //             },
// //           ).toList(),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:myapp/other/provider/counsellor_details_provider.dart';
// import 'package:provider/provider.dart';
//
// class DropDownButtonWidget extends StatefulWidget {
//   const DropDownButtonWidget({super.key});
//
//   @override
//   State<DropDownButtonWidget> createState() => _DropDownButtonWidgetState();
// }
//
// class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
//   CounsellorDetailsProvider counsellorDetailsProvider =
//       CounsellorDetailsProvider();
//
//   @override
//   void initState() {
//     counsellorDetailsProvider =
//         Provider.of<CounsellorDetailsProvider>(context, listen: false);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           readOnly: true,
//           controller: TextEditingController(
//               text: counsellorDetailsProvider.currentEducation),
//           decoration: const InputDecoration(
//             labelText: 'Education',
//             border: OutlineInputBorder(),
//           ),
//           onTap: () {
//             _showEducationDropdown();
//           },
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//         TextField(
//           readOnly: true,
//           controller: TextEditingController(
//               text: counsellorDetailsProvider.currentGender),
//           decoration: const InputDecoration(
//             labelText: 'Gender',
//             border: OutlineInputBorder(),
//           ),
//           onTap: () {
//             _showGenderDropdown();
//           },
//         ),
//       ],
//     );
//   }
//
//   Future<void> _showEducationDropdown() async {
//     String? result = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Education'),
//           content: DropdownButton<String>(
//             value: counsellorDetailsProvider.currentEducation,
//             onChanged: (String? item) {
//               Navigator.pop(context, item);
//             },
//             items: counsellorDetailsProvider.educationList.map(
//               (e) {
//                 return DropdownMenuItem(
//                   value: e,
//                   child: Text(e),
//                 );
//               },
//             ).toList(),
//           ),
//         );
//       },
//     );
//
//     if (result != null) {
//       setState(() {
//         counsellorDetailsProvider.currentEducation = result;
//       });
//     }
//   }
//
//   Future<void> _showGenderDropdown() async {
//     String? result = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Select Gender'),
//           content: DropdownButton<String>(
//             value: counsellorDetailsProvider.currentGender,
//             onChanged: (String? item) {
//               Navigator.pop(context, item);
//             },
//             items: counsellorDetailsProvider.genderList.map(
//               (e) {
//                 return DropdownMenuItem(
//                   value: e,
//                   child: Text(e),
//                 );
//               },
//             ).toList(),
//           ),
//         );
//       },
//     );
//
//     if (result != null) {
//       setState(() {
//         counsellorDetailsProvider.currentGender = result;
//       });
//     }
//   }
// }
