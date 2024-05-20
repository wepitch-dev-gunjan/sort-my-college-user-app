import 'package:flutter/material.dart';
import 'package:myapp/shared/colors_const.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(
          "assets/page-1/images/comingsoon1.jpg",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
