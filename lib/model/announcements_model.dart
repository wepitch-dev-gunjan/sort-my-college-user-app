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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['update'] = update;
    data['institute'] = institute;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
