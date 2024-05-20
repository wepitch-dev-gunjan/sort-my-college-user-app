class College {
  final String id;
  final String profilePic;
  final String name;
  final List<String> about;
  final String email;
  final Map<String, dynamic> instituteTimings; // Changed type to Map
  final List<dynamic> modeOfStudy;
  final List<dynamic> mediumOfStudy;
  final List<dynamic> followers;
  final String status;
  final List<dynamic> instituteKeyFeatures;
  final String createdAt;
  final String updatedAt;
  final int v;
  final List<dynamic> timings;
  final bool verified;
  final String affiliations;
  final String contactNumber;
  final String directionUrl;
  final String registrantContactNumber;
  final String registrantDesignation;
  final String registrantFullName;
  final String yearEstablishedIn;

  College({
    required this.id,
    required this.profilePic,
    required this.name,
    required this.about,
    required this.email,
    required this.instituteTimings,
    required this.modeOfStudy,
    required this.mediumOfStudy,
    required this.followers,
    required this.status,
    required this.instituteKeyFeatures,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.timings,
    required this.verified,
    required this.affiliations,
    required this.contactNumber,
    required this.directionUrl,
    required this.registrantContactNumber,
    required this.registrantDesignation,
    required this.registrantFullName,
    required this.yearEstablishedIn,
  });

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      id: json['_id'],
      profilePic: json['profile_pic'],
      name: json['name'],
      about: List<String>.from(json['about']),
      email: json['email'],
      instituteTimings: json['institute_timings'] ?? {}, // Set default value
      modeOfStudy: List<dynamic>.from(json['mode_of_study']),
      mediumOfStudy: List<dynamic>.from(json['medium_of_study']),
      followers: List<dynamic>.from(json['followers']),
      status: json['status'],
      instituteKeyFeatures: List<dynamic>.from(json['institute_key_features']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      timings: List<dynamic>.from(json['timings']),
      verified: json['verified'],
      affiliations: json['affilations'],
      contactNumber: json['contact_number'],
      directionUrl: json['direction_url'],
      registrantContactNumber: json['registrant_contact_number'],
      registrantDesignation: json['registrant_designation'],
      registrantFullName: json['registrant_full_name'],
      yearEstablishedIn: json['year_established_in'],
    );
  }
}
