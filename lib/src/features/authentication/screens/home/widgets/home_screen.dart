// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/features/authentication/screens/Community/community_screen.dart';
import 'package:motojo/src/features/authentication/screens/garages/widgets/garages_screen.dart';
import 'package:motojo/src/features/authentication/screens/posts/widgets/posts_screen.dart';
import 'package:motojo/src/features/authentication/screens/profile/profile_screen.dart';

class homeScreen extends StatefulWidget {
  static const String screenRoute = 'home_screen';
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int _currentIndex = 0;
   final List<Widget> _screens = [
    PostsScreen(),
    CommunityScreen(),
    GaragesScreen(),
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_currentIndex],
       bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: tPrimaryColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Home Screen',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group,),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.garage_outlined,),
            label: 'Garages',
          ),
          
        ],
      ),
      
    );
  }
  
}

