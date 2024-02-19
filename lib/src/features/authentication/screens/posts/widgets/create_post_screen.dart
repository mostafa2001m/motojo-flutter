// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motojo/src/features/authentication/screens/home/data/posts_firebase_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();

  static void buildShowModalBottomSheet(BuildContext context) {}
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
   FirebaseService firebaseService = FirebaseService();
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  File? selectedImage;
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
          'Create a post',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        
      ),
      body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.white], // Add your desired colors
          stops: [0.0, 0.3],
        ),
      ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: 200,),
              // Add Post Form
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator:(value) {
             if (value == null || value.isEmpty) {
               return 'Please enter a valid title';
             }
             return null;
           },
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Enter Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator:(value) {
             if (value == null || value.isEmpty) {
               return 'This field cant be empty';
             }
             return null;
           },
                  maxLines: null,
                  controller: subTitleController,
                  decoration: InputDecoration(labelText: 'Enter SubTitle'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Set border radius here
                  ),
                ),
                    onPressed: () async {
                       if (_formKey.currentState!.validate()) {
                      // Pick image from gallery
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          selectedImage = File(image.path);
                        });
                  
                        // Add post to Firebase
                        await firebaseService.addPost(titleController.text,subTitleController.text,selectedImage!);
                  
                        // Clear the form
                        titleController.clear();
                        subTitleController.clear();
                        setState(() {
                          selectedImage = null;
                        });
                      }
                       }
                    },
                    child: Text('Select an image'),
                  ),
                ),
              ),
            ]),
        ),
      )
    );
  }
}