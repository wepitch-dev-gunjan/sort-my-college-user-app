import 'package:flutter/material.dart';
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
    );
    ;
  }
}
