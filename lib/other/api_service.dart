import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/home_page/model/banner_image_model.dart';
import 'package:myapp/home_page/model/popular_workshop_model.dart';
import 'package:myapp/home_page/model/tranding_webinar_model.dart';
import 'package:myapp/model/booking_model.dart';
import 'package:myapp/model/check_out_details_model.dart';
import 'package:myapp/model/ep_details_model.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/announcements_model.dart';
import '../model/counsellor_data.dart';
import '../model/counsellor_sessions.dart';
import '../model/course_model.dart';
import '../model/ep_model.dart';
import '../model/faculties_model.dart';
import '../model/key_features_model.dart';
import '../model/response_model.dart';
import 'constants.dart';
import 'dart:developer' as console show log;

class ApiService {
  static Future<Map<String, dynamic>> updateBookingSession(
      String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse(
        '${AppConstants.baseUrl}/counsellor/sessions/$sessionId/book');

    final response = await http.put(url, headers: headers);

    if (response.statusCode == 201 || response.statusCode == 200) {
      //print('Counsellor updated successfully');
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      return jsonDecode(response.body.toString());
    }
  }

  static Future<Map<String, dynamic>> bookValidationSession(
      String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse(
        '${AppConstants.baseUrl}/counsellor/sessions/$sessionId/book-validation');
    final response = await http.put(url, headers: headers);

    if (response.statusCode == 201 || response.statusCode == 200) {
      //print('Counsellor updated successfully');
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future<Map<String, dynamic>> updateProfileDetails(
      String name, String dob, String gender, String eduLevel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode({
      "name": name,
      "date_of_birth": dob,
      "gender": gender,
      "education_level": eduLevel
    });
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse('${AppConstants.baseUrl}/user/register');
    final response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    }
    if (response.statusCode == 401) {
      return {"error": "User not authorized"};
    }
    return {};
  }

  static Future webinar_register(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse(
        '${AppConstants.baseUrl}/admin/webinar/webinars-for-user/$id');

    final response = await http.put(url, headers: headers);

    return jsonDecode(response.body);
  }

  static Future<List<BannerImageModel>> getBannerImage() async {
    var url =
        Uri.parse("https://www.sortmycollegeapp.com/admin/home-page-banner");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<BannerImageModel>.from(
          data.map((x) => BannerImageModel.fromJson(x)));
    }
    return [];
  }

