import 'package:get/get_connect/http/src/request/request.dart';
import 'package:motojo/src/features/authentication/screens/posts/models/comment_model.dart';
import 'package:uuid/uuid.dart';

class PostModel {
  final String id;
  final String title;
  final String subTitle;
  final String? imageUrl;
   final List<Comment> comments;

  PostModel({
    required this.subTitle,
    required this.title,
    this.imageUrl,
    required this.id,
    List<Comment>? comments,
  }) :comments = comments ?? [];
  
}