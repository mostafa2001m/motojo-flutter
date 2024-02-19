// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/screens/garages/widgets/garage_info_screen.dart';

class GaragesItem extends StatelessWidget {
  // final String title;
  // final String imageUrl;
  // final String id;
  final UserModel user;
  const GaragesItem({super.key, required this.user});

  void selectCategory(BuildContext ctx ){
  Get.to(() => GarageInfoScreen(user: user,));
  }

  @override
  Widget build(BuildContext context) {
    //we use it so we can make the image into a button
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () => selectCategory(context),
        splashColor: tPrimaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            //a widget to give the pic a round boreder
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                user.photoUrl.toString(),
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                  //to make a black effect with the color and give the color a round borders
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                child: Text(
                  user.fullName,
                  style:TextStyle(color: Colors.white,fontSize: 30,) ,
                  textAlign: TextAlign.center,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}