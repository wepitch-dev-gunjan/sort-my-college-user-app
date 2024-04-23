
import 'dart:convert';

WebinarDetailsModel webinarDetailsModelFromJson(String str) => WebinarDetailsModel.fromJson(json.decode(str));

String webinarDetailsModelToJson(WebinarDetailsModel data) => json.encode(data.toJson());

class WebinarDetailsModel {
  String? id;
  String? webinarTitle;
  // List<String>? webinarDetails;
  // List<String>? whatWillYouLearn;
  DateTime? webinarDate;
  String? webinarBy;
  String? webinarImage;
  String? webinarJoinUrl;
  String? webinarPassword;
  int? webinarStartingInDay;
  bool? registered;

  WebinarDetailsModel({
    this.id,
    this.webinarTitle,
    // this.webinarDetails,
    // this.whatWillYouLearn,
    this.webinarDate,
    this.webinarBy,
    this.webinarImage,
    this.webinarJoinUrl,
    this.webinarPassword,
    this.webinarStartingInDay,
    this.registered,
  });

  factory WebinarDetailsModel.fromJson(Map<String, dynamic> json) => WebinarDetailsModel(
    id: json["_id"] ?? '',
    webinarTitle: json["webinar_title"] ?? '',
    // webinarDetails: List<String>.from(json["webinar_details"].map((x) => x)),
    // whatWillYouLearn: List<String>.from(json["what_will_you_learn"].map((x) => x)),
    webinarDate: DateTime.parse(json["webinar_date"]),
    webinarBy: json["webinar_by"],
    webinarImage: json["webinar_image"],
    webinarJoinUrl: json["webinar_join_url"],
    webinarPassword: json["webinar_password"],
    webinarStartingInDay: json["webinar_starting_in_day"],
    registered: json["registered"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "webinar_title": webinarTitle,
    // "webinar_details": List<dynamic>.from(webinarDetails!.map((x) => x)),
    // "what_will_you_learn": List<dynamic>.from(whatWillYouLearn!.map((x) => x)),
    "webinar_date": webinarDate?.toIso8601String(),
    "webinar_by": webinarBy,
    "webinar_image": webinarImage,
    "webinar_join_url": webinarJoinUrl,
    "webinar_password": webinarPassword,
    "webinar_starting_in_day": webinarStartingInDay,
    "registered": registered,
  };
}
