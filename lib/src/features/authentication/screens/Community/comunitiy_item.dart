// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:motojo/src/constants/colors.dart';

class CommunityItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subTitle;
  const CommunityItem({super.key, required this.imageUrl, required this.title, required this.subTitle});

  @override
  State<CommunityItem> createState() => _CommunityItemState();
}

class _CommunityItemState extends State<CommunityItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => {},
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
                widget.imageUrl,
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
                //alignment: Alignment.bottomLeft,
                  //to make a black effect with the color and give the color a round borders
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style:TextStyle(color: Colors.black,fontSize: 30) ,
                      ),
                      Text(
                      widget.subTitle,
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