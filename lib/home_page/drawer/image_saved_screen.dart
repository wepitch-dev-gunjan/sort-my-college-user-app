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
                fontSize: 18, fontWeight: FontWeight.w600,color: Color(0xff1F0A68)),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   color: Colors.grey.withOpacity(0.2),
            //   child: TabBar(
            //       indicatorColor: const Color(0xff1F0A68),
            //       indicatorWeight: 3,
            //       controller: _controller,
            //       onTap: (value) {
            //         if (value == 0) {
            //           Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => CounsellorDetialsPage(
            //                     id: widget.id,
            //                     name: widget.name,
            //                   )));
            //         }
            //       },
            //       // tabs: [
            //       //   Tab(
            //       //     child: Text(
            //       //       "Info",
            //       //       style: SafeGoogleFont("Inter",
            //       //           fontSize: 16, fontWeight: FontWeight.w500),
            //       //     ),
            //       //   ),
            //       //   Tab(
            //       //     child: Text(
            //       //       "Feed",
            //       //       style: SafeGoogleFont("Inter",
            //       //           fontSize: 16, fontWeight: FontWeight.w500),
            //       //     ),
            //       //   ),
            //       // ]
            //   ),
            // ),
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
                name: name,
                designation: "",
                profilepicurl: "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAlAMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAAAQYEBQcDAgj/xABDEAABAwMCAgMNBQUIAwAAAAABAAIDBAURBiESMROR0RQWIjVBUVVhcZShscEVIzJ0gVJTc5LhQlRiZHKCovAlREX/xAAWAQEBAQAAAAAAAAAAAAAAAAAAAwL/xAAVEQEBAAAAAAAAAAAAAAAAAAAAEf/aAAwDAQACEQMRAD8A7iig8tkbnG6CUREBFGUwgBSiICIiCFKIgIi+RnO6D6REQERRzQMopRAREQEKIgIoypQCtLcdT2631LqeQyySN/EIm5DT5skhZV6ukNropJpHN6TGI2E7ud5Fy18jpHue9xc9xJcT5SgvvfrbP3VV/I3tTv1tn7qq/kb2rn6IOg9+ts/d1X8g7VvKGsgr6ds9NIHxu5EeT1HzFciVk0XdmUVW+lqHhkE/IuOzX/1+gQdBRaG7anpbZWGmkhlkcGhxczGN/wBVl2S8Q3iKWSCORgjdwkPA36kGzRF8gHiOTsglSiICIiAigjIQDAQSiIgo+tH1FVeqW3Mkwx7WcLc4Bc5xGT1Bai/WB9m6EumZMyXO4Zw4I57LO12S2+xlpIIgYQQcY3ctHVVtVWlrqyofM5owOI8kGOAByCKVv9PaddcW91Vb3Q0Y5EbGT2eYetBX/V5VLmuaMuBA85GFdH36yWn7m10YmI2MjAAD/uO5XkzWkTiW1Fuyw8w14PwIQU9Sro+1WXUMD5bU9tPUNGSwDhA/1N+oVQq6WajqZKeojLJWHBCDxGy+43OY8Pjc5jxuHNOCCoAxzQnKDq9omfU2uknlOXyQtc4+ckLMWv0/4joPy7PkFsEBERAREQEREBERBz3Xvjxn8Bvzcq4rHr3x4z+A35uVcQZtmovtG509LuGvd4ZH7I3PwC3+tLnwObaKTEcMbR0obtnbIb7MYP6rH0E0G8vJ5iB2Otq1V9c516ri/n0zvmgwEREHtR1U1FUsqKZ5bKw5B+nsVt1LHDdrDBeYG8L2AcfsJwR+jvqqarlYDx6LuLHfhAlwf9uUFNJyoUqEHVdP+I6D8uz5BZ+d1gaf8R0H5dnyCzwMFBKIiAiZRAUc1KICIiDnuvN7438uz5uVe5Kw688eM/Lt+blXSg2mmq1tBeYJZDwxuzG8+o/1wszWtvdS3R1W1v3NTvkcg7G4+qryt9kvdJX0X2Xe+EjHCyV/IjyZPkI86CoJlWm4aMqmO47dMyaI8mvOHdfI/BYcWkru92HQxxjzvkGPhkoNG0Fzg1rSSTgAcyVdLm0WPR7KF5AqKjwXAHyk5d1DbqX3SWu26aZ3ZcpxLUgeA0Dl/pb5/WfgqtebpNdqwzzeC0bRxg5DB/3mgwEzuiIOq6f8R0H5dnyC2C1+n/EdB+XZ8gtggKMopQRhFKICIiCCcDKA5ClEHPtegi9RkggGBuPXgu7VW10HUdxt4rI6CutstW/hD2iMAnfPLfPkWtpjpyWqZT1FonpHSHDDPxAE/wAyCoJsr2yhsD7061C2O6VrOMv4jw8gf2s+VLxQ2G0upmy2t0ndDi1vA87cueT60FQo7rX0QxS1csbf2Qct6jssmTUl4kbwur5AP8LWt+ICtN3t+nLTAJKmiBc78EbXOLnezdatsthjezu2w1FLG8+DJIXEfNBV5JHzSF8z3SPP9p7iT1qOSutzpbHb5Y2tss9S2RgeHwFzhg/qsCOr0/MD0Wn6x/CcHhJOP+SCsIrtcYNOUEMDpbe5087A5lO1zuPfz77eZeFJNYYqyJlZZZaJzjljp8lvxP0QWewtc2yUDXghwp2ZB8mwWeob6uSlAREQEREBERAREQU2/OqWazpH0UbZKgQjgY84B/Hn4ZXtU229XmspTco6emggdxHgdku3GR5fMvu+1FHRX+CrdHUzVcUJfwRloYGAO3ORnynqWTVappYWwOigmmMsPTFrcAsZvz6j1INRWR1sutZ222ZkNR0eeOQZGOEZHIrw1FDdYai3/atVDPmX7vo24xu3Odh6lsG3C2N1HT1re6emq4m4JLejaHbbjnnbzrHuN5tt4po6ueGsYKSZoaGOaMl2/l8ngIPa+FrNa259UcQcLeHi/CD4X1x8FtdXOhFgqe6C3cDo8/tZ2wtferla7gypp6ymlL6aVseWkBwLjjIPm2WqMdoguJhqnXGqghm6EvlkHA13mxscbHqQWnSgkGn6ISZzwHGR/ZycfDC1Wg/w3L+MPqtndr3DaZoqVtPJNI5heGR4AawZ7D1LT0Vyt1kizRR1dQatndLw4t+7aM5+qCW4br5/deN2fcl3n4dsfH9Vl67dD9jAScPSmVvRg8/X8MrD1DcLTXspzJTVEsroemEkJDXxs38p9h2WLA2zQVbJZ3Vta4U3dMfTvBGMZ4cefY+rZBb7OJBaqMTZ6ToWcWfPgLMXhQ1Aq6OGpa0tbKwPAdzGQvdAXyM8S+kQEREBERBB5IBgbqUQUzU80dJqIVFSxronUL2BrsgPOHeDn15A/Vau4yMikp53wClimtrmxsGcAnjwBn2jrXRXNa78QB9qFrTzAPtQcyrYntjhyCySK3MlAOxH3nPqK+Jo2wW+4RZA4KmEYz/heuo4CYCDmd1jIudXUNf4Hd3ROGdsnwh8l6VVS+jrrhGHsbK64FxjfGHZYS7wtxtzHWukYCcLSc4GeSCoa1khjraYv44JBG90dW1+MEZPBjG+dvLtlaevqpXmGqr/AAHT257A4txxuy4Dr2610cta4YcAR61Ba08wD7UHNasGlbTmoBjEls4WcQ5nJ2+K87hTy4iG7HwW6ORzfLjIB+Dl04sa78TQcb7qcBBgaf8AEdB+XZ8gtgiICIiAiIggjIwgGBhSiAiIgjmpREBEUA5QSoaMKUQERQglQG4JOVKICIiAiIgIiIPzBSajv01XBC693ENkeGkiodkLzdqa/i2x1Ivdw43y8BHdDsY4c+dEVGXpBqK/SVFFGb3ccVBAcRUO28Mt2/QLGZqvULmNcb1cNx/eHdqIg+u+rUHpq4e8O7U76tQemrh7w7tREgDVOoCfHVw94d2qXao1AOV6uHvDu1EQR31ag9NXD3h3anfVqD01cPeHdqIkDvq1B6auHvDu1O+rUHpq4e8O7URIHfVqD01cPeHdqd9WoPTVw94d2oiQO+rUHpq4e8O7UOqdQA4F6uHL+8O7URBA1VqDA/8ANV+/+Yd2r676dQEkfbdw2z/7Du1EQQdU6gH/ANu4e8O7UREH/9k=",
              )));
  return true;
}

