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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["total_available_slots"] = totalAvailableSlots;
    if (sessions != null) {
      _data["sessions"] = sessions?.map((e) => e.toJson()).toList();
    }
    return _data;
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
  dynamic? sessionSlots;
  String? sessionLink;
  String? createdAt;
  String? updatedAt;
  dynamic? sessionAvailableSlots;
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
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["session_counselor"] = sessionCounselor;
    _data["session_user"] = sessionUser;
    _data["session_date"] = sessionDate;
    _data["session_time"] = sessionTime;
    _data["session_duration"] = sessionDuration;
    _data["session_type"] = sessionType;
    _data["session_fee"] = sessionPrice;
    _data["session_status"] = sessionStatus;
    _data["session_slots"] = sessionSlots;
    _data["session_link"] = sessionLink;
    _data["createdAt"] = createdAt;
    _data["updatedAt"] = updatedAt;
    _data["session_available_slots"] = sessionAvailableSlots;
    _data["__v"] = v;
    _data["session_massaged_date"] = sessionMassagedDate;
    return _data;
  }
}
