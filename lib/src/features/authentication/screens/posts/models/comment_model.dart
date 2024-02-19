class Comment {
  final String text;
  final String? userName;
  final String? userPic;
  final double? starNumber; // New field for star rating

  Comment({
    required this.userName,
    required this.userPic,
    required this.text,
    this.starNumber, // Make it nullable
  });
}
