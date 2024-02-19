// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/features/authentication/screens/posts/models/post_model.dart';
import 'package:motojo/src/features/authentication/screens/posts/widgets/create.dart';
import 'package:motojo/src/features/authentication/screens/posts/widgets/post_info_screen.dart';

class PostsItem extends StatelessWidget {
  final PostModel post;
   
  const PostsItem({super.key, required this.post});
  
  void selectCategory(BuildContext ctx ){
  Get.to(() => ViewPost(post: post,));
  }

  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: tPrimaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            //a widget to give the pic a round boreder
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
              child: Image.network(
                post.imageUrl!=null?post.imageUrl.toString():'assets/logo.png',
                height: 200,
                width:screenWidth ,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth,
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomLeft,
                  //to make a black effect with the color and give the color a round borders
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                child: Column(
                  children: [
                    Text(
                      post.title,
                      style:TextStyle(color: Colors.black,fontSize: 30) ,
                      ),
                      Text(
                      post.subTitle,
                      style:TextStyle(color: Colors.black,fontSize: 20) ,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}