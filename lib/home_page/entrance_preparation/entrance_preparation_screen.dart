import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myapp/home_page/entrance_preparation/entrance_preparation_details_screen.dart';
import 'package:myapp/other/api_service.dart';
import 'package:myapp/other/listcontroler.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';

class EntrancePreparationScreen extends StatefulWidget {
  const EntrancePreparationScreen({super.key});

  @override
  State<EntrancePreparationScreen> createState() =>
      _EntrancePreparationScreenState();
}

class _EntrancePreparationScreenState extends State<EntrancePreparationScreen> {
  int selectedIndex = 0;

  final ListController listController = Get.put(ListController());

  @override
  void initState() {
    super.initState();
    ApiService.getEPListData();
  }

  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 1), () {
      ApiService.getEPListData().then((value) {
        if (value.isNotEmpty) {
          setState(() {});
        }
        if (value[0].name == "none") {
          EasyLoading.showToast("404 Page Not Found",
              toastPosition: EasyLoadingToastPosition.bottom);
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 460;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorsConst.whiteColor,
        surfaceTintColor: ColorsConst.whiteColor,
        title: const Text(
          'Entrance Preparation',
          style: TextStyle(color: ColorsConst.appBarColor),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
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
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => listController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      // sliderhqs (742:104)
                      width: double.infinity,
                      height: 100.35 * fem,
                      margin: const EdgeInsets.only(left: 18.0, top: 5.0),
                      child: Stack(
                        children: [
                          Positioned(
                            // groupRms (742:105)
                            left: 0 * fem,
                            top: 15.3145446777 * fem,
                            child: Align(
                                child: Container(
                              height: 60.5,
                              width: 330.5,
                              decoration: BoxDecoration(
                                color: ColorsConst.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                              ),
                            )),
                          ),
                          Positioned(
                            left: 150 * fem,
                            bottom: 20 * fem,
                            child: Row(
                              children: [
                                TabPageSelectorIndicator(
                                    backgroundColor: selectedIndex == 0
                                        ? ColorsConst.appBarColor
                                        : ColorsConst.grayColor,
                                    borderColor: Colors.transparent,
                                    size: 7),
                                TabPageSelectorIndicator(
                                    backgroundColor: selectedIndex == 1
                                        ? ColorsConst.appBarColor
                                        : ColorsConst.grayColor,
                                    borderColor: Colors.transparent,
                                    size: 7),
                                TabPageSelectorIndicator(
                                    backgroundColor: selectedIndex == 2
                                        ? ColorsConst.appBarColor
                                        : ColorsConst.grayColor,
                                    borderColor: Colors.transparent,
                                    size: 7)
                              ],
                            ),
                          ),
                          Positioned(
                            // whatentranceexaminationsshould (742:113)
                            left: 13.28515625 * fem,
                            top: 27.3145446777 * fem,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 245 * fem,
                                height: 40 * fem,
                                child: CarouselSlider(
                                  items: [
                                    Text(
                                      'What entrance examinations should I prepare for?',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3252271925 * ffem / fem,
                                        color: const Color(0xFF2A2F33),
                                      ),
                                    ),
                                    Text(
                                      "What entrance examinations should I prepare for?",
                                      textAlign: TextAlign.left,
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3252271925 * ffem / fem,
                                        color: const Color(0xFF2A2F33),
                                      ),
                                    ),
                                    Text(
                                      'What entrance examinations should I prepare for?',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.3252271925 * ffem / fem,
                                        color: const Color(0xFF2A2F33),
                                      ),
                                    ),
                                  ],
                                  options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      viewportFraction: 1,
                                      autoPlay: true),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // graduationhataoB (742:114)
                            left: 290.75 * fem,
                            top: 20 * fem,
                            bottom: 6,
                            child: Align(
                              child: SizedBox(
                                width: 100.5 * fem,
                                height: 128.5 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/graduation-hat.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    listController.epModelList.isEmpty
                        ? const Center(
                            child: Text("Something went wrong!"),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            itemCount: listController.epModelList.length,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return Card(
                                color: ColorsConst.whiteColor,
                                surfaceTintColor: ColorsConst.whiteColor,
                                elevation: 3,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 4, right: 4, bottom: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, top: 6),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 80 * fem,
                                                  height: 80 * fem,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            75 * fem),
                                                    child: Image.network(
                                                      listController
                                                          .epModelList[index]
                                                          .profilePic
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        //print("Exception >> ${exception.toString()}");
                                                        return Image.asset(
                                                          'assets/page-1/images/comming_soon.png',
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                7, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(2, 0, 0, 0),
                                                      child: Text(
                                                        listController
                                                            .epModelList[index]
                                                            .name
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 7, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 14,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        '4.5',
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(width: 160),
                                                      Icon(
                                                        Icons.share,
                                                        color: ColorsConst
                                                            .appBarColor,
                                                        size: 19,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: ColorsConst
                                                            .appBarColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Center(
                                                          child: Text(
                                                        'CUET',
                                                        style: TextStyle(
                                                            color: ColorsConst
                                                                .whiteColor,
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Container(
                                                      height: 20,
                                                      width: 34,
                                                      decoration: BoxDecoration(
                                                        color: ColorsConst
                                                            .appBarColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Center(
                                                          child: Text(
                                                        'JEE',
                                                        style: TextStyle(
                                                            color: ColorsConst
                                                                .whiteColor,
                                                            fontSize: 10),
                                                      )),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Container(
                                                      height: 20,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: ColorsConst
                                                            .appBarColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Center(
                                                          child: Text(
                                                        'CLAT',
                                                        style: TextStyle(
                                                            color: ColorsConst
                                                                .whiteColor,
                                                            fontSize: 10),
                                                      )),
                                                    ),
                                                    const SizedBox(width: 4),
                                                    Container(
                                                      height: 20,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: ColorsConst
                                                            .appBarColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: const Center(
                                                          child: Text(
                                                        'CS',
                                                        style: TextStyle(
                                                            color: ColorsConst
                                                                .whiteColor,
                                                            fontSize: 10),
                                                      )),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on_sharp,
                                                        size: 20,
                                                      ),
                                                      Text(
                                                        ' ${"${listController.epModelList[index].address!.buildingNumber} "
                                                            "${listController.epModelList[index].address!.area} "
                                                            "${listController.epModelList[index].address!.state} "
                                                            "${listController.epModelList[index].address!.city} "
                                                            "${listController.epModelList[index].address!.pinCode}"}  ',
                                                        style: const TextStyle(
                                                            fontSize: 9,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 17,
                                                    ),
                                                    Text(
                                                      ' Open until 9:00 PM',
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(size: 15, Icons.work),
                                                    Text(
                                                      ' 10+ Yrs In Business',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          // const SizedBox(width: 32),
                                          InkWell(
                                            onTap: () {
                                              String name = listController
                                                  .epModelList[index].name
                                                  .toString();
                                              String id = listController
                                                  .epModelList[index].sId
                                                  .toString();
                                              String imgUrl = listController
                                                  .epModelList[index].profilePic
                                                  .toString();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EntrancePreparationDetailsScreen(
                                                            name: name,
                                                            id: id,
                                                            imgUrl: imgUrl,
                                                            buildingNumber:
                                                                listController
                                                                    .epModelList[
                                                                        index]
                                                                    .address!
                                                                    .buildingNumber
                                                                    .toString(),
                                                            area: listController
                                                                .epModelList[
                                                                    index]
                                                                .address!
                                                                .area
                                                                .toString(),
                                                            city: listController
                                                                .epModelList[
                                                                    index]
                                                                .address!
                                                                .city
                                                                .toString(),
                                                            state: listController
                                                                .epModelList[
                                                                    index]
                                                                .address!
                                                                .state
                                                                .toString(),
                                                            pinCode:
                                                                listController
                                                                    .epModelList[
                                                                        index]
                                                                    .address!
                                                                    .pinCode
                                                                    .toString(),
                                                          )));
                                            },
                                            child: Container(
                                              height: 36,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorsConst
                                                        .appBarColor),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                'Visit Profile',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                            ),
                                          ),
                                          // const SizedBox(
                                          //   width: 72,
                                          // ),
                                          Container(
                                            height: 36,
                                            width: 110,
                                            decoration: BoxDecoration(
                                                color: ColorsConst.appBarColor,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: ColorsConst
                                                        .appBarColor)),
                                            child: const Center(
                                              child: Text(
                                                'Send Enquiry',
                                                style: TextStyle(
                                                    color:
                                                        ColorsConst.whiteColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
