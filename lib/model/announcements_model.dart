class AnnouncementsModel {
  String? sId;
  String? update;
  String? institute;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AnnouncementsModel(
      {this.sId,
        this.update,
        this.institute,
        this.createdAt,
        this.updatedAt,
        this.iV});

  AnnouncementsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    update = json['update'];
    institute = json['institute'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['update'] = this.update;
    data['institute'] = this.institute;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
