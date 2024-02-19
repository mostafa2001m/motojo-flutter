// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/repository/user_repository/shared_preference_data.dart';
import 'package:motojo/src/features/authentication/screens/posts/models/comment_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GarageInfoScreen extends StatefulWidget {
  final UserModel user;
  const GarageInfoScreen({super.key, required this.user});

  @override
  State<GarageInfoScreen> createState() => _GarageInfoScreenState();
}

class _GarageInfoScreenState extends State<GarageInfoScreen> {
   Map? currentUser;
   double rating=3;

  @override
  void initState() {
    super.initState();
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    currentUser = await SharedPreferencesService.getCurrentUser();
    
  }
  final TextEditingController _commentController = TextEditingController();
  final double latitude = 31.99568095511295;
  final double longitude = 35.85612563835784;
  @override
  Widget build(BuildContext context) {
     final List<Comment> comments=[];
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    UserModel user = widget.user;
    String phoneNumber = user.phoneNo;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          user.fullName,
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
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes the shadow direction
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.blue, // Set your desired color
                            borderRadius: BorderRadius.circular(
                                75.0), // Set the border radius to create a circle
                          ),
                          child: ClipOval(
                              child: Image.network(
                            user.photoUrl.toString(),
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                // launch("tel:$phoneNumber");
                                FlutterPhoneDirectCaller.callNumber(phoneNumber);
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _launchGoogleMaps();
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Icon(
                                  Icons.map,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                      SizedBox(height: 13,),
                      Center(
          child: RatingBar(
            initialRating: 3.5,
            direction: Axis.horizontal,
            itemCount: 5,
            ratingWidget: RatingWidget(
              empty: Icon(Icons.star_border,color: Colors.blue,),
              half: Icon(Icons.star_half,color: Colors.blue,),
              full: Icon(Icons.star,color: Colors.blue,),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (rating) {
              this.rating=rating ;
            },
            itemSize: 32.0,
          ),
        ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: 350,
                  child: FutureBuilder<List<Comment>>(
                                future: getFeedbackForPostt(widget.user.email.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                                  } else {
                  final comments = snapshot.data ?? [];
                  return ListView.builder(
                    padding: EdgeInsets.zero,
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
                            trailing: Column(
                              children: [
                                Text('$rating',style: TextStyle(color: Colors.blue,fontSize:20 ),),
                                Icon(Icons.star,color: Colors.blue,size: 20,)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                                  }
                                },
                              ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8,top: 13,left: 8,right: 8),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: 'Your opinion...',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        try {
                          await addFeedbackToFirebase(widget.user.email.toString(),
                              'user123', _commentController.text, currentUser,rating);
                          print('Comment added successfully');
                        } catch (e) {
                          print('Error adding comment: $e');
                          // TODO
                        }
          
                        // Update the local UI state (optional)
                        setState(() {
                          comments.add(Comment(
                            userName: currentUser!['fullName'],
                            userPic: currentUser!['photoUrl'],
                            starNumber: rating,
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
      ),
    );
  }

  
   Future<void> addFeedbackToFirebase(
      String garageId, String userId, String feedback, Map? user,double rating) async {
    try {
      await FirebaseFirestore.instance.collection('feedback').add({
        'userName': user!['fullName'],
        'userPhoto': user['photoUrl'] ?? 'assets/images/logo.png',
        'postId': garageId,
        'rating':rating,
        'feedback': feedback,
        'timestamp': FieldValue.serverTimestamp(), // Optional: add a timestamp
      });
      print('Comment added successfully');
    } catch (e) {
      print('Error adding comment: $e');
      // Handle the error as needed
    }
  }
  
  Future<List<Comment>> getFeedbackForPostt(String postId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('feedback')
          .where('postId', isEqualTo: postId)
          .orderBy('timestamp',
              descending: true) // Optional: order by timestamp
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Comment(
          userName: data['userName'],
          userPic: data['userPhoto'],
          text: data['feedback'],
          starNumber: data['rating']
        );
      }).toList();
    } catch (e) {
      print('Error retrieving comments: $e');
      // Handle the error as needed
      return [];
    }
  }

  
  void _launchGoogleMaps() async {
    final String googleMapsUrl =
        'https://www.google.com/maps?q=$latitude,$longitude';

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      // Handle the case where Google Maps is not installed
      print('Could not launch Google Maps');
    }
  }

  Widget _buildRoundContainer(Icon icon, Function onPress) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onPress;
        },
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: icon,
        ),
      ),
    );
  }
}
