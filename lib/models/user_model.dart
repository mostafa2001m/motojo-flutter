
import 'package:flutter/material.dart';
class userModel{
  final String? id;
  final String name;
  final String email;
  final String phoneNo;
  final String password;

  userModel(
    { 
      this.id,
       required this.name,
        required this.email,
         required this.phoneNo,
          required this.password
          }
          ); 
    toJson()
    {
      return{
        "Name":name,
        "Email":email,
        "Phone":phoneNo,
        "Password":password
      };
    }
}
