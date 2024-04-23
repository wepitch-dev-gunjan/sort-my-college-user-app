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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profile_pic'] = this.profilePic;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_number'] = this.buildingNumber;
    data['area'] = this.area;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pin_code'] = this.pinCode;
    return data;
  }
}
