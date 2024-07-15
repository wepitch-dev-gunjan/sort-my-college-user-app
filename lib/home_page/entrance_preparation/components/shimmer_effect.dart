import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../other/constants.dart';
import '../../../shared/colors_const.dart';

class EpShimmerEffect extends StatelessWidget {
  const EpShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    // log("Datain Shimmer=${data}");
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  color: AppColors.whiteColor,
                  surfaceTintColor: ColorsConst.whiteColor,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                children: [
                                  CircleAvatar(radius: 40),
                                ],
                              ),
                              const SizedBox(width: 5.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width / 1.7,
                                      height: 18,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Container(
                                      width: 40.w,
                                      height: 12,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        for (int i = 0; i < 3; i++)
                                          Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            width: 40.w,
                                            height: 15,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 5.0),
                                    Container(
                                      color: Colors.white,
                                      width: width / 2,
                                      height: 10,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Container(
                                      color: Colors.white,
                                      width: width / 2,
                                      height: 10,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Container(
                                      color: Colors.white,
                                      width: width / 2,
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 36,
                                width: 110.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                              ),
                              Container(
                                height: 36,
                                width: 110.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
