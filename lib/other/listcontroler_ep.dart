import 'package:get/get.dart';
import 'package:myapp/other/api_service.dart';
import '../model/counsellor_data.dart';
import '../model/cousnellor_list_model.dart';
import '../model/ep_model.dart';
class ListController_EP extends GetxController
{
  var isLoading = true.obs;

  List<EPModel> epModelList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchEpList_data();

  }

  void fetchEpList_data () async {
    try{
      isLoading(true);
      var ep = await ApiService.getEPListData();
      epModelList.assignAll(ep);
    }
    finally{
      isLoading(false);
    }
  }
}