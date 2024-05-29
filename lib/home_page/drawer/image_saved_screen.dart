import 'package:flutter/material.dart';
import 'package:myapp/home_page/counsellor_page/counsellor_details_screen.dart';
import 'package:myapp/model/counsellor_feed_model.dart';
import 'package:myapp/other/constants.dart';
import '../../utils.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key, required this.name, required this.id});

  final String name;
  final String id;

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onBackPressed(context, widget.id, widget.name);
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          surfaceTintColor: AppColors.whiteColor,
          backgroundColor: const Color(0xffffffff),
          foregroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/page-1/images/back.png',
                color: const Color(0xff1F0A68),
              ),
            ),
          ),
          titleSpacing: -1,
          title: Text(
            'Saved',
            style: SafeGoogleFont("Inter",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xff1F0A68)),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: dummyData.length,
                    itemBuilder: (context, index) {
                      var data = dummyData[index];
                      return Column(
                        children: [
                          counsellorFeedPost(
                              context: context,
                              postDetails: CounsellorPostModel(
                                  name: widget.name,
                                  role: data.role,
                                  postTitle: data.postTitle,
                                  profilePic: data.profilePic,
                                  postPic: data.postPic)),
                          Container(
                            height: 0.5,
                            width: double.infinity,
                            color: Colors.black,
                          )
                        ],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

Widget counsellorFeedPost(
    {required BuildContext context, required CounsellorPostModel postDetails}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 13.0),
    child: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(postDetails.profilePic),
                  radius: 32,
                ),
                const SizedBox(
                  width: 11,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      postDetails.name,
                      style: SafeGoogleFont("Inter",
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      postDetails.role,
                      style: SafeGoogleFont("Inter",
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  height: 26,
                  width: 91,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        side: const BorderSide(width: 0.5),
                        foregroundColor: Colors.black),
                    child: Text(
                      "Follow",
                      style: SafeGoogleFont("Inter",
                          fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
            child: Text(
              postDetails.postTitle,
              style: SafeGoogleFont("Inter", fontSize: 15, color: Colors.black),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                postDetails.postPic,
                width: 429,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
            child: Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: Center(
                    child: Image.asset(
                      "${AppConstants.imagePath}like-ufw.png",
                      height: 18,
                      width: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(21)),
                  child: Center(
                    child: Image.asset(
                      "${AppConstants.imagePath}save-instagram-bold.png",
                      height: 18,
                      width: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(21)),
                  child: Center(
                    child: Image.asset(
                      "${AppConstants.imagePath}group-38-oFX.png",
                      height: 18,
                      width: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

List<CounsellorPostModel> dummyData = [
  CounsellorPostModel(
      name: "Anshika Mehra",
      role: "N/A",
      postTitle: "Councellor",
      profilePic:
          "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
      postPic:
          "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw="),
  CounsellorPostModel(
      name: "Anshika Mehra",
      role: "N/A",
      postTitle: "Cooming Soon",
      profilePic:
          "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
      postPic:
          "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw="),
];

Future<bool> _onBackPressed(
    BuildContext context, String id, String name) async {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => CounsellorDetailsScreen(
                id: id,
              )));
  return true;
}
