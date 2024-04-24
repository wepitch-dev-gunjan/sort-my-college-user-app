class BookingModel {
  String? id;
  BookedEntity? bookedEntity;
  String? bookingType;
  BookingData? bookingData;
  int? v;
  String? createdAt;
  String? updatedAt;

  BookingModel({
    this.id,
    this.bookedEntity,
    this.bookingType,
    this.bookingData,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    bookedEntity = json["booked_entity"] == null
        ? null
        : BookedEntity.fromJson(json["booked_entity"]);
    bookingType = json["booking_type"];
    bookingData = json["booking_data"] == null
        ? null
        : BookingData.fromJson(json["booking_data"]);
    v = json["__v"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if (bookedEntity != null) {
      data["booked_entity"] = bookedEntity?.toJson();
    }
    data["booking_type"] = bookingType;
    if (bookingData != null) {
      data["booking_data"] = bookingData?.toJson();
    }
    data["__v"] = v;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    return data;
  }
}

class BookingData {
  String? id;
  String? sessionCounsellor;
  dynamic sessionUser;
  String? sessionDate;
  String? sessionTime;
  int? sessionDuration;
  String? sessionType;
  int? sessionFee;
  String? sessionStatus;
  int? sessionSlots;
  String? sessionLink;
  String? createdAt;
  String? updatedAt;
  int? sessionAvailableSlots;
  int? v;

  BookingData(
      {this.id,
      this.sessionCounsellor,
      this.sessionUser,
      this.sessionDate,
      this.sessionTime,
      this.sessionDuration,
      this.sessionType,
      this.sessionFee,
      this.sessionStatus,
      this.sessionSlots,
      this.sessionLink,
      this.createdAt,
      this.updatedAt,
      this.sessionAvailableSlots,
      this.v});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    sessionCounsellor = json["session_counsellor"];
    sessionUser = json["session_user"];
    sessionDate = json["session_date"].toString();
    sessionTime = json["session_time"].toString();
    sessionDuration = json["session_duration"];
    sessionType = json["session_type"];
    sessionFee = json["session_fee"];
    sessionStatus = json["session_status"];
    sessionSlots = json["session_slots"];
    sessionLink = json["session_link"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    sessionAvailableSlots = json["session_available_slots"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["session_counsellor"] = sessionCounsellor;
    data["session_user"] = sessionUser;
    data["session_date"] = sessionDate;
    data["session_time"] = sessionTime;
    data["session_duration"] = sessionDuration;
    data["session_type"] = sessionType;
    data["session_fee"] = sessionFee;
    data["session_status"] = sessionStatus;
    data["session_slots"] = sessionSlots;
    data["session_link"] = sessionLink;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["session_available_slots"] = sessionAvailableSlots;
    data["__v"] = v;
    return data;
  }
}

class BookedEntity {
  Location? location;
  String? id;
  String? name;
  String? email;
  String? phoneNo;
  String? profilePic;
  String? gender;
  String? nationality;
  List<String>? qualifications;
  String? dateOfBirth;
  String? nextSessionTime;
  List<String>? languagesSpoken;
  int? experienceInYears;
  int? totalAppointedSessions;
  int? rewardPoints;
  int? averageRating;
  List<dynamic>? sessions;
  List<dynamic>? howWillIHelp;
  List<dynamic>? degreeFocused;
  List<String>? locationsFocused;
  List<String>? coursesFocused;
  String? approachOfCounselling;
  String? designation;
  int? groupSessionPrice;
  int? personalSessionPrice;
  bool? verified;
  String? coverImage;
  List<ClientTestimonials>? clientTestimonials;
  String? createdAt;
  String? updatedAt;
  int? v;

  BookedEntity(
      {this.location,
      this.id,
      this.name,
      this.email,
      this.phoneNo,
      this.profilePic,
      this.gender,
      this.nationality,
      this.qualifications,
      this.dateOfBirth,
      this.nextSessionTime,
      this.languagesSpoken,
      this.experienceInYears,
      this.totalAppointedSessions,
      this.rewardPoints,
      this.averageRating,
      this.sessions,
      this.howWillIHelp,
      this.degreeFocused,
      this.locationsFocused,
      this.coursesFocused,
      this.approachOfCounselling,
      this.designation,
      this.groupSessionPrice,
      this.personalSessionPrice,
      this.verified,
      this.coverImage,
      this.clientTestimonials,
      this.createdAt,
      this.updatedAt,
      this.v});

  BookedEntity.fromJson(Map<String, dynamic> json) {
    location =
        json["location"] == null ? null : Location.fromJson(json["location"]);
    id = json["_id"];
    name = json["name"];
    email = json["email"];
    phoneNo = json["phone_no"];
    profilePic = json["profile_pic"];
    gender = json["gender"];
    nationality = json["nationality"];
    qualifications = json["qualifications"] == null
        ? null
        : List<String>.from(json["qualifications"]);
    dateOfBirth = json["date_of_birth"];
    nextSessionTime = json["next_session_time"];
    languagesSpoken = json["languages_spoken"] == null
        ? null
        : List<String>.from(json["languages_spoken"]);
    experienceInYears = json["experience_in_years"];
    totalAppointedSessions = json["total_appointed_sessions"];
    rewardPoints = json["reward_points"];
    averageRating = json["average_rating"];
    sessions = json["sessions"] ?? [];
    howWillIHelp = json["how_will_i_help"] ?? [];
    degreeFocused = null;

    locationsFocused = json["locations_focused"] == null
        ? null
        : List<String>.from(json["locations_focused"]);
    coursesFocused = json["courses_focused"] == null
        ? null
        : List<String>.from(json["courses_focused"]);
    approachOfCounselling = json["approach_of_counselling"];
    designation = json["designation"]  ;
    groupSessionPrice = json["group_session_price"];
    personalSessionPrice = json["personal_session_price"];
    verified = json["verified"];
    coverImage = json["cover_image"];
    clientTestimonials = json["client_testimonials"] == null
        ? null
        : (json["client_testimonials"] as List)
            .map((e) => ClientTestimonials.fromJson(e))
            .toList();
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data["location"] = location?.toJson();
    }
    data["_id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone_no"] = phoneNo;
    data["profile_pic"] = profilePic;
    data["gender"] = gender;
    data["nationality"] = nationality;
    if (qualifications != null) {
      data["qualifications"] = qualifications;
    }
    data["date_of_birth"] = dateOfBirth;
    data["next_session_time"] = nextSessionTime;
    if (languagesSpoken != null) {
      data["languages_spoken"] = languagesSpoken;
    }
    data["experience_in_years"] = experienceInYears;
    data["total_appointed_sessions"] = totalAppointedSessions;
    data["reward_points"] = rewardPoints;
    data["average_rating"] = averageRating;
    if (sessions != null) {
      data["sessions"] = sessions;
    }
    if (howWillIHelp != null) {
      data["how_will_i_help"] = howWillIHelp;
    }
    if (degreeFocused != null) {
      data["degree_focused"] = degreeFocused;
    }
    if (locationsFocused != null) {
      data["locations_focused"] = locationsFocused;
    }
    if (coursesFocused != null) {
      data["courses_focused"] = coursesFocused;
    }
    data["approach_of_counselling"] = approachOfCounselling;
    data["designation"] = designation;
    data["group_session_price"] = groupSessionPrice;
    data["personal_session_price"] = personalSessionPrice;
    data["verified"] = verified;
    data["cover_image"] = coverImage;
    if (clientTestimonials != null) {
      data["client_testimonials"] =
          clientTestimonials?.map((e) => e.toJson()).toList();
    }
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    return data;
  }
}

class ClientTestimonials {
  int? rating;
  String? comment;
  String? id;

  ClientTestimonials({this.rating, this.comment, this.id});

  ClientTestimonials.fromJson(Map<String, dynamic> json) {
    rating = json["rating"];
    comment = json["comment"];
    id = json["_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["rating"] = rating;
    data["comment"] = comment;
    data["_id"] = id;
    return data;
  }
}

class Location {
  String? pinCode;
  String? city;
  String? state;
  String? country;

  Location({this.pinCode, this.city, this.state, this.country});

  Location.fromJson(Map<String, dynamic> json) {
    pinCode = json["pin_code"];
    city = json["city"];
    state = json["state"];
    country = json["country"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["pin_code"] = pinCode;
    data["city"] = city;
    data["state"] = state;
    data["country"] = country;
    return data;
  }
}
