
// ignore_for_file: empty_catches, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motojo/src/features/authentication/screens/home/widgets/home_screen.dart';
import 'package:motojo/src/features/authentication/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:motojo/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  //variables
  final _auth=FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId=''.obs;

  @override
  void onReady() {
    firebaseUser=Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser,_setInitialScreen);
  }

  _setInitialScreen(User? user){
    user==null? Get.offAll(()=>onBoardinScreen()) : Get.offAll(()=>homeScreen());
  }

  Future<void> phoneAuthentication(String phoneNo)async{
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential)async{
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken){
        this.verificationId.value=verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId){
      this.verificationId.value=verificationId;
      },
      verificationFailed: (e){
        if (e.code=='invalid-phone-number') 
        {
        Get.snackbar('Error', 'The provided phone number is not valid');  
        }else{
        Get.snackbar('Error', 'Something went wrong. Try again');  

        }
      }, 
    );
  }

  Future<bool>verifyOTP(String otp)async{
    var credentials=await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
    return credentials.user!=null? true:false;
  }
  
  Future<void> createUserWithEmailAndPassword(String email,String password)async
  {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value!=null? Get.offAll(()=>const homeScreen()):Get.to(()=>onBoardinScreen());
    }on FirebaseAuthException catch (e) {
      final ex=SignUpWithEmailAndPasswordFailure.code(e.code);
      print('Firebase Auth Exception-${ex.message}');
      throw ex;
    } catch(_){
      const ex=SignUpWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }

  }
  Future<void> loginWithEmailAndPassword(String email,String password)async
  {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
       Get.snackbar(
        "Success",
        "User logged in successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
      Get.to(() => homeScreen());
    }on FirebaseAuthException catch (e) {
      Get.snackbar(
        "User was not found",
        "Try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.redAccent,
      );
    } catch(_){}
  }
  Future<void> logout() async =>await _auth.signOut();
}