// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';

class loginFoteerWidget extends StatelessWidget {
  const loginFoteerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('OR'),
        SizedBox(height: tFormHeight-20,),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: (){}, 
            icon: Image(image: AssetImage(tGoogleLogoImage),width: 20.0,), 
            label: Text(tSignInWithGoogle)
            ),
        ),
        SizedBox(height: tFormHeight-20,),
        TextButton(
          onPressed: (){}, 
          child: Text.rich(
            TextSpan(
              text: tAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                TextSpan(
                  text: tSignup,
                  style: TextStyle(color: Colors.blue),
                )
              ]
          ))
          )
      ],
    );
  }
}


