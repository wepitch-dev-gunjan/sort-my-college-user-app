class KeyFeaturesModel {
  String? sId;
  String? name;
  String? keyFeaturesIcon;
  String? createdAt;
  String? updatedAt;
  int? iV;

  KeyFeaturesModel({
    this.sId,
    this.name,
    this.keyFeaturesIcon,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  KeyFeaturesModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    keyFeaturesIcon = json['key_features_icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['key_features_icon'] = keyFeaturesIcon;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
