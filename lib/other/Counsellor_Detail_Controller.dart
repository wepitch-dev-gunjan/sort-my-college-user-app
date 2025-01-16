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
    super.onInit();

    fetchCounsellor_detail();
  }

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
