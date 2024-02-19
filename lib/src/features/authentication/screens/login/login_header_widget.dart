// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/text_strings.dart';

class loginHeaderWidget extends StatelessWidget {
  const loginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(tWelcomeScreenImage),height: size.height*0.3,),
        Text(tLoginTitle,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
        Text(tLoginSubTitle,style: Theme.of(context).textTheme.bodyText1,textAlign: TextAlign.center,),

      ],
    );
  }
}
