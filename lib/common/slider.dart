// // import 'package:carousel_slider/carousel_slider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';


// class ImageSlide extends StatefulWidget {
//   const ImageSlide({super.key});

//   @override
//   State<ImageSlide> createState() => _ImageSlideState();
// }

// class _ImageSlideState extends State<ImageSlide> {
//   List itemList = [
//     {"id": 1, "image": "assets/images/Group61.png"},
//     {"id": 2, "image": "assets/images/Rectangle.png"},
//     {"id": 3, "image": "assets/images/Rectangle14.png"},
//   ];

//   final CarouselController carouselController = CarouselController();
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             InkWell(
//               onTap: () {},
//               child: CarouselSlider(
//                   carouselController: carouselController,
//                   items: itemList
//                       .map((e) => Image.asset(
//                             e['image'],
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           ))
//                       .toList(),
//                   options: CarouselOptions(
//                       scrollPhysics: const BouncingScrollPhysics(),
//                       autoPlay: true,
//                       aspectRatio: 2,
//                       viewportFraction: 1,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           currentIndex = index;
//                         });
//                       })),
//             ),
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 10,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   for (int i = 0; i < itemList.length; i++)
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Container(
//                         height: 8,
//                         width: 8,
//                         // width: currentIndex == i ? 25 : 15,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(21),
//                           color: currentIndex == i
//                               ? Colors.amber
//                               : Colors.white,
//                         ),
//                       ),
//                     )
//                 ],
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }


// import 'package:carousel_slider/carousel_slider.dart' as carousel_slider_pkg;
// import 'package:flutter/material.dart';

// class ImageSlide extends StatefulWidget {
//   const ImageSlide({super.key});

//   @override
//   State<ImageSlide> createState() => _ImageSlideState();
// }

// class _ImageSlideState extends State<ImageSlide> {
//   List itemList = [
//     {"id": 1, "image": "assets/images/Group61.png"},
//     {"id": 2, "image": "assets/images/Rectangle.png"},
//     {"id": 3, "image": "assets/images/Rectangle14.png"},
//   ];

//   final carousel_slider_pkg.CarouselController carouselController = carousel_slider_pkg.CarouselController();
//   int currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Stack(
//           children: [
//             InkWell(
//               onTap: () {},
//               child: carousel_slider_pkg.CarouselSlider(
//                   carouselController: carouselController,
//                   items: itemList
//                       .map((e) => Image.asset(
//                             e['image'],
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           ))
//                       .toList(),
//                   options: carousel_slider_pkg.CarouselOptions(
//                       scrollPhysics: const BouncingScrollPhysics(),
//                       autoPlay: true,
//                       aspectRatio: 2,
//                       viewportFraction: 1,
//                       onPageChanged: (index, reason) {
//                         setState(() {
//                           currentIndex = index;
//                         });
//                       })),
//             ),
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               bottom: 10,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   for (int i = 0; i < itemList.length; i++)
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Container(
//                         height: 8,
//                         width: 8,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(21),
//                           color: currentIndex == i
//                               ? Colors.amber
//                               : Colors.white,
//                         ),
//                       ),
//                     )
//                 ],
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }
