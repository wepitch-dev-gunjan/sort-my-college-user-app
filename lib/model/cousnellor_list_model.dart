// To parse this JSON data, do
//
//     final counsellorModel = counsellorModelFromJson(jsonString);

import 'dart:convert';

List<CounsellorModel> counsellorModelFromJson(String str) =>
    List<CounsellorModel>.from(
        json.decode(str).map((x) => CounsellorModel.fromJson(x)));

String counsellorModelToJson(List<CounsellorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CounsellorModel {
  PersonalInfo personalInfo;
  List<String> sessions;
  List<String> howWillIHelp;
  List<String> followers;
  List<String> locationsFocused;
  List<String> coursesFocused;
  String id;
  String email;
  List<String> qualifications;
  List<String> specializations;
  List<String> languagesSpoken;
  List<String> clientFocus;
  int workExperience;
  int totalAppointedSessions;
  int rewardPoints;
  String degreeFocused;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<String> clientTestimonials;
  bool following;
  String followersCount;

  CounsellorModel({
    required this.personalInfo,
    required this.sessions,
    required this.howWillIHelp,
    required this.followers,
    required this.locationsFocused,
    required this.coursesFocused,
    required this.id,
    required this.email,
    required this.qualifications,
    required this.specializations,
    required this.languagesSpoken,
    required this.clientFocus,
    required this.workExperience,
    required this.totalAppointedSessions,
    required this.rewardPoints,
    required this.degreeFocused,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.clientTestimonials,
    required this.following,
    required this.followersCount,
  });

  factory CounsellorModel.fromJson(Map<String, dynamic> json) =>
      CounsellorModel(
        personalInfo: PersonalInfo.fromJson(json["personal_info"]),
        sessions: List<String>.from(json["sessions"].map((x) => x)),
        howWillIHelp: List<String>.from(json["how_will_i_help"].map((x) => x)),
        followers: List<String>.from(json["followers"].map((x) => x)),
        locationsFocused:
            List<String>.from(json["locations_focused"].map((x) => x)),
        coursesFocused:
            List<String>.from(json["courses_focused"].map((x) => x)),
        id: json["_id"],
        email: json["email"],
        qualifications: List<String>.from(json["qualifications"].map((x) => x)),
        specializations:
            List<String>.from(json["specializations"].map((x) => x)),
        languagesSpoken:
            List<String>.from(json["languages_spoken"].map((x) => x)),
        clientFocus: List<String>.from(json["client_focus"].map((x) => x)),
        workExperience: json["work_experience"],
        totalAppointedSessions: json["total_appointed_sessions"],
        rewardPoints: json["reward_points"],
        degreeFocused: json["degree_focused"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        following: json["following"],
        followersCount: json["followers"],

        v: json["__v"],
        clientTestimonials:
            List<String>.from(json["client_testimonials"].map((x) => x)),

      );

  Map<String, dynamic> toJson() => {
        "personal_info": personalInfo.toJson(),
        "sessions": List<dynamic>.from(sessions.map((x) => x)),
        "how_will_i_help": List<dynamic>.from(howWillIHelp.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "locations_focused": List<dynamic>.from(locationsFocused.map((x) => x)),
        "courses_focused": List<dynamic>.from(coursesFocused.map((x) => x)),
        "_id": id,
        "email": email,
        "qualifications": List<dynamic>.from(qualifications.map((x) => x)),
        "specializations": List<dynamic>.from(specializations.map((x) => x)),
        "languages_spoken": List<dynamic>.from(languagesSpoken.map((x) => x)),
        "client_focus": List<dynamic>.from(clientFocus.map((x) => x)),
        "work_experience": workExperience,
        "total_appointed_sessions": totalAppointedSessions,
        "reward_points": rewardPoints,
        "degree_focused": degreeFocused,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "following" : following,
        "followers" : followersCount,
        "__v": v,
        "client_testimonials":
            List<dynamic>.from(clientTestimonials.map((x) => x)),

      };
}

class PersonalInfo {
  Location location;
  String name;
  String profilePic;
  String gender;

  PersonalInfo({
    required this.location,
    required this.name,
    required this.profilePic,
    required this.gender,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
        location: Location.fromJson(json["location"]),
        name: json["name"],
        profilePic: json["profile_pic"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "name": name,
        "profile_pic": profilePic,
        "gender": gender,
      };
}

class Location {
  String city;
  String state;
  String country;

  Location({
    required this.city,
    required this.state,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "state": state,
        "country": country,
      };
}
