import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/colors_const.dart';

class EpAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  const EpAppBar({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: ColorsConst.whiteColor,
      surfaceTintColor: ColorsConst.whiteColor,
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xff1f0a68),
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          height: 0,
        ),
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 10),
      //     child: Icon(
      //       icon,
      //       color: ColorsConst.appBarColor,
      //     ),
      //   ),
      // ],
      titleSpacing: -10,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: ColorsConst.appBarColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class Btn extends StatelessWidget {
  final Function() onTap;
  final String btnName;
  final Color? btnColor;
  final Color? textColor;
  final Widget? child;
  final double? height, width, borderRadius;
  const Btn(
      {super.key,
      required this.onTap,
      required this.btnName,
      this.btnColor,
      this.textColor,
      this.child,
      this.height,
      this.borderRadius,
      this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 30.h,
        width: width ?? 120.w,
        decoration: BoxDecoration(
          color: btnColor ?? Colors.white,
          border: Border.all(
              color: Colors.black.withOpacity(0.7400000095367432), width: 0.50),
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
        ),
        child: child ??
            Center(
              child: Text(
                btnName,
                style: TextStyle(
                  color: textColor ?? const Color(0xFF262626),
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  height: 0.07,
                ),
              ),
            ),
      ),
    );
  }
}

class FollowerBtn extends StatelessWidget {
  final Function() onTap;

  final Color? btnColor;

  final Widget? child;
  final double? height, width, borderRadius;
  const FollowerBtn(
      {super.key,
      required this.onTap,
      this.btnColor,
      this.child,
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
          child: child),
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
          size: 18.sp,
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
