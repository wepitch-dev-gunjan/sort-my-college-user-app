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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['webinar_image'] = this.webinarImage;
    data['webinar_title'] = this.webinarTitle;
    data['webinar_date'] = this.webinarDate;
    data['registered_date'] = this.registeredDate;
    data['webinar_join_url'] = this.webinarJoinUrl;
    data['webinar_by'] = this.webinarBy;
    data['speaker_profile'] = this.speakerProfile;
    data['webinar_starting_in_days'] = this.webinarStartingInDays;
    data['registered'] = this.registered;
    return data;
  }
}
