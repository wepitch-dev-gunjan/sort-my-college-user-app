class BannerImageModel {
  String? sId;
  String? url;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BannerImageModel(
      {this.sId, this.url, this.createdAt, this.updatedAt, this.iV});

  BannerImageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    url = json['url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['url'] = url;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
