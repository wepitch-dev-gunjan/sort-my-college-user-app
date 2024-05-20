class FollowerModel {
  String? message;

  FollowerModel({this.message});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message ?? '',
    };
  }
}

