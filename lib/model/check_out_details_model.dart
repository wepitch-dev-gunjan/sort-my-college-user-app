class CheckOutDetails {
  String? sessionId;
  String? sessionDate;
  String? sessionType;
  int? sessionFee;
  int? gstAmount;
  int? feeWithGST;
  num? gatewayCharge;
  dynamic totalAmount;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session_id'] = sessionId;
    data['sessionDate'] = sessionDate;
    data['sessionType'] = sessionType;
    data['sessionFee'] = sessionFee;
    data['gstAmount'] = gstAmount;
    data['feeWithGST'] = feeWithGST;
    data['gatewayCharge'] = gatewayCharge;
    data['totalAmount'] = totalAmount;
    data['counsellor_id'] = counsellorId;
    data['counsellor_name'] = counsellorName;
    data['counsellor_profile_pic'] = counsellorProfilePic;
    return data;
  }
}
