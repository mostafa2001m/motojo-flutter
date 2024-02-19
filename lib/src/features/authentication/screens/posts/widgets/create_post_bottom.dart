// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/screens/home/data/posts_firebase_service.dart';

class CreatePostScreenBottom {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    FirebaseService firebaseService = FirebaseService();
    TextEditingController titleController = TextEditingController();
    TextEditingController subTitleController = TextEditingController();
    File? selectedImage;
    return showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (context) => Container(
              padding: EdgeInsets.all(tDefaultSize),
              child: Form(
                key: _formKey,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 200,),
                      // Add Post Form
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cant be empty';
                            }
                            return null;
                          },
                          maxLines: null,
                          controller: subTitleController,
                          decoration:
                              InputDecoration(labelText: 'Enter SubTitle'),
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
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set border radius here
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Pick image from gallery
                                XFile? image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (image != null) {
                                  selectedImage = File(image.path);

                                  // setState(() {

                                  // });

                                  // Add post to Firebase
                                  await firebaseService.addPost(
                                      titleController.text,
                                      subTitleController.text,
                                      selectedImage!);

                                  // Clear the form
                                  titleController.clear();
                                  subTitleController.clear();
                                  selectedImage = null;
                                  // setState(() {
                                  Navigator.pop(context);
                                  // });
                                }
                              }
                            },
                            child: Text('Select an image'),
                          ),
                        ),
                      ),
                    ]),
              ),
            ));
  }
}
