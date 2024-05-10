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
    address = json['address'] != null ? Address.fromJson(json['address'])
              : Address(
               buildingNumber: "0",
               area: "area",
               city: "city",
               state: "state",
               pinCode: "pincode");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['profile_pic'] = this.profilePic;
    if (address != null) {
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
    buildingNumber = json['building_number'] ?? "0" ;
    area = json['area'] ?? "area" ;
    city = json['city'] ?? "city";
    state = json['state'] ?? "state";
    pinCode = json['pin_code'] ?? "pincode";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_number'] = buildingNumber ?? "0";
    data['area'] = area ?? "area";
    data['city'] = city ?? "city";
    data['state'] = state ?? "state";
    data['pin_code'] = pinCode ?? "pincode";
    return data;
  }
}
