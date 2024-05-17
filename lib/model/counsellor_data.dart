// To parse this JSON data, do
//
//     final counsellorData = counsellorDataFromJson(jsonString);

import 'dart:convert';

List<CounsellorData> counsellorDataFromJson(String str) =>
    List<CounsellorData>.from(
        json.decode(str).map((x) => CounsellorData.fromJson(x)));

String counsellorDataToJson(List<CounsellorData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CounsellorData {
  String id;
  String name;
  String profilePic;
  int averageRating;
  int experienceInYears;
  int totalSessions;
  int rewardPoints;
  int reviews;
  String designation;
  List? coursesFocused;

  CounsellorData(
      {required this.id,
      required this.name,
      required this.profilePic,
      required this.averageRating,
      required this.experienceInYears,
      required this.totalSessions,
      required this.rewardPoints,
      required this.reviews,
      required this.designation,
      this.coursesFocused});

  factory CounsellorData.fromJson(Map<String, dynamic> json) => CounsellorData(
        id: json["_id"],
        name: json["name"],
        profilePic: json["profile_pic"],
        averageRating: json["average_rating"],
        experienceInYears: json["experience_in_years"],
        totalSessions: json["total_sessions"],
        rewardPoints: json["reward_points"],
        reviews: json["reviews"],
        designation: json["designation"].toString(),
        coursesFocused: json["courses_focused"] != null
            ? List<String>.from(json["courses_focused"].map((x) => x as String))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profile_pic": profilePic,
        "average_rating": averageRating,
        "experience_in_years": experienceInYears,
        "total_sessions": totalSessions,
        "reward_points": rewardPoints,
        "reviews": reviews,
        "designation": designation,
        "courses_focused": coursesFocused
      };
}
