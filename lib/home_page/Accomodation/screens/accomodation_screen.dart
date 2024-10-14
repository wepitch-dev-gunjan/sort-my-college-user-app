import 'package:flutter/material.dart';
import 'package:myapp/home_page/entrance_preparation/components/shimmer_effect.dart';
import '../../../shared/colors_const.dart';
import '../../entrance_preparation/components/commons.dart';

class AccomodationScreen extends StatelessWidget {
  const AccomodationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: const CusAppBar(
        title: 'Accommodation',
        icon: Icons.search,
      ),
      body: AccommodationShimmerEffect(),
      // body: SingleChildScrollView(
      //     child: Column(
      //   children: [
      //     const SizedBox(height: 15.0),
      //     TopSlider(
      //       sliderText: accommodationSliderText,
      //     ),
      //     const SizedBox(height: 10.0),
      //     AccommodationShimmerEffect()
      //   ],
      // )),
    );
  }
}
