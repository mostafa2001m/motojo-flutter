// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/controllers/signup_controller.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/repository/user_repository/shared_preference_data.dart';
import 'package:motojo/src/features/authentication/repository/user_repository/user_repository.dart';
import 'package:motojo/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:motojo/src/features/core/controllers/profile_controller.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? _imageFile = null;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  void _handleUserData(UserModel userData) async {
  await SharedPreferencesService.saveCurrentUser(userData);
  print('User saved to SharedPreferences');
  // You can add additional logic here if needed
}

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final profileController = Get.put(ProfileController());
    late String photoUrl;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            tEditProfile,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: profileController.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  _handleUserData(userData);
                  emailController = TextEditingController(text: userData.email);
                  fullNameController =
                      TextEditingController(text: userData.fullName);
                  passwordController =
                      TextEditingController(text: userData.password);
                  phoneNoController =
                      TextEditingController(text: userData.phoneNo);
                  photoUrl = userData.photoUrl!;
                  return Column(children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              await UserRepository.instance
                                  .deleteProfilePhoto(userData.email);
                              await _pickImage(ImageSource.gallery);
                              photoUrl = await UserRepository.instance
                                  .uploadProfilePhoto(
                                      controller.email.text.trim(),
                                      _imageFile!);
                            } catch (e) {
                              print('Error updating profile photo: $e');
                              // Handle error, e.g., show an error message to the user
                            }
                          },
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: userData.photoUrl != null
                                  ? Image.network(userData.photoUrl.toString())
                                  : Image.asset(tProfileImage),
                            ),
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
                                color: tPrimaryColor.withOpacity(0.2)),
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: tPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Form(
                        child: Column(
                      children: [
                        TextFormField(
                          controller: fullNameController,
                          //controller: controller.fullName,
                          decoration: InputDecoration(
                            label: Text(tFullName),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your fullname';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: tFormHeight - 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          // controller: controller.email,
                          decoration: InputDecoration(
                            label: Text(tEmail),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter a valid E-Mail';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: tFormHeight - 20,
                        ),
                        TextFormField(
                          controller: phoneNoController,
                          // controller: controller.phoneNo,
                          decoration: InputDecoration(
                            label: Text(tPhoneNo),
                            prefixIcon: Icon(Icons.phone),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter a correct phone Number';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: tFormHeight - 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          //controller: controller.password,
                          decoration: InputDecoration(
                            label: Text(tPassword),
                            prefixIcon: Icon(Icons.password),
                          ),
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter a valid password';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: tSecondaryColor,
                                  side: BorderSide.none,
                                  shape: StadiumBorder()),
                              onPressed: () {
                                ProfileController.instance.deleteUser(userData);
                                Get.to(() => WelcomeScreen());
                              },
                              child: Text(
                                tDelete,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: tPrimaryColor,
                                  side: BorderSide.none,
                                  shape: StadiumBorder()),
                              onPressed: () {
                                final newUser = UserModel(
                                    id: userData.id,
                                    fullName: fullNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phoneNo: phoneNoController.text.trim(),
                                    password: passwordController.text.trim(),
                                    photoUrl: photoUrl);
                                ProfileController.instance
                                    .updateRecord(newUser);
                              },
                              child: Text(
                                tEditProfile,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ],
                    ))
                  ]);
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Center(
                    child: Text('Something went wrong'),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )));
  }
}
