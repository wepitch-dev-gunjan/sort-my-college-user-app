import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/colors_const.dart';

class Btn extends StatelessWidget {
  final Function() onTap;
  final String btnName;
  final Color? btnColor;
  final Color? textColor;
  const Btn(
      {super.key,
      required this.onTap,
      required this.btnName,
      this.btnColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 110,
        decoration: BoxDecoration(
          color: btnColor ?? Colors.white,
          border: Border.all(color: ColorsConst.appBarColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
            child: Text(
          btnName,
          style: TextStyle(
              fontWeight: FontWeight.w600, color: textColor ?? Colors.black),
        )),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const TextWithIcon(
      {super.key,
      required this.text,
      required this.icon,
      this.fontSize,
      this.fontWeight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
        ),
        const SizedBox(width: 2.0),
        Text(
          text,
          style: GoogleFonts.lato(
              fontSize: fontSize ?? 10,
              color: color ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.w400),
        ),
      ],
    );
  }
}

