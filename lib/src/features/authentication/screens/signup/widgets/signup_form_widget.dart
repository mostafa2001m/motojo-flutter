// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motojo/repositries/user_repository.dart';
import 'package:motojo/src/features/authentication/screens/home/widgets/home_screen.dart';
import 'package:motojo/src/constants/colors.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/controllers/signup_controller.dart';
import 'package:motojo/src/features/authentication/models/user_model.dart';
import 'package:motojo/src/features/authentication/repository/user_repository/user_repository.dart';
import 'package:motojo/src/features/authentication/screens/forgot_password/forgot_password_OTP/otp_screen.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
   String selectedValue='Personal account';
  List<String> options = ['Personal account', 'Garage', 'Dealership'];
   File? _imageFile=null;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      padding: EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){_pickImage(ImageSource.gallery);},
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey, // Specify the border color
                            width: 2.0, // Specify the border width
                          ),
                        ),
                child: _imageFile != null
                    ? ClipOval(
                      child: Image.file(
                          _imageFile!,
                          fit: BoxFit.fill,
                        ),
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 40,
                        ),
                        
                        Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.grey,
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
              ),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () => _pickImage(ImageSource.gallery),
            //     child: Row(
            //       children: [
            //         SizedBox(width:75),
            //         Icon(Icons.photo), // Add your desired icon
            //         SizedBox(width:8), // Add some spacing between the icon and the text
            //         Text('Choose a profile photo'), // Add your button text
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: tFormHeight - 20,
            ),
            TextFormField(
              controller: controller.fullName,
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
              controller: controller.email,
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
              controller: controller.phoneNo,
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
              controller: controller.password,
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
              height: tFormHeight - 20,
            ),
            DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Select your account type',
                      border: OutlineInputBorder(),
                    ),
                    //value: selectedValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue.toString();
                      });
                    },
                    items:
                        options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء اختيار خيار';
                      }
                      return null;
                    },
                  ),
                   SizedBox(
              height: tFormHeight - 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async {
                  String photoUrl = await UserRepository.instance.uploadProfilePhoto( controller.email.text.trim(), _imageFile!);
                  if (_formKey.currentState!.validate()) {
                    {
                      SignUpController.Instance.registerUser(
                          controller.email.text.trim(),
                          controller.password.text.trim());
                      // SignUpController.Instance.phoneAuthentication(controller.phoneNo.text.trim());
                      // Get.to(()=>OTPScreen());
                      final user = UserModel(
                          fullName: controller.fullName.text.trim(),
                          email: controller.email.text.trim(),
                          phoneNo: controller.phoneNo.text.trim(),
                          password: controller.password.text.trim(),
                          photoUrl: photoUrl,
                          accountType: selectedValue
                          );
                      SignUpController.Instance.createUser(user);
                      
                    }
                  }
                },
                child: Text(tSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
