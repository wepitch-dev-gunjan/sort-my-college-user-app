class CounsellorPostModel {
  final String profilePic;
  final String postTitle;
  final String postPic;
  final String name;
  final String role;

  CounsellorPostModel(
      {required this.name,
      required this.role,
      required this.postTitle,
      required this.profilePic,
      required this.postPic});
}
