import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../posts/models/comment_model.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(String title,String subTitle, File image) async {
    // Upload image to Firebase Storage
    String imagePath = 'images/${DateTime.now().millisecondsSinceEpoch}.png';
    await FirebaseStorage.instance.ref(imagePath).putFile(image);

    // Get the download URL of the uploaded image
    String imageUrl = await FirebaseStorage.instance.ref(imagePath).getDownloadURL();
String postId = Uuid().v4();
    // Add post data to Firestore
    await postsCollection.add({
      'id': postId,
      'Title': title,
      'Subtitle':subTitle,
      'Image': imageUrl,
      'Timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getPosts() {
    return postsCollection.orderBy('Timestamp', descending: true).snapshots();
  }

  // Future<void> addComment(String postId, Comment comment) async {
  //   await _db.collection('posts/$postId/comments').add({
  //     'userId': comment.userId,
  //     'text': comment.text,
  //     //'timestamp': comment.timestamp,
  //   }
  //   );
  // }

  // Stream<List<Comment>> getComments(String postId) {
  //   return _db.collection('posts/$postId/comments').snapshots().map(
  //     (querySnapshot) {
  //       return querySnapshot.docs.map(
  //         (doc) {
  //           Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //           return Comment(
  //             userId: data['userId'],
  //             text: data['text'],
  //             //timestamp: (data['timestamp'] as Timestamp).toDate(),
  //           );
  //         },
  //       ).toList();
  //     },
  //   );
  // }
  
}
