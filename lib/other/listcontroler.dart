import 'package:get/get.dart';
import 'package:myapp/other/api_service.dart';
import '../model/counsellor_data.dart';
import '../model/cousnellor_list_model.dart';
class ListController extends GetxController
{
  var isLoading = true.obs;
  List<CounsellorModel> cousnellorlist=[];
  List<CounsellorData> cousnellorlist_data=[];
  // List<EPModel> epModelList = [];

  @override
  void onInit() {
    super.onInit();
    fetchCounsellor_data();
  }



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

 
}