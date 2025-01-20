import 'package:flutter/material.dart';
import 'package:myapp/page-1/edulevel_new.dart';
import 'package:myapp/page-1/select_gender_new.dart';
import 'package:myapp/page-1/selectdob_new.dart';

class QNAScreen extends StatelessWidget {
  const QNAScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          SelectDobNew(),
          SelectGenderNew(),
          EducationLevelNew(),
        ],
      )
    );
  }
}