import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance =>Get.find();
  final _db=FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  createUser(UserModel user)async{
    await _db.collection("Users").add(user.toJson()).
    whenComplete(
      () => Get.snackbar("Success", "Your account has been created.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green)
      ).catchError((error,StackTrace){
        Get.snackbar("Error", "Something went wrong.Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red
        );
        print(error.toString());
      })
      ;
  }

  Future<UserModel> getUserDetails(String email)async{
    final snapshot=await _db.collection("Users").where("Email",isEqualTo: email).get();
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUser()async{
    final snapshot=await _db.collection("Users").get();
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }
  Future<List<UserModel>> getUsersByAccountType() async {
    String accountType='Garage';
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection('Users') // Change this to your actual collection name
          .where('AccountType', isEqualTo: accountType)
          .get();
          

      return querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching users by account type: $e");
      return [];
    }
  }

   Future<void> updateUserRecord(UserModel user )async{
    await _db.collection("Users").doc(user.id).update(user.toJson());
   }

Future<void> deleteUser(String userId,String email) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
    
    if (user != null) {
      await user.delete();
      print('User deleted successfully');
    } else {
      print('No user signed in');
    }
      await _db.collection("Users").doc(userId).delete();
      await deleteProfilePhoto(email);
      Get.snackbar(
        "Success",
        "User account has been deleted.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to delete user account. Try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print(error.toString());
    }
  }
    
   Future<String> uploadProfilePhoto(String email, File photo) async {
    try {
      final Reference storageReference = _storage.ref().child('profile_photos/$email.jpg');
      final UploadTask uploadTask = storageReference.putFile(photo);
      final TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile photo: $e');
      throw e;
    }
  }

  Future<void> deleteProfilePhoto(String email) async {
  try {
    final Reference storageReference = _storage.ref().child('profile_photos/$email.jpg');
    await storageReference.delete();
    print('Profile photo deleted successfully');
  } catch (e) {
    print('Error deleting profile photo: $e');
    throw e;
  }
}
    
}