class LatestSessionsModel {
  String? counsellorId;
  String? sessionId;
  String? counsellorProfilePic;
  String? counsellorName;
  String? counsellorDesignation;
  int? sessionTime;
  String? sessionDate;
  String? sessionStartingDate;
  String? sessionTopic;
  int? sessionDuration;
  int? sessionFee;

  LatestSessionsModel(
      {this.counsellorId,
      this.sessionId,
      this.counsellorProfilePic,
      this.counsellorName,
      this.counsellorDesignation,
      this.sessionTime,
      this.sessionDate,
      this.sessionFee,
      this.sessionTopic,
      this.sessionDuration,
      this.sessionStartingDate});

  LatestSessionsModel.fromJson(Map<String, dynamic> json) {
    counsellorId = json['counsellor_id'];
    sessionId = json['session_id'];
    counsellorProfilePic = json['counsellor_profile_pic'];
    counsellorName = json['counsellor_name'];
    counsellorDesignation = json['counsellor_designation'];
    sessionTime = json['session_time'];
    sessionDate = json['session_date'];
    sessionFee = json['session_fee'];
    sessionTopic = json['session_topic'];
    sessionDuration = json['session_duration'];
    sessionStartingDate = json['session_starting_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['counsellor_id'] = counsellorId;
    data['session_id'] = sessionId;
    data['counsellor_profile_pic'] = counsellorProfilePic;
    data['counsellor_name'] = counsellorName;
    data['counsellor_designation'] = counsellorDesignation;
    data['session_time'] = sessionTime;
    data['session_date'] = sessionDate;
    data['session_fee'] = sessionFee;
    data['session_topic'] = sessionTopic;
    data['session_duration'] = sessionDuration;
    data['session_starting_date'] = sessionStartingDate;
    return data;
  }
}
