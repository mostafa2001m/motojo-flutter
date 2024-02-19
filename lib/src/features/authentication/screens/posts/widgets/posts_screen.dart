// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/features/authentication/screens/home/data/posts_firebase_service.dart';
import 'package:motojo/src/features/authentication/screens/posts/widgets/create_post_bottom.dart';
import 'package:motojo/src/features/authentication/screens/posts/models/post_model.dart';
import 'package:motojo/src/features/authentication/screens/posts/widgets/create_post_screen.dart';
import 'package:motojo/src/features/authentication/screens/posts/widgets/posts_item_widget.dart';
import 'package:motojo/src/features/authentication/screens/profile/profile_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  FirebaseService firebaseService = FirebaseService();
   ScrollController _scrollController = ScrollController();
   // Set a threshold value to determine when to load more posts
  double _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _refresh() async {
    // Fetch the data again (e.g., get posts)
    // Update your data here
    setState(() {
      // Update your data here
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list, load more data
      // Implement your logic to load more posts or take other actions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'MotoJo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            onPressed: () {
              Get.to(() => ProfileScreen());
            },
          ),
        ],
      ),
      
      body:Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.white], // Add your desired colors
          stops: [0.0, 0.3],
        ),
      ),
        child: Stack(
          children: [
            RefreshIndicator(
              color: tPrimaryColor,
              onRefresh: _refresh,
              child: StreamBuilder<QuerySnapshot>
              (
                
              stream: firebaseService.getPosts(),
              builder: (context,snapshot){
                if(snapshot.hasError)
                {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No posts available.'));
                  }    else{
              
                   List<PostModel> posts = snapshot.data!.docs.map((doc) {
                     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                     return PostModel(
                      id: data['id'],
                       title: data['Title'],
                       subTitle: data['Subtitle'],
                       imageUrl: data['Image'],
                       
                     );
                   }).toList();
              
                   return ListView.builder(
                     itemCount: posts.length,
                     itemBuilder: (context, index) {
                        return PostsItem(post: posts[index]);
                     },
                   );
                 }
              
              
              }
              ),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                
                shape: CircleBorder(),
                onPressed: (){
                  CreatePostScreenBottom.buildShowModalBottomSheet(context);
                  //Get.to(() => CreatePostScreen());
                  },
                child: Icon(Icons.add),
                )
              )
          ],
        ),
      ),
    );
  }
}
