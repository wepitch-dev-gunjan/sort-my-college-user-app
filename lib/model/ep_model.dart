class EPModel {
  String? sId;
  String? name;
  String? profilePic;
  Address? address;

  EPModel({this.sId, this.name, this.profilePic, this.address});

  EPModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePic = json['profile_pic'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['profile_pic'] = profilePic;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  String? buildingNumber;
  String? area;
  String? city;
  String? state;
  String? pinCode;

  Address(
      {this.buildingNumber, this.area, this.city, this.state, this.pinCode});

  Address.fromJson(Map<String, dynamic> json) {
    buildingNumber = json['building_number'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    pinCode = json['pin_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['building_number'] = buildingNumber;
    data['area'] = area;
    data['city'] = city;
    data['state'] = state;
    data['pin_code'] = pinCode;
    return data;
  }
}
