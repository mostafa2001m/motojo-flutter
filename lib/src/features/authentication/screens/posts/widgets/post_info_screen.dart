// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/models/user_model.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/repository/authentication_repository/authentication_repository.dart';
import 'package:motojo/src/features/authentication/repository/user_repository/shared_preference_data.dart';
import 'package:motojo/src/features/authentication/screens/home/data/posts_firebase_service.dart';
import 'package:motojo/src/features/authentication/screens/posts/models/comment_model.dart';
import 'package:motojo/src/features/authentication/screens/posts/models/post_model.dart';
import 'package:motojo/src/features/core/controllers/profile_controller.dart';

class PostInfoScreen extends StatefulWidget {
  final PostModel post;
  const PostInfoScreen({super.key, required this.post});

  @override
  State<PostInfoScreen> createState() => _PostInfoScreenState();
}

class _PostInfoScreenState extends State<PostInfoScreen> {
  Map? currentUser;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    currentUser = await SharedPreferencesService.getCurrentUser();
    
  }

  @override
  Widget build(BuildContext context) {
    PostModel post = widget.post;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController _commentController = TextEditingController();
    FirebaseService firebaseService = FirebaseService();
    //UserModel currentUser= getCurrentUser() as UserModel;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          post.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white], // Add your desired colors
            stops: [0.0, 0.3],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  post.imageUrl != null
                      ? post.imageUrl.toString()
                      : 'assets/logo.png',
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(
                thickness: 0.8,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Center(
                    child: Text(
                  post.subTitle,
                  style: TextStyle(fontSize: 25),
                )),
              ),
            ),
            //commentSection(),
// StreamBuilder<List<Comment>>(
//   stream: getCommentsForPost(widget.post.id.toString()),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else {
//       final comments = snapshot.data ?? [];
//       return ListView.builder(
//         shrinkWrap: true,
//         itemCount: comments.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(comments[index].text),
//           );
//         },
//       );
//     }
//   },
// ),

            FutureBuilder<List<Comment>>(
              future: getCommentsForPostt(widget.post.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final comments = snapshot.data ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8,right: 13,left: 13),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    comments[index].userPic.toString())),
                            title: Text(
                              comments[index].userName.toString().toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(comments[index].text),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8,top: 13,left: 8,right: 8),
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Type your comment',
                  suffixIcon: IconButton(
                    onPressed: () async {
                      try {
                        await addCommentToFirebase(widget.post.id.toString(),
                            'user123', _commentController.text, currentUser);
                        print('Comment added successfully');
                      } catch (e) {
                        print('Error adding comment: $e');
                        // TODO
                      }

                      // Update the local UI state (optional)
                      setState(() {
                        widget.post.comments.add(Comment(
                          userName: currentUser!['fullName'],
                          userPic: currentUser!['photoUrl'],
                          text: _commentController.text,
                        ));
                      });
                      _commentController.clear();

                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // FutureBuilder getCurrentUser(){
  //   final profileController = Get.put(ProfileController());
  //   return FutureBuilder(
  //           future: profileController.getUserData(),
  //           builder: (context, snapshot) {
  //             if (snapshot.connectionState == ConnectionState.done) {
  //               if (snapshot.hasData) {
  //                 UserModel userData = snapshot.data as UserModel;
  //                 return ;
  //               }
  //               }
  //               }
  //               );
  //}

// Stream<List<Comment>> getCommentsForPost(String postId) {
//   return FirebaseFirestore.instance
//       .collection('comments')
//       .where('postId', isEqualTo: postId)
//       .snapshots()
//       .map((querySnapshot) {
//     return querySnapshot.docs.map((doc) {
//       final data = doc.data() as Map<String, dynamic>;
//       return Comment(
//         userId: data['userId'],
//         text: data['comment'],
//         // Add other fields as needed
//       );
//     }).toList();
//   });
// }

  Future<void> addCommentToFirebase(
      String postId, String userId, String comment, Map? user) async {
    try {
      await FirebaseFirestore.instance.collection('comments').add({
        'userName': user!['fullName'],
        'userPhoto': user['photoUrl'] ?? 'assets/images/logo.png',
        'postId': postId,
        'comment': comment,
        'timestamp': FieldValue.serverTimestamp(), // Optional: add a timestamp
      });
      print('Comment added successfully');
    } catch (e) {
      print('Error adding comment: $e');
      // Handle the error as needed
    }
  }

  Future<UserModel> getCurrentUser() async {
    final _authRepo = Get.put(AuthenticationRepository());
    final email = _authRepo.firebaseUser.value?.email;
    //   FirebaseAuth _auth = FirebaseAuth.instance;
    // User? firebaseUser = _auth.currentUser;

    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where("Email", isEqualTo: email)
        .get();
    final userData =
        userSnapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

    Future<List<Comment>> getCommentsForPostt(String postId) async {
      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('comments')
            .where('postId', isEqualTo: postId)
            .orderBy('timestamp',
                descending: true) // Optional: order by timestamp
            .get();

        return querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Comment(
            userName: data['userName'],
            userPic: data['userPhoto'],
            text: data['comment'],
          );
        }).toList();
      } catch (e) {
        print('Error retrieving comments: $e');
        // Handle the error as needed
        return [];
      }
    }

  Widget commentSection() {
    FirebaseService firebaseService = FirebaseService();
    return Column(children: [
      // Display post details

      // Display comments
      FutureBuilder<List<Comment>>(
        future: getCommentsForPostt(widget.post.id.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final comments = snapshot.data ?? [];
            return ListView.builder(
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].text),
                );
              },
            );
          }
        },
      )
    ]);

    //  Expanded(
    //     child: StreamBuilder<List<Comment>>(
    //   stream: firebaseService.getComments(widget.post.id),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }

    //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return Center(child: Text('No comments yet.'));
    //     }

    //     List<Comment> comments = snapshot.data!;
    //     return ListView.builder(
    //       itemCount: comments.length,
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //           title: Text(comments[index].text),
    //           subtitle: Text('Commented by ${comments[index].userId}'),
    //         );
    //       },
    //     );
    //   },
    // ));
  }
}
