// To parse this JSON data, do
//
//     final counsellorDetail = counsellorDetailFromJson(jsonString);

// To parse this JSON data, do
//
//     final counsellorDetail = counsellorDetailFromJson(jsonString);

import 'dart:convert';

CounsellorDetail counsellorDetailFromJson(String str) =>
    CounsellorDetail.fromJson(json.decode(str));

String counsellorDetailToJson(CounsellorDetail data) =>
    json.encode(data.toJson());

class CounsellorDetail {
  String id;
  String name;
  String email;
  String coverImage;
  int rewardPoints;
  double averageRating;
  int followersCount;
  int experienceInYears;
  int totalSessionsAttended;
  String gender;
  List qualifications;
  List howIWillHelpYou;
  int? followers;
  List? languages;
  int? age;
  Location? location;
  int? personalSessionPrice;
  int? groupSessionPrice;
  int? reviews;
  bool? following;

  List<ClientTestimonials>? clientTestimonials;

  CounsellorDetail({
    required this.howIWillHelpYou,
    required this.qualifications,
    required this.id,
    required this.name,
    required this.email,
    required this.coverImage,
    required this.rewardPoints,
    required this.averageRating,
    required this.followersCount,
    required this.experienceInYears,
    required this.totalSessionsAttended,
    required this.gender,
    this.followers,
    this.languages,
    this.age,
    this.location,
    this.personalSessionPrice,
    this.groupSessionPrice,
    this.reviews,
    this.following,
    this.clientTestimonials,
  });

  factory CounsellorDetail.fromJson(Map<String, dynamic> json) =>
      CounsellorDetail(
          id: json["_id"] ?? 0,
          name: json["name"] ?? "",
          email: json["email"] ?? '',
          coverImage: json["cover_image"] ??
              "https://media.gettyimages.com/id/1334712074/vector/coming-soon-message.jpg?s=612x612&w=0&k=20&c=0GbpL-k_lXkXC4LidDMCFGN_Wo8a107e5JzTwYteXaw=",
          rewardPoints: json["reward_points"] ?? 0,
          averageRating: json['avg_rating'] is int
              ? (json['avg_rating'] as int).toDouble()
              : json['avg_rating'].toDouble(),
          followersCount: json["followers_count"] ?? 0,
          experienceInYears: json["experience_in_years"] ?? 0,
          totalSessionsAttended: json["sessions"] ?? '',
          gender: json["gender"] ?? '',
          qualifications: json["qualifications"] ?? '',
          howIWillHelpYou: json["how_will_i_help"] ?? '',
          followers: json["followers"] ?? 0,
          languages: json["languages_spoken"] ?? '',
          age: json["age"] ?? 0,
          clientTestimonials: List<ClientTestimonials>.from(
              json["client_testimonials"]
                  .map((x) => ClientTestimonials.fromJson(x))),
          reviews: json["reviews"] ?? 0,
          personalSessionPrice: json["personal_session_price"] ?? 0,
          groupSessionPrice: json["group_session_price"] ?? 0,
          following: json['following'],
          location: Location.fromjson(
            json["location"] ?? '',
          ));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "cover_image": coverImage,
        "reward_points": rewardPoints,
        "followers_count": followersCount,
        "experience_in_years": experienceInYears,
        "total_sessions_attended": totalSessionsAttended,
        "average_rating": averageRating,
        "gender": gender,
        "followers": followers,
        "reviews": reviews,
        "following": following,
        "client_testimonials":
            List<dynamic>.from(clientTestimonials!.map((x) => x.toJson())),
      };
}

class Location {
  String? pincode;
  String? city;
  String? state;
  String? country;
  Location({this.pincode, this.city, this.country, this.state});

  factory Location.fromjson(Map<String, dynamic> json) {
    return Location(
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        country: json["country"] ?? '',
        pincode: json["pin_code"] ?? 0);
  }

  List<Location> getLocationList(Location location) {
    List<Location> temp = [];
    temp.add(location);

    return temp;
  }
}

class ClientTestimonials {
  String? sId;
  String? feedbackTo;
  String? feedbackFrom;
  String? profilePic;
  String? userName;
  num? rating;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ClientTestimonials(
      {this.sId,
      this.feedbackTo,
      this.feedbackFrom,
      this.profilePic,
      this.userName,
      this.rating,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ClientTestimonials.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    feedbackTo = json['feedback_to'];
    feedbackFrom = json['feedback_from'];
    profilePic = json['profile_pic'];
    userName = json['user_name'];
    rating = json['rating'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['feedback_to'] = this.feedbackTo;
    data['feedback_from'] = this.feedbackFrom;
    data['profile_pic'] = this.profilePic;
    data['user_name'] = this.userName;
    data['rating'] = this.rating;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
