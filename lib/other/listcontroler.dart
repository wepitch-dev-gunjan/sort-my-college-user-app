import 'package:get/get.dart';
import 'package:myapp/other/api_service.dart';
import '../model/counsellor_data.dart';

class ListController extends GetxController
{
  var isLoading = true.obs;
  List<CounsellorData> cousnellorlist_data=[];


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