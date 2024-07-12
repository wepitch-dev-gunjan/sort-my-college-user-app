import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/colors_const.dart';

class Btn extends StatelessWidget {
  final Function() onTap;
  final String btnName;
  final Color? btnColor;
  final Color? textColor;
  final double? height, width, borderRadius;
  const Btn(
      {super.key,
      required this.onTap,
      required this.btnName,
      this.btnColor,
      this.textColor,
      this.height,
      this.borderRadius,
      this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 30.h,
        width: width ?? 110.w,
        decoration: BoxDecoration(
          color: btnColor ?? Colors.white,
          border: Border.all(color: ColorsConst.appBarColor),
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
        ),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: textColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final Color? iconColor;
  const TextWithIcon(
      {super.key,
      required this.text,
      required this.icon,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
        const SizedBox(width: 2.0),
        Text(
          text,
          style: GoogleFonts.lato(
              fontSize: fontSize ?? 10.sp,
              color: textColor ?? Colors.black,
              fontWeight: fontWeight ?? FontWeight.w400),
        ),
      ],
    );
  }
}
