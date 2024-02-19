// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motojo/src/features/authentication/screens/Community/comunitiy_item.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
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
          'Communities',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      child: ListView(
        children: [
          CommunityItem(imageUrl: 'https://i.pinimg.com/originals/94/0f/ed/940fed70d67ba5a41d57a024c9c17204.jpg', title: 'Classic bikes', subTitle: 'a disignated place for classic bikers'),
          CommunityItem(imageUrl: 'https://c8.alamy.com/comp/H48K27/eight-motorcyclists-country-road-motorcycle-group-sports-motorcycles-H48K27.jpg', title: 'Adrenaline seekers', subTitle: 'For outlaw riders'),
          CommunityItem(imageUrl: 'https://img.freepik.com/free-photo/man-standing-beside-motorcycle-with-helmet_23-2148875787.jpg?w=996&t=st=1704343360~exp=1704343960~hmac=f353488b705aa223a107b340ec1cc6948a50f9f9166f034f8c428a6bf99128d6', title: 'MotorCross', subTitle: 'for dirt bikes enthusiasts'),
          CommunityItem(imageUrl: 'https://img.freepik.com/free-photo/full-shot-adult-with-equipment-riding-motorcycle_23-2150781540.jpg?t=st=1704343548~exp=1704347148~hmac=4fd36e4973aac97b69698caf4279a24ff08aeb287a61336ecc0c0c6f4fc42bfd&w=1380', title: 'Midnight Club', subTitle: 'whats your top speed ?'),
           
        ],
      ),
      ),
    );
  }
}