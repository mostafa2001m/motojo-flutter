// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/controllers/signup_controller.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:motojo/src/features/authentication/screens/profile/widgets/profile_menu.dart';
import 'package:motojo/src/features/core/controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController());
    final controller=Get.put(SignUpController());
    var isDark=MediaQuery.of(context).platformBrightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tProfile,style: Theme.of(context).textTheme.headline4,),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(isDark?Icons.sunny:Icons.nightlight))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child:  Column(
            children: [
              FutureBuilder(
                future: profileController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      Stack(
                      children: [
                        SizedBox(width: 120,height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(image: NetworkImage(userData.photoUrl.toString())),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: tPrimaryColor.withOpacity(0.2)
                                  ),
                                  child: Icon(Icons.edit,size: 30,color: tPrimaryColor,),
                                ),
                        )
                      ],
                                      ),
                      SizedBox(height: 10,),
              Text(userData.fullName,style: Theme.of(context).textTheme.headline4,),
              Text(userData.email,style: Theme.of(context).textTheme.bodyText2,),                
                    ],
                  );
                }else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }else {
                  return Center(
                    child: Text('Something went wrong'),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              
                }
                }
                
              ),
              
              SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tPrimaryColor,side: BorderSide.none,shape: StadiumBorder()
                  ),
                  onPressed: (){Get.to(()=>UpdateProfileScreen());}, 
                  child: Text(tEditProfile,style: TextStyle(color: Colors.white),)),
              ),
              SizedBox(height: 30,),
              Divider(),
              SizedBox(height: 10,),
              ProfileMenuWidget(title: tMenu1,icon: Icons.settings,onPressed: (){},),
              ProfileMenuWidget(title: tMenu3,icon: Icons.person,onPressed: (){},),
              Divider(),
              SizedBox(height: 10,),
              ProfileMenuWidget(title: tMenu2,icon: Icons.info_outline,onPressed: (){},),
              ProfileMenuWidget(title: tMenu4,icon: Icons.logout,onPressed: (){SignUpController.Instance.signOut();},textColor: Colors.red,endIcon: false,),
              

            ],
          ),
        ),
      ),
    );
  }
}

