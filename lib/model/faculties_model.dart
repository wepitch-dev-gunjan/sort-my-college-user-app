class FacultiesModel {
  String? sId;
  String? instituteId;
  String? name;
  String? displayPic;
  int? experienceInYears;
  String? qualifications;
  List<String>? graduatedFrom;

  FacultiesModel(
      {this.sId,
        this.instituteId,
        this.name,
        this.displayPic,
        this.experienceInYears,
        this.qualifications,
        this.graduatedFrom});

  FacultiesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    instituteId = json['institute_id'];
    name = json['name'];
    displayPic = json['display_pic'];
    experienceInYears = json['experience_in_years'];
    qualifications = json['qualifications'];
    graduatedFrom = json['graduated_from'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['institute_id'] = instituteId;
    data['name'] = name;
    data['display_pic'] = displayPic;
    data['experience_in_years'] = experienceInYears;
    data['qualifications'] = qualifications;
    data['graduated_from'] = graduatedFrom;
    return data;
  }
}
