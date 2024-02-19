import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/repository/authentication_repository/authentication_repository.dart';
import 'package:motojo/src/features/authentication/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController{
  static SignUpController get Instance =>Get.find();

  //textfield controllers to get data from textfields
  final email =TextEditingController();
  final password =TextEditingController();
  final fullName =TextEditingController();
  final phoneNo =TextEditingController();
  final userRepo=Get.put(UserRepository());
  //call this fun from design and it will do the rest
  void registerUser(String email,String password)
  {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
    
  }

 Future<void> createUser(UserModel user,)async{
  await userRepo.createUser(user);
  }
  void phoneAuthentication(String phoneNo){
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }

  Future<void> signOut() async {
  try {
    await AuthenticationRepository.instance.logout();
    // Navigate to the login or home screen after successful logout
    // For example:
    // Navigator.pushReplacementNamed(context, '/login');
  } catch (e) {
    print("Error during sign out: $e");
  }
}

Future<void> signIn(String email,String password) async {
    try {
      await AuthenticationRepository.instance.loginWithEmailAndPassword(
          email, password);
      // Navigate to the home screen or perform other actions after successful login
      // For example:
      // Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error during login: $e");
      // Handle login error, show a message, etc.
    }
  }
  

}