  static Future<List<WebinarModel>> getMyWebinarData() async {
    var url = Uri.parse(
        "${AppConstants.baseUrl}/admin/webinar/webinar-for-user/my-webinars");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<WebinarModel>.from(data.map((x) => WebinarModel.fromJson(x)));
    }
    return [];
  }

  static Future<List<WebinarModel>> getWebinarData(String params) async {
    var url = Uri.parse(
        "${AppConstants.baseUrl}/admin/webinar/webinar-for-user/?query=$params");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<WebinarModel>.from(data.map((x) => WebinarModel.fromJson(x)));
    }
    return [];
  }

  static Future<List<TrandingWebinarModel>> getTrendingWebinar() async {
    var url = Uri.parse(
        "${AppConstants.baseUrl}/admin/webinar/webinar-for-user/trending-webinars");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());

      // log("Trending Webinars=>>>>>>>>>$data");
      return List<TrandingWebinarModel>.from(
          data.map((x) => TrandingWebinarModel.fromJson(x)));
    }
    return [];
  }

  static Future<List<LatestSessionsModel>> latestSessions() async {
    var url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/session/sessions/latest-sessions");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("auth").toString();

    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });

    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      // log("Latest Sessions data=> $data");
      return List<LatestSessionsModel>.from(
          data.map((x) => LatestSessionsModel.fromJson(x)));
    }
    return [];
  }

  static Future<Map<String, dynamic>> getWebinarDetails(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final headers = {
      //'Content-Type': 'application/json',
      "Authorization": token,
    };

    final url =
        Uri.parse('${AppConstants.baseUrl}/admin/webinar/webinar-for-user/$id');

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else if (response.statusCode == 400) {
      return {"error": "Create payment successfully"};
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future<Map<String, dynamic>> getWebinarDetailsData(String id) async {
    var url =
        Uri.parse("${AppConstants.baseUrl}/admin/webinar/webinar-for-user/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    var data;
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      // return List<WebinarDetailsModel>.from(
      //     data.map((x) => WebinarDetailsModel.fromJson(x)));
      return data;
    }
    return {};
  }

  // static Future<CheckOutDetails> fetchCheckOutDetails() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token").toString();
  //
  //   var url = Uri.parse(
  //       "${AppConstants.baseUrl}/counsellor/sessions/65fbcbb563ee42338a08b939/payment/user/checkout");
  //   print(url);
  //
  //   var response = await http.get(
  //     url,
  //     headers: {"Content-Type": "application/json",
  //       "Authorization": token},
  //   );
  //   var data;
  //
  //   console.log(response.body.toString());
  //   if (response.statusCode == 200) {
  //     data = jsonDecode(response.body.toString());
  //     console.log(data.toString());
  //     return CheckOutDetails.fromJson(data);
  //   }
  //   if (response.statusCode == 404) {
  //     return CheckOutDetails();
  //   } else {
  //     return CheckOutDetails();
  //   }
  // }

  static Future<List<CheckOutDetails>> fetchCheckOutData(String id) async {
    var url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/sessions/$id/payment/user/checkout");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());

      // log("Checkout Data=> $data");
      return List<CheckOutDetails>.from(
          data.map((x) => CheckOutDetails.fromJson(x)));
    }
    return [];
  }

  static Future<Map<String, dynamic>> Follow_councellor(
      String id, Function setIsLoading) async {
    setIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode({"user_id": id});
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse('${AppConstants.baseUrl}/counsellor/follower/$id');

    final response = await http.post(url, headers: headers, body: body);
    setIsLoading(false);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    }

    if (response.statusCode == 400) {
      return {"error": "Counsellor is already followed by the user"};
    }

    return {};
  }

  static Future<Map<String, dynamic>> Unfollow_councellor(
      String id, Function setIsLoading) async {
    setIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode({"user_id": id});
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse('${AppConstants.baseUrl}/counsellor/follower/$id');

    final response = await http.put(url, headers: headers, body: body);
    setIsLoading(false);

    if (response.statusCode == 200) {
      //print('Counsellor updated successfully');
      var data = jsonDecode(response.body.toString());
      return data;
    }

    if (response.statusCode == 404) {
      return {"error": "Follower not found"};
    }

    return {};
  }

  static Future<Map<String, dynamic>> Feedback_councellor(
      String id, double ratingVal, String feedbackMsg) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode(
        {"counsellor_id": id, "rating": ratingVal, "message": feedbackMsg});
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse('${AppConstants.baseUrl}/counsellor/feedback');
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else if (response.statusCode == 400) {
      return {"error": "Feedback is already given by the user"};
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future<Map<String, dynamic>> counsellor_create_order(
    String name,
    String email,
    num? price,
    String description,
    String number,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final body = jsonEncode({
      "amount": price,
      "email": email,
      "name": name,
      "description": description,
      "phone_no": number
    });
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url =
        Uri.parse('${AppConstants.baseUrl}/admin/payments/create-order');
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else if (response.statusCode == 400) {
      return {"error": ""};
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future<Map<String, dynamic>> counsellor_create_payment(
      String paymentTo,
      String paymentFrom,
      String oderId,
      String paymentId,
      String entity,
      String amount,
      String amountPaid,
      String amountDue,
      String currency,
      String receipt,
      String offerId,
      String status,
      int attempts,
      String createdAt,
      String key,
      String name,
      String email,
      String phoneNo,
      String description,
      String gst,
      String convcharge,
      String sessionType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    print(token);

    final body = jsonEncode({
      "payment_to": paymentTo,
      "payment_from": paymentFrom,
      "order_id": oderId,
      "payment_id": paymentId,
      "entity": entity,
      "amount": int.parse(amount),
      "amount_paid": int.parse(amountPaid),
      "amount_due": int.parse(amountDue),
      "currency": currency,
      /*"email": receipt,*/
      /*"offer_id": offerId,*/
      "status": status,
      /*"attempts": attempts,*/
      "created_at": createdAt,
      /*"key": key,*/
      "name": name,
      "email": email,
      "phone_no": phoneNo,
      "description": description,
      "gst": double.parse(gst),
      "convenience_charges": double.parse(convcharge),
      "session_type": sessionType
    });

    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };

    final url =
        Uri.parse('${AppConstants.baseUrl}/admin/payments/create-payment');

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else if (response.statusCode == 400) {
      return {"error": "Create payment successfully"};
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future<Map<String, dynamic>> save_profile(
      String? name, String? dob, String? gender, String? edulevel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode({
      "name": name,
      "date_of_birth": dob,
      "gender": gender,
      "education_level": edulevel,
    });

    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };

    final url = Uri.parse('${AppConstants.baseUrl}/user/register');

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else if (response.statusCode == 404) {
      return {"error": "Something went wrong"};
    } else if (response.statusCode == 500) {
      return {"error": "Something went wrong"};
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future<Map<String, dynamic>> readCheckOutAPi() async {
    final String response =
        await rootBundle.loadString('assets/page-1/images/sample.json');
    var data = await json.decode(response);
    return data;
  }

  static Future<Map<String, dynamic>> get_profile() async {
    var data;
    String phoneNumber = "";
    String dob = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };

    final url = Uri.parse('${AppConstants.baseUrl}/user/');

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var value = jsonDecode(response.body.toString());

      if (value[0]['name'] == null) {
        prefs.setString('name', "NA");
      } else {
        prefs.setString('name', value[0]['name'].toString());
      }

      if (value[0]['gender'] == null) {
        prefs.setString('gender', "NA");
      } else {
        prefs.setString('gender', value[0]['gender']);
      }

      if (value[0]['date_of_birth'] == null) {
        prefs.setString('date_of_birth', "NA");
      } else {
        prefs.setString('date_of_birth', value[0]['date_of_birth']);
      }

      if (value[0]['profile_pic'] == null) {
        prefs.setString('profile_pic', "");
      } else {
        prefs.setString('profile_pic', value[0]['profile_pic']);
      }

      //prefs.setString('date_of_birth', value['date_of_birth']);

      prefs.setString('_id', value[0]['_id'].toString());
      prefs.setString(
          'education_level', value[0]['education_level'].toString());
      phoneNumber = value[0]["phone_number"].toString().replaceAll("91", "");
      prefs.setString('phone_number', phoneNumber);

      data = {"message": "successfully get data"};

      return data;
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');

      data = {"message": "unsuccessfully not get data"};
      return data;
    }
  }

  static Future<List<CounsellorData>> getCounsellorData(
      {int? limit, int? page}) async {
    var url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/?page=$page&limit=$limit");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    var data;
    //console.log("Counsellor List : ${response.body}");
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<CounsellorData>.from(
          data.map((x) => CounsellorData.fromJson(x)));
    }
    if (response.statusCode == 404) {
      return [
        CounsellorData(
          nextSession: "No session",
          id: "0",
          name: "none",
          profilePic: "",
          averageRating: "0",
          experienceInYears: 2,
          totalSessions: 3,
          rewardPoints: 4,
          reviews: 5,
          designation: "",
        )
      ];
    }
    return [];
  }

  static Future<College> fetchCollegeData(String id) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/institute/user/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });

    if (response.statusCode == 200) {
      return College.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load college data');
    }
  }

  static Future getEPListData() async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/institute/user");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      "Authorization": token,
    });

    if (response.statusCode == 200) {
      log("EpData=>>>> ${response.body}");

      return jsonDecode(response.body);
    }
  }

  static Future<List<CounsellorData>> getCounsellor_() async {
    var url = Uri.parse("${AppConstants.baseUrl}/counsellor/");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": token,
    });
    var data;
    // console.log("Counsellor List : ${response.body}");
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<CounsellorData>.from(
          data.map((x) => CounsellorData.fromJson(x)));
    }
    if (response.statusCode == 404) {
      return [
        CounsellorData(
          nextSession: "",
          id: "0",
          name: "none",
          profilePic: "",
          averageRating: "0",
          experienceInYears: 2,
          totalSessions: 3,
          rewardPoints: 4,
          reviews: 5,
          designation: "",
        )
      ];
    }
    return [];
  }

  static Future getCounsellor_Detail(String id) async {
    var url = Uri.parse("${AppConstants.baseUrl}/counsellor/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": token,
    });
    log("sssssssssssss${response.body}");
    return jsonDecode(response.body);

    // if (response.statusCode == 200) {
    //   var data = json.decode(response.body.toString());

    //   return  data;
    //   // List<CounsellorDetail>.from(
    //   //     data.map((x) => CounsellorDetail.fromJson(x)));
    // }
    // if (response.body.contains("html")) {
    //   return [
    //     CounsellorDetail(
    //         howIWillHelpYou: [],
    //         qualifications: [],
    //         id: id,
    //         name: "none",
    //         email: "",
    //         coverImage: "",
    //         averageRating: 1,
    //         followersCount: 1,
    //         experienceInYears: 1,
    //         totalSessionsAttended: 1,
    //         gender: "",
    //         rewardPoints: 0)
    //   ];
    // } else {
    //   return [];
    // }
  }

  static Future<ResponseModel> call_otp1() async {
    var data;
    var url = Uri.parse(AppConstants.baseUrl + AppConstants.sendotpRequest);
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    data = json.decode(response.body);
    return ResponseModel.fromJson(data);
  }

  static Future<ResponseModel> call_phone_otp_1() async {
    var data;
    var url =
        Uri.parse(AppConstants.baseUrl + AppConstants.sendotpphoneRequest);
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    data = json.decode(response.body);
    return ResponseModel.fromJson(data);
  }

  Future call_otp_2({email}) async {
    //print(email);
    var headers = {
      'Content-Type': 'application/json',
    };
    final body = {'email': email};

    var data;
    var url = Uri.parse(AppConstants.baseUrl + AppConstants.sendotpRequest);
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    // console.log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 500) {
      data = jsonDecode(response.body.toString());
      return data;
    } else if (response.body.contains("html")) {
      return {"error": "something went wrong!"};
    } else {}
  }

  Future call_otp_phone_2({phone}) async {
    //print(phone);
    var headers = {
      'Content-Type': 'application/json',
    };
    final body = {'phone': phone};

    var data;
    var url =
        Uri.parse(AppConstants.baseUrl + AppConstants.sendotpphoneRequest);
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    // console.log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 500) {
      data = jsonDecode(response.body.toString());
      return data;
    } else if (response.body.contains("html")) {
      return {"error": "something went wrong!"};
    } else {}
  }

  Future verify_otp_2({otp, email}) async {
    //print(email);
    var headers = {
      'Content-Type': 'application/json',
    };
    final body = {'otp': otp, 'email': email};

    var data;
    var url = Uri.parse(AppConstants.baseUrl + AppConstants.verifyotpRequest);
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    console.log("Verfiying Otp : ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 401) {
      data = jsonDecode(response.body.toString());
      return data;
    }
    if (response.statusCode == 404) {
      return {"error": "something went wrong!"};
    }
  }

  Future verify_otp_phone_2({otp, number}) async {
    //print(phone);
    var headers = {
      'Content-Type': 'application/json',
    };

    // number = number.replaceAll('91', '');
    // number = number.replaceAll(' ', '');
    number = "91$number";

    final body = {'otp': otp, 'phone_number': number};

    var data;
    var url =
        Uri.parse(AppConstants.baseUrl + AppConstants.verifyotpphoneRequest);
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    console.log("Verfiying Otp : ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 401) {
      data = jsonDecode(response.body.toString());
      return data;
    }
    if (response.statusCode == 404) {
      return {"error": "something went wrong!"};
    }
  }

  Future call_otp(String email) async {
    // var data;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://13.127.234.0:9000/user/auth/sendOTPEmail'));
    request.body = json.encode({"email": "piyush@wepitch.uk"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future phone_otp(String phone) async {
    // var data;
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://13.127.234.0:9000/user/auth/sendOTPPhone'));
    request.body = json.encode({"phone": "piyush@wepitch.uk"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<CounsellorSessionDetails> getCounsellor_sessions(
      {String? date, String? sessionType, required String id}) async {
    var params = "?session_date=$date&session_type=$sessionType";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    var url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/$id/sessions${date != null ? params : ""}");

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    var data;

    // console.log(
    //     "COunsellor data1=>---------${jsonDecode(response.body.toString())}");
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      // console.log(data.toString());
      return CounsellorSessionDetails.fromJson(data);
    }
    if (response.statusCode == 404) {
      return CounsellorSessionDetails(totalAvailableSlots: -1);
    } else if (response.statusCode == 500) {
      return CounsellorSessionDetails(totalAvailableSlots: -1);
    } else {
      return CounsellorSessionDetails();
    }
  }

  static Future<CounsellorSessionDetails> getCounsellor_sessions_perssonel(
      {String? date, String? sessionType, required String id}) async {
    var params = "?session_date=$date&session_type=$sessionType";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    var url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/$id/sessions${date != null ? params : params}");

    print(url);

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    var data;

    // console.log(response.body.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      // console.log(data.toString());
      return CounsellorSessionDetails.fromJson(data);
    }
    if (response.statusCode == 404) {
      return CounsellorSessionDetails(totalAvailableSlots: -1);
    } else if (response.statusCode == 500) {
      return CounsellorSessionDetails(totalAvailableSlots: -1);
    } else {
      return CounsellorSessionDetails();
    }
  }

  static Future<CounsellorSessionDetails> getCounsellor_sessions_all(
      {String? date, String? sessionType, required String id}) async {
    var params = "?session_date=$date&session_type=$sessionType";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    // var url = Uri.parse("${AppConstants.baseUrl}/counsellor/$id/sessions${date != null ? params : ''}");
    var url = Uri.parse(
        "https://www.sortmycollegeapp.com/counsellor/65f97eaec5894941bf7c96eb/sessions");
    print(url);

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    var data;

    // console.log(response.body.toString());
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      // console.log(data.toString());
      return CounsellorSessionDetails.fromJson(data);
    }
    if (response.statusCode == 404) {
      return CounsellorSessionDetails(totalAvailableSlots: -1);
    } else {
      return CounsellorSessionDetails();
    }
  }

  static Future<Map<String, dynamic>> callVerifyOtp(String email) async {
    final body = jsonEncode({"email": email});
    final headers = {
      'Content-Type': 'application/json',
    };

    final url = Uri.parse("${AppConstants.baseUrl}/user/auth/sendOTPEmail");
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // console.log("Generating Otp  : ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 500) {
      var data = jsonDecode(response.body.toString());

      return data;
    }
    if (response.statusCode == 404) {
      return {"error": "Something went wrong!"};
    }
    return {};
  }

  static Future<Map<String, dynamic>> callVerifyOtpByPhone(
      String number) async {
    number = number.replaceAll(RegExp(r'[^\w\s]+'), '');
    // number = number.replaceAll('91', '');
    // number = number.replaceAll(' ', '');
    number = "91$number";

    final body = jsonEncode({"phone_number": number});
    final headers = {
      'Content-Type': 'application/json',
    };

    final url = Uri.parse("${AppConstants.baseUrl}/user/auth/sendOTPPhone");
    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    // console.log("Generating Otp  : ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 500) {
      var data = jsonDecode(response.body.toString());

      return data;
    }
    if (response.statusCode == 404) {
      return {"error": "Something went wrong!"};
    }
    return {};
  }

  static Future<Map<String, dynamic>> sessionBooked(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/sessions/$sessionId/book");
    final headers = {
      "Authorization": token,
    };
    final response = await http.put(
      url,
      headers: headers,
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body.toString());
      return data;
    }
    if (response.statusCode == 404) {
      return {"error": "Something went wrong!"};
    }
    if (response.statusCode == 400) {
      return {
        "error":
            "There are no booking slots available in this session, please book another session"
      };
    }
    return {};
  }

  static Future getUserBookings(
      {required bool past, required bool today, required bool upcoming}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final url = Uri.parse(past == true
        ? "${AppConstants.baseUrl}/user/booking?past=true"
        : today == true
            ? "${AppConstants.baseUrl}/user/booking?today=true"
            : "${AppConstants.baseUrl}/user/booking?upcoming=true");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };
    final response = await http.get(url, headers: headers);
    // log('Response=> ${response.body}');

    return jsonDecode(response.body);
  }

  static Future getUserBooking(
      {required bool past,
      required bool today,
      required bool upcoming,
      required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final baseUrl = "${AppConstants.baseUrl}/user/booking/$id";

    final url = Uri.parse(past == true
        ? "$baseUrl?past=true"
        : today == true
            ? "$baseUrl?today=true"
            : "$baseUrl?upcoming=true");

    // log("Url=>>>>>- $url");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };
    final response = await http.get(url, headers: headers);
    // log('Response=> ${response.body}');

    return jsonDecode(response.body);
  }

  //  static Future getUserBooking(
  //     {required bool past, required bool today, required bool upcoming, required String id}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token").toString();
  //   final url = Uri.parse(past == true
  //       ? "${AppConstants.baseUrl}/user/booking?past=true"
  //       : today == true
  //           ? "${AppConstants.baseUrl}/user/booking?today=true"
  //           : "${AppConstants.baseUrl}/user/booking?upcoming=true");

  //   final headers = {
  //     "Content-Type": "application/json",
  //     "Authorization": token,
  //   };
  //   final response = await http.get(url, headers: headers);
  //   // log('Response=> ${response.body}');

  //   return jsonDecode(response.body);
  // }

  // static Future<List<BookingModel>> getUserBooking(
  //     {required bool past, required bool today, required bool upcoming}) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token").toString();
  //   final url = Uri.parse(past == true
  //       ? "${AppConstants.baseUrl}/user/booking?past=true"
  //       : today == true
  //           ? "${AppConstants.baseUrl}/user/booking?today=true"
  //           : "${AppConstants.baseUrl}/user/booking?upcoming=true");

  //   final headers = {
  //     "Content-Type": "application/json",
  //     "Authorization": token,
  //   };
  //   final response = await http.get(url, headers: headers);
  //   log('Response=> ${response.body}');

  //   if (response.statusCode == 200) {
  //     List data = jsonDecode(response.body.toString());
  //     List<BookingModel> bookingDetails = [];
  //     for (final element in data) {
  //       bookingDetails.add(BookingModel.fromJson(element));
  //     }

  //     return List.from(data.map((e) => BookingModel.fromJson(e)));
  //   } else if (response.statusCode == 404) {
  //     return [BookingModel(v: -1)];
  //   }
  //   return [];
  // }

  static Future<List<BookingModel>> getUserBookingAll(
      {required bool past, required bool today, required bool upcoming}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final url = today
        ? Uri.parse("${AppConstants.baseUrl}/user/booking")
        : Uri.parse(
            "${AppConstants.baseUrl}/user/booking?past=$past&today=$today&upcoming=$upcoming");

    //final url = Uri.parse("${AppConstants.baseUrl}/user/booking");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };
    final response = await http.get(url, headers: headers);

    //console.log("gettingAllBookings : ${response.body}");

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body.toString());
      List<BookingModel> bookingDetails = [];
      //console.log("Yess");
      for (final element in data) {
        bookingDetails.add(BookingModel.fromJson(element));
      }

      return List.from(data.map((e) => BookingModel.fromJson(e)));
    } else if (response.statusCode == 404) {
      return [BookingModel(v: -1)];
    }

    return [];
  }

  static Future<List<KeyFeaturesModel>> getKeyFeatures(String id) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/key-featuresForUser/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    print(token);
    var data;
    //console.log("Counsellor List : ${response.body}");
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<KeyFeaturesModel>.from(
          data.map((x) => KeyFeaturesModel.fromJson(x)));
    }
    if (response.statusCode == 404) {
      return [
        KeyFeaturesModel(
          name: "none",
          keyFeaturesIcon: "",
        ),
      ];
    }
    return [];
  }

  static Future<List<FacultiesModel>> getFaculties(String id) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/facultiesForUsers/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    print(token);
    var data;
    //console.log("Counsellor List : ${response.body}");
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<FacultiesModel>.from(
          data.map((x) => FacultiesModel.fromJson(x)));
    }
    if (response.statusCode == 404) {
      return [
        FacultiesModel(
          name: "none",
          displayPic: "",
        ),
      ];
    }
    return [];
  }

  static Future<List<AnnouncementsModel>> getAnnouncements(String id) async {
    var url =
        Uri.parse("${AppConstants.baseUrl}/ep/announcements-for-user/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    print(token);
    var data;
    //console.log("Counsellor List : ${response.body}");
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<AnnouncementsModel>.from(
          data.map((x) => AnnouncementsModel.fromJson(x)));
    }
    if (response.statusCode == 404) {
      return [
        AnnouncementsModel(update: ""),
      ];
    }
    return [];
  }

  static Future<List<CourseModel>> getCourse(String id) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/coursesForUser/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    print(token);
    var data;
    //console.log("Counsellor List : ${response.body}");
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return List<CourseModel>.from(data.map((x) => CourseModel.fromJson(x)));
    }
    if (response.statusCode == 404) {
      return [
        CourseModel(
          name: "",
          image: "",
          type: "",
        ),
      ];
    }
    return [];
  }
}
