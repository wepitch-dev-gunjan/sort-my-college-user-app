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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['url'] = this.url;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
