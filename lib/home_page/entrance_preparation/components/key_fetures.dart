import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class KeyFeatures extends StatelessWidget {
  final List keyFeatures;
  const KeyFeatures({super.key, required this.keyFeatures});

  @override
  Widget build(BuildContext context) {
    if (keyFeatures.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key Features",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 90,
            ),
            itemCount: keyFeatures.length,
            itemBuilder: (context, index) {
              return Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  // height: 50,
                  // width: 65,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(21)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 5.0,
                    ),
                    child: Column(
                      children: [
                        Image.network(
                          "${keyFeatures[index]['key_features_icon']}",
                          height: 40,
                          width: 40,
                        ),

                        // SvgPicture.network(
                        //   "${keyFeatures[index]['key_features_icon']}",
                        //   placeholderBuilder: (BuildContext context) =>
                        //       const CircularProgressIndicator(),
                        // ),
                        // const Icon(
                        //   Icons.account_balance_sharp,
                        //   size: 40,
                        // ),
                        // const SizedBox(height: 4.0),

                        Expanded(
                          child: Text(
                            "${keyFeatures[index]['name']}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
