class CourseModel {
  String? image;
  String? sId;
  String? name;
  String? type;
  int? courseFee;
  int? courseDurationInDays;

  CourseModel(
      {this.image,
        this.sId,
        this.name,
        this.type,
        this.courseFee,
        this.courseDurationInDays});

  CourseModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
    courseFee = json['course_fee'];
    courseDurationInDays = json['course_duration_in_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['_id'] = sId;
    data['name'] = name;
    data['type'] = type;
    data['course_fee'] = courseFee;
    data['course_duration_in_days'] = courseDurationInDays;
    return data;
  }
}
