
class WebinarModel {
  String? webinarImage;
  String? webinarTitle;
  String? webinarDate;
  String? resisterDate;
  String? webinarBy;
  String? speakerProfile;
  int? webnar_startdays;
  bool registered = false;
  bool? canJoin;
  
  String? id;
  String? joinUrl;

  WebinarModel(
      {this.webinarImage,
      this.webinarTitle,
      this.webinarDate,
      this.resisterDate,
      this.webinarBy,
      this.speakerProfile,
      this.webnar_startdays,
      required this.registered,
      this.id,
      this.joinUrl,
      this.canJoin
     });

  WebinarModel.fromJson(Map<String, dynamic> json) {
    webinarImage = json['webinar_image'] ?? 'N/A';
    webinarTitle = json['webinar_title'] ?? 'N/A';
    webinarDate = json['webinar_date'] ?? 'N/A';
    resisterDate = json['registered_date'] ?? 'N/A';
    webinarBy = json['webinar_by'] ?? 'N/A';
    speakerProfile = json['speaker_profile'] ?? 'N/A';
    webnar_startdays = json['webinar_starting_in_days'];
    registered = json['registered'];
    canJoin = json['can_join'];
    id = json['id'] ?? 'N/A';
    joinUrl = json['webinar_join_url'] ?? 'N/A';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['webinar_image'] = webinarImage;
    data['webinar_title'] = webinarTitle;
    data['webinar_date'] = webinarDate;
    data['registered_date'] = resisterDate;
    data['webinar_by'] = webinarBy;
    data['speaker_profile'] = speakerProfile;
    data['webinar_starting_in_days'] = webnar_startdays;
    data['registered'] = registered;
    data['can_join']=canJoin;
   
    data['id'] = id;
    data['webinar_join_url'] = joinUrl;
    return data;
  }
}
