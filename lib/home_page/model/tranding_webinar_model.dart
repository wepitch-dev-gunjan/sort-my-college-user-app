class TrandingWebinarModel {
  String? id;
  String? webinarImage;
  String? webinarTitle;
  String? webinarDate;
  String? registeredDate;
  String? webinarJoinUrl;
  String? webinarBy;
  String? speakerProfile;
  int? webinarStartingInDays;
  bool? registered;

  TrandingWebinarModel(
      {this.id,
        this.webinarImage,
        this.webinarTitle,
        this.webinarDate,
        this.registeredDate,
        this.webinarJoinUrl,
        this.webinarBy,
        this.speakerProfile,
        this.webinarStartingInDays,
        this.registered});

  TrandingWebinarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    webinarImage = json['webinar_image'];
    webinarTitle = json['webinar_title'];
    webinarDate = json['webinar_date'];
    registeredDate = json['registered_date'];
    webinarJoinUrl = json['webinar_join_url'];
    webinarBy = json['webinar_by'];
    speakerProfile = json['speaker_profile'];
    webinarStartingInDays = json['webinar_starting_in_days'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['webinar_image'] = webinarImage;
    data['webinar_title'] = webinarTitle;
    data['webinar_date'] = webinarDate;
    data['registered_date'] = registeredDate;
    data['webinar_join_url'] = webinarJoinUrl;
    data['webinar_by'] = webinarBy;
    data['speaker_profile'] = speakerProfile;
    data['webinar_starting_in_days'] = webinarStartingInDays;
    data['registered'] = registered;
    return data;
  }
}
