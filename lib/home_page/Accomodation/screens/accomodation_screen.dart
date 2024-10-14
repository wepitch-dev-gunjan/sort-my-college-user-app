import 'package:flutter/material.dart';
import '../../../shared/colors_const.dart';
import '../../entrance_preparation/components/commons.dart';
import '../../entrance_preparation/screens/entrance_preparation_screen.dart';

class AccomodationScreen extends StatelessWidget {
  const AccomodationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: const CusAppBar(
        title: 'Accommodation',
        icon: Icons.search,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 15.0),
            TopSlider(
              sliderText: accommodationSliderText,
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/accommodation/testimage.png",
                      height: 180,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 10.0),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "data",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
