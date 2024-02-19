// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motojo/core/components/TextField.dart';
import 'package:motojo/src/features/authentication/screens/home/widgets/home_screen.dart';

class signupScreen extends StatefulWidget {
  static const String screenRoute = 'signup_screen';
  const signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
   final _auth=FirebaseAuth.instance;
  late String email;
  late String password;
  late String number;
  late String username;
  bool showSpinner=false;
  bool isTheSame=false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              createTextField('Username',TextInputType.name),
               SizedBox(height: 20),
               createTextField( 'Email',TextInputType.emailAddress),
           
              SizedBox(height: 20,),
              createTextField( 'Phone Number',TextInputType.phone),
            
            SizedBox(height: 20,),

              createTextFieldForPassword('Password',false),
            
            SizedBox(height: 20,),
            createTextFieldForPassword('Confirm Password',true),
              
            SizedBox(height: 20,),
            Container(
              width: 200,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                ),
                 onPressed: () async{
                      setState(() {
                        showSpinner=true;
                      });
                      try {
                        WidgetsFlutterBinding.ensureInitialized();
                        Firebase.initializeApp();
                        final newUser=await _auth.createUserWithEmailAndPassword(
                          email: email,
                           password: password,
                           );
                           Navigator.pushNamed(context, '/home');
                           setState(() {
                             showSpinner=false;
                           });
                      } catch (e) {
                        print(e);
                      }
                     
      
                  } , 
                child: Text('Sign Up')),
            )
            ],
        
          ),
        ),
        ),
      ),
    );
  }

  TextField createTextFieldForPassword(String hint,bool isConfirmation) {
    return TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
               isConfirmation?{ if(value==password)
                  {
                    isTheSame=true,
                    password = value,
                  }}: password=value;
              },
              decoration: InputDecoration(
                hintText: hint,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            );
  }

  TextField createTextField(String hint,TextInputType exm) {
    return TextField(
              keyboardType: exm,
              textAlign: TextAlign.center,
              onChanged: (value) {
                switch (hint) {
                  case 'Username':
                    username=value;
                    break;
                  case 'Email': 
                  email=value;

                   break;
                  case 'Phone Number': 
                  number=value;

                   break; 
                  default:
                }
              },
              decoration: InputDecoration(
                hintText: hint,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            );
  }
  
}

