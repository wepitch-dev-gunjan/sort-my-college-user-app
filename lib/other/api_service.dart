import 'dart:convert';
import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/home_page/model/banner_image_model.dart';
import 'package:myapp/home_page/model/popular_workshop_model.dart';
import 'package:myapp/home_page/model/tranding_webinar_model.dart';
import 'package:myapp/model/booking_model.dart';
import 'package:myapp/model/check_out_details_model.dart';
import 'package:myapp/webinar_page/webinar_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/announcements_model.dart';
import '../model/counsellor_data.dart';
import '../model/counsellor_sessions.dart';
import '../model/course_model.dart';
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
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future webinarRegister(String id) async {
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

  static Future webinarJoin(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse(
        '${AppConstants.baseUrl}/admin/webinar/webinar-attended-user/$id');

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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      // log("Latest Sessions data=> $data");
      return List<LatestSessionsModel>.from(
          data.map((x) => LatestSessionsModel.fromJson(x)));
    }
    return [];
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

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      return data;
    }
    return {};
  }

  static Future<List<CheckOutDetails>> fetchCheckOutData(String id) async {
    var url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/sessions/$id/payment/user/checkout");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("auth").toString();
    final response = await http.get(url, headers: {
      "Authorization": token,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return List<CheckOutDetails>.from(
          data.map((x) => CheckOutDetails.fromJson(x)));
    }
    return [];
  }

  static Future<Map<String, dynamic>> followCouncellor(
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

  static Future<Map<String, dynamic>> unfollowCouncellor(
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
      var data = jsonDecode(response.body.toString());
      return data;
    }
    if (response.statusCode == 404) {
      return {"error": "Follower not found"};
    }
    return {};
  }

  static Future<Map<String, dynamic>> feedbackCouncellor(
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

  static Future<Map<String, dynamic>> counsellor_create_order({
    String? name,
    String? email,
    num? price,
    String? description,
    String? number,
  }) async {
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
    log("Body$token");
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

  static Future<Map<String, dynamic>> get_profile() async {
    var data;
    String phoneNumber = "";
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
      "Authorization": token,
    });
    var data;
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

  static Future getEPListData() async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/institute/user");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      "Authorization": token,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
  }

  static Future getCounsellor_Detail(String id) async {
    var url = Uri.parse("${AppConstants.baseUrl}/counsellor/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": token,
    });
    return jsonDecode(response.body);
  }

  Future loginVerify({otp, number}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    number = "91$number";
    final body = {'otp': otp, 'phone_number': number};
    var url = Uri.parse(AppConstants.baseUrl + AppConstants.verifyLogin);
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    console.log("Verfiying Otp123 : ${response.body}");
    return jsonDecode(response.body);
  }

  Future registerVerify({otp, number}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    number = "91$number";
    final body = {'otp': otp, 'phone_number': number};
    var url = Uri.parse(AppConstants.baseUrl + AppConstants.verifyRegister);
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    console.log("Verfiying Otp123 : ${response.body}");
    return jsonDecode(response.body);
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
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
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
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
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
    var url = Uri.parse(
        "https://www.sortmycollegeapp.com/counsellor/65f97eaec5894941bf7c96eb/sessions");
    print(url);

    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Authorization": token},
    );
    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
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
    return jsonDecode(response.body);
  }

  static Future isSessionAboutToStart({required String id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final url = Uri.parse(
        "${AppConstants.baseUrl}/counsellor/session/About-to-start/$id");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };
    final response = await http.get(url, headers: headers);

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

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };
    final response = await http.get(url, headers: headers);

    return jsonDecode(response.body);
  }

  static Future<List<BookingModel>> getUserBookingAll(
      {required bool past, required bool today, required bool upcoming}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final url = today
        ? Uri.parse("${AppConstants.baseUrl}/user/booking")
        : Uri.parse(
            "${AppConstants.baseUrl}/user/booking?past=$past&today=$today&upcoming=$upcoming");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };
    final response = await http.get(url, headers: headers);

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

  static Future getKeyFeatures(String id) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/key-featuresForUser/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });
    return jsonDecode(response.body);
  }

  static Future getFaculties({required String id}) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/facultiesForUsers/$id");
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
      return data;
    }
    if (response.statusCode == 404) {
      return [];
    }
    return [];
  }

  static Future getInstituteDetails({required String id}) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/institute/user/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });

    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    }
    if (response.statusCode == 404) {
      return [];
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
    var data;
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
    var data;
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

  static Future<Map<String, dynamic>> followInstitute(
      String id, Function setIsLoading) async {
    setIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode({"user_id": id});
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url =
        Uri.parse('${AppConstants.baseUrl}/ep/institute/user/$id/follow');

    final response = await http.put(url, headers: headers, body: body);
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

  static Future<Map<String, dynamic>> unfollowInstitute(
      String id, Function setIsLoading) async {
    setIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode({"user_id": id});
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url =
        Uri.parse('${AppConstants.baseUrl}/ep/institute/user/$id/unfollow');
    final response = await http.put(url, headers: headers, body: body);
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

  static Future getInstituteAnnouncements({required String id}) async {
    var url =
        Uri.parse("${AppConstants.baseUrl}/ep/announcements-for-user/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });

    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    }
    return [];
  }

  static Future<Map<String, dynamic>> epEnquiry({
    String? id,
    String? coursesId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode({"enquired_to": id, "courses": coursesId});
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse('${AppConstants.baseUrl}/ep/enquiry');
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else if (response.statusCode == 400) {
      return {"error": "Feedback is already given by the user"};
    } else {
      return {"error": "Something went wrong"};
    }
  }

  static Future<Map<String, dynamic>> epFeedback(
      {String? id, double? ratingVal, String? feedbackMsg}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();

    final body = jsonEncode(
        {"institute_id": id, 'rating': ratingVal, 'comment': feedbackMsg});
    final headers = {
      'Content-Type': 'application/json',
      "Authorization": token,
    };
    final url = Uri.parse('${AppConstants.baseUrl}/ep/feedback');
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

  static Future getEpFeedback({required String id}) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/feedbacks/getall/$id");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      //"Content-Type": "application/json",
      "Authorization": token,
    });

    var data;

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());

      return data;
    }
    return [];
  }

  static Future getEpCourses({String? id}) async {
    var url = Uri.parse("${AppConstants.baseUrl}/ep/coursesForUser/$id");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token").toString();
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": token,
    });
    return jsonDecode(response.body);
  }

  // static Future getAllAccommodation() async {
  //   var url = Uri.parse("${AppConstants.baseUrl}/admin/accommodation");
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString("token").toString();
  //   final response = await http.get(url, headers: {
  //     "Content-Type": "application/json",
  //     "Authorization": token,
  //   });
  //   return jsonDecode(response.body);
  // }
}
