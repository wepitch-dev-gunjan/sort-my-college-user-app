import 'package:flutter/material.dart';
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
        style: const TextStyle(color: ColorsConst.appBarColor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            icon,
            color: ColorsConst.appBarColor,
          ),
        ),
      ],
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
