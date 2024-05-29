class CounsellorSessionDetails {
  num? totalAvailableSlots;
  List<Sessions>? sessions;

  CounsellorSessionDetails({this.totalAvailableSlots, this.sessions});

  CounsellorSessionDetails.fromJson(Map<String, dynamic> json) {
    if (json["total_available_slots"] is int) {
      totalAvailableSlots = json["total_available_slots"];
    }
    if (json["sessions"] is List) {
      sessions = json["sessions"] == null
          ? null
          : (json["sessions"] as List)
              .map((e) => Sessions.fromJson(e))
              .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["total_available_slots"] = totalAvailableSlots;
    if (sessions != null) {
      data["sessions"] = sessions?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  String? id;
  String? sessionCounselor;
  dynamic sessionUser;
  String? sessionDate;
  int? sessionTime;
  int? sessionDuration;
  String? sessionType;
  num? sessionPrice;
  String? sessionStatus;
  dynamic sessionSlots;
  String? sessionLink;
  String? createdAt;
  String? updatedAt;
  dynamic sessionAvailableSlots;
  int? v;
  String? sessionMassagedDate;

  Sessions(
      {this.id,
      this.sessionCounselor,
      this.sessionUser,
      this.sessionDate,
      this.sessionTime,
      this.sessionDuration,
      this.sessionType,
      this.sessionPrice,
      this.sessionStatus,
      this.sessionSlots,
      this.sessionLink,
      this.createdAt,
      this.updatedAt,
      this.sessionAvailableSlots,
      this.v,
      this.sessionMassagedDate});

  Sessions.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["session_counselor"] is String) {
      sessionCounselor = json["session_counselor"];
    }
    sessionUser = json["session_user"];
    if (json["session_date"] is String) {
      sessionDate = json["session_date"];
    }
    if (json["session_time"] is int) {
      sessionTime = json["session_time"];
    }
    if (json["session_duration"] is int) {
      sessionDuration = json["session_duration"];
    }
    if (json["session_type"] is String) {
      sessionType = json["session_type"];
    }
    if (json["session_fee"] is int) {
      sessionPrice = json["session_fee"];
    }
    if (json["session_status"] is String) {
      sessionStatus = json["session_status"];
    }
    if (json["session_slots"] is int) {
      sessionSlots = json["session_slots"];
    }
    if (json["session_link"] is String) {
      sessionLink = json["session_link"];
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["session_available_slots"] is int) {
      sessionAvailableSlots = json["session_available_slots"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
    if (json["session_massaged_date"] is String) {
      sessionMassagedDate = json["session_massaged_date"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["session_counselor"] = sessionCounselor;
    data["session_user"] = sessionUser;
    data["session_date"] = sessionDate;
    data["session_time"] = sessionTime;
    data["session_duration"] = sessionDuration;
    data["session_type"] = sessionType;
    data["session_fee"] = sessionPrice;
    data["session_status"] = sessionStatus;
    data["session_slots"] = sessionSlots;
    data["session_link"] = sessionLink;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["session_available_slots"] = sessionAvailableSlots;
    data["__v"] = v;
    data["session_massaged_date"] = sessionMassagedDate;
    return data;
  }
}
