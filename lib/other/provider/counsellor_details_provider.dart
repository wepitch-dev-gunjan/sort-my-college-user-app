import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myapp/home_page/model/banner_image_model.dart';
import 'package:myapp/home_page/model/popular_workshop_model.dart';
import 'package:myapp/home_page/model/tranding_webinar_model.dart';
import 'package:myapp/model/announcements_model.dart';
import 'package:myapp/model/check_out_details_model.dart';
import 'package:myapp/model/counsellor_data.dart';
import 'package:myapp/model/counsellor_detail.dart';
import 'package:myapp/model/counsellor_sessions.dart';
import 'package:myapp/model/cousnellor_list_model.dart';
import 'package:myapp/model/key_features_model.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../model/course_model.dart';
import '../api_service.dart';

class CounsellorDetailsProvider extends ChangeNotifier {
  List<CounsellorDetail> cousnellorlist_detail = [];
  List<ClientTestimonials> clientList = [];
  // List<CounsellorModel> counsellorModel = [];
  List<CounsellorData> counsellorData = [];
  List<WebinarModel> webinarList = [];
  List<BannerImageModel> bannerImageList = [];
  List<TrandingWebinarModel> trendingWebinarList = [];
  List<LatestSessionsModel> popularWorkShopList = [];
  List<KeyFeaturesModel> keyFeaturesList = [];
  // List<FacultiesModel> facultiesList = [];
  List<AnnouncementsModel> announcementsList = [];
  List<CheckOutDetails> checkOutDetailsList = [];
  List<CourseModel> courseList = [];
  late Razorpay razorpay;

  CounsellorSessionDetails allDetails = CounsellorSessionDetails();
  CounsellorSessionDetails details = CounsellorSessionDetails();
  bool isLoading = true;
  bool loader = true;

  fetchCounsellor_detail(String id) async {
    var counsellor = await ApiService.getCounsellor_Detail(id);
    return counsellor;
 
  }



  void fetchAnnouncements(String id) async {
    var announcements = await ApiService.getAnnouncements(id);
    isLoading = true;
    if (announcements.isEmpty) {
      isLoading = true;
    } else {
      announcementsList = announcements;
      isLoading = false;
    }
    notifyListeners();
  }

  void fetchKeyFeatures_detail(String id) async {
    var keyFeatures = await ApiService.getKeyFeatures(id);
    isLoading = true;
    if (keyFeatures.isEmpty) {
      isLoading = true;
    } else {
      keyFeaturesList = keyFeatures;
      isLoading = false;
    }
    notifyListeners();
  }



  void fetchBannerImage() async {
    bannerImageList.clear();
    var webinar = await ApiService.getBannerImage();
    isLoading = true;
    if (webinar.isEmpty) {
      isLoading = true;
    } else {
      bannerImageList = webinar;
      isLoading = false;
    }
    notifyListeners();
  }



  void fetchWebinar_Data(String params) async {
    isLoading = true;
    notifyListeners();

    webinarList.clear();
    var webinar = await ApiService.getWebinarData(params);
    if (webinar.isEmpty) {
      isLoading = false;
    } else {
      webinarList = webinar;
      isLoading = false;
    }

    notifyListeners(); // Notify listeners after setting isLoading to false
  }

  void fetchTrendingWebinar() async {
    trendingWebinarList.clear();
    var webinar = await ApiService.getTrendingWebinar();
    isLoading = true;
    if (webinar.isEmpty) {
      isLoading = true;
    } else {
      trendingWebinarList = webinar;
      isLoading = false;
    }
    notifyListeners();
  }

  void fetchPopularWorkShop() async {
    popularWorkShopList.clear();
    var webinar = await ApiService.latestSessions();

    isLoading = true;
    if (webinar.isEmpty) {
      isLoading = true;
    } else {
      popularWorkShopList = webinar;
      isLoading = false;
    }
    notifyListeners();
  }

  void fetchCheckOut_Data(String id) async {
    var a = await ApiService.fetchCheckOutData(id);
    isLoading = true;
    if (a.isEmpty) {
      isLoading = true;
    } else {
      checkOutDetailsList = a;
      isLoading = false;
    }
    notifyListeners();
  }

  void fetchCounsellor_session(
      {required String id, String? date, String? sessionType}) async {
    log("SessionDateApi method$date");
    try {
      isLoading = true;
      if (date != null) {
        var counsellor = await ApiService.getCounsellor_sessions(
            date: date, sessionType: sessionType, id: id);
        details = counsellor;
      } else {
        var counsellor = await ApiService.getCounsellor_sessions(id: id);
        allDetails = counsellor;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  void fetchCounsellor_session_perssonel(
      {required String id, String? date, String? sessionType}) async {
    try {
      isLoading = true;
      if (date != null) {
        var counsellor = await ApiService.getCounsellor_sessions_perssonel(
            date: date, sessionType: sessionType, id: id);
        details = counsellor;
      } else {
        var counsellor =
            await ApiService.getCounsellor_sessions_perssonel(id: id);
        allDetails = counsellor;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  void fetchCounsellor_session_all(
      {required String id, String? date, String? sessionType}) async {
    try {
      isLoading = true;
      if (date != null) {
        var counsellor = await ApiService.getCounsellor_sessions_all(
            date: date, sessionType: sessionType, id: id);
        details = counsellor;
      } else {
        var counsellor = await ApiService.getCounsellor_sessions_all(id: id);
        allDetails = counsellor;
      }
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }

  // List<CounsellorModel> cousnellorlist = [];
  List<CounsellorData> cousnellorlist_data = [];

  // void fetchCounsellor_data () async {
  //   try{
  //     isLoading(true);
  //     var counsellor = await ApiService.getCounsellorData();
  //     cousnellorlist_data.assignAll(counsellor);
  //   }
  //   finally{
  //     isLoading(false);
  //   }
  // }

  void fetchCourses(String id) async {
    var courses = await ApiService.getCourse(id);
    isLoading = true;
    if (courses.isEmpty) {
      isLoading = true;
    } else {
      courseList = courses;
      isLoading = false;
    }
    notifyListeners();
  }

  refresh() {
    return Future.delayed(const Duration(seconds: 1), () {
      ApiService.getCounsellorData().then((value) {
        if (value.isNotEmpty) {
          notifyListeners();
        }
        if (value[0].name == "none") {
          EasyLoading.showToast("404 Page Not Found",
              toastPosition: EasyLoadingToastPosition.bottom);
        }
        notifyListeners();
      });
    });
  }
}
