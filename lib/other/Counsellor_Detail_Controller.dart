import 'package:get/get.dart';
import 'package:myapp/other/api_service.dart';

import '../model/counsellor_detail.dart';

class CounsellorDetailController extends GetxController {
  CounsellorDetailController({required this.id});
  final String id;
  var isLoading = true.obs;
  List<CounsellorDetail> cousnellorlist_detail = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //fetchCounsellor();
    fetchCounsellor_detail();
  }

  /*void fetchCounsellor () async {
    try{
       isLoading(true);
       var counsellor = await ApiService.getCounsellor_1();
       cousnellorlist.assignAll(counsellor);
    }
    finally{
      //isLoading(false);
      isLoading(true);

    }

  }*/

  void fetchCounsellor_detail() async {
    try {
      isLoading(true);
      var counsellor = await ApiService.getCounsellor_Detail(id);
      cousnellorlist_detail = counsellor;
    } finally {
      isLoading(false);
    }
  }
}
