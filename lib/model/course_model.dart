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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['course_fee'] = this.courseFee;
    data['course_duration_in_days'] = this.courseDurationInDays;
    return data;
  }
}
