import 'package:get/get.dart';
import 'package:myapp/other/api_service.dart';
import '../model/counsellor_data.dart';
import '../model/cousnellor_list_model.dart';
import '../model/ep_model.dart';
class ListController extends GetxController
{
  var isLoading = true.obs;
  List<CounsellorModel> cousnellorlist=[];
  List<CounsellorData> cousnellorlist_data=[];
  List<EPModel> epModelList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //fetchCounsellor();
    fetchCounsellor_data();
    //fetchEpList_data();

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

  void fetchCounsellor_data () async {
    try{
      isLoading(true);
      var counsellor = await ApiService.getCounsellorData();
      cousnellorlist_data.assignAll(counsellor);
    }
    finally{
      isLoading(false);
    }
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