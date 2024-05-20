class CheckOutDetails {
  String? sessionId;
  String? sessionDate;
  String? sessionType;
  int? sessionFee;
  int? gstAmount;
  int? feeWithGST;
  num? gatewayCharge;
  dynamic? totalAmount;
  String? counsellorId;
  String? counsellorName;
  String? counsellorProfilePic;

  CheckOutDetails(
      {this.sessionId,
        this.sessionDate,
        this.sessionType,
        this.sessionFee,
        this.gstAmount,
        this.feeWithGST,
        this.gatewayCharge,
        this.totalAmount,
        this.counsellorId,
        this.counsellorName,
        this.counsellorProfilePic});

  CheckOutDetails.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    sessionDate = json['sessionDate'];
    sessionType = json['sessionType'];
    sessionFee = json['sessionFee'];
    gstAmount = json['gstAmount'];
    feeWithGST = json['feeWithGST'];
    gatewayCharge = json['gatewayCharge'];
    totalAmount = json['totalAmount'];
    counsellorId = json['counsellor_id'];
    counsellorName = json['counsellor_name'];
    counsellorProfilePic = json['counsellor_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['sessionDate'] = this.sessionDate;
    data['sessionType'] = this.sessionType;
    data['sessionFee'] = this.sessionFee;
    data['gstAmount'] = this.gstAmount;
    data['feeWithGST'] = this.feeWithGST;
    data['gatewayCharge'] = this.gatewayCharge;
    data['totalAmount'] = this.totalAmount;
    data['counsellor_id'] = this.counsellorId;
    data['counsellor_name'] = this.counsellorName;
    data['counsellor_profile_pic'] = this.counsellorProfilePic;
    return data;
  }
}
