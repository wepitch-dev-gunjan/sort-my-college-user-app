
import 'dart:convert';
EpDetailsModel epDetailsModelFromJson(String str) => EpDetailsModel.fromJson(json.decode(str));
String epDetailsModelToJson(EpDetailsModel data) => json.encode(data.toJson());

class EpDetailsModel {
  Address? address;
  bool? verified;
  String? id;
  String? profilePic;
  String? name;
  List<dynamic>? about;
  String? email;
  List<dynamic>? modeOfStudy;
  List<dynamic>? mediumOfStudy;
  List<dynamic>? followers;
  String? status;
  List<dynamic>? instituteKeyFeatures;
  List<Timing>? timings;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  EpDetailsModel({
    this.address,
    this.verified,
    this.id,
    this.profilePic,
    this.name,
    this.about,
    this.email,
    this.modeOfStudy,
    this.mediumOfStudy,
    this.followers,
    this.status,
    this.instituteKeyFeatures,
    this.timings,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory EpDetailsModel.fromJson(Map<String, dynamic> json) => EpDetailsModel(
    address: Address.fromJson(json["address"]),
    verified: json["verified"],
    id: json["_id"],
    profilePic: json["profile_pic"],
    name: json["name"],
    about: List<dynamic>.from(json["about"].map((x) => x)),
    email: json["email"],
    modeOfStudy: List<dynamic>.from(json["mode_of_study"].map((x) => x)),
    mediumOfStudy: List<dynamic>.from(json["medium_of_study"].map((x) => x)),
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    status: json["status"],
    instituteKeyFeatures: List<dynamic>.from(json["institute_key_features"].map((x) => x)),
    timings: List<Timing>.from(json["timings"].map((x) => Timing.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "address": address?.toJson(),
    "verified": verified,
    "_id": id,
    "profile_pic": profilePic,
    "name": name,
    "about": List<dynamic>.from(about!.map((x) => x)),
    "email": email,
    "mode_of_study": List<dynamic>.from(modeOfStudy!.map((x) => x)),
    "medium_of_study": List<dynamic>.from(mediumOfStudy!.map((x) => x)),
    "followers": List<dynamic>.from(followers!.map((x) => x)),
    "status": status,
    "institute_key_features": List<dynamic>.from(instituteKeyFeatures!.map((x) => x)),
    "timings": List<dynamic>.from(timings!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Address {
  String? buildingNumber;
  String? area;
  String? city;
  String? state;
  String? pinCode;

  Address({
    this.buildingNumber,
    this.area,
    this.city,
    this.state,
    this.pinCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    buildingNumber: json["building_number"],
    area: json["area"],
    city: json["city"],
    state: json["state"],
    pinCode: json["pin_code"],
  );

  Map<String, dynamic> toJson() => {
    "building_number": buildingNumber,
    "area": area,
    "city": city,
    "state": state,
    "pin_code": pinCode,
  };
}

class Timing {
  String? day;
  String? startTime;
  String? endTime;
  bool? isOpen;
  String? id;

  Timing({
    this.day,
    this.startTime,
    this.endTime,
    this.isOpen,
    this.id,
  });

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
    day: json["day"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    isOpen: json["is_open"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "start_time": startTime,
    "end_time": endTime,
    "is_open": isOpen,
    "_id": id,
  };
}
