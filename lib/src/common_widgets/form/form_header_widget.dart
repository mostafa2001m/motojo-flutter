// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:motojo/src/constants/image_strings.dart';
import 'package:motojo/src/constants/text_strings.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
     required this.title, 
     required this.image, 
     required this.subTitle, 
     this.imageColor, 
      this.imageHeight=0.2, 
     this.heightBetween, 
      this.crossAxisAlignment=CrossAxisAlignment.start,
      this.textAlign
  });

  
  final String title,image,subTitle;
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(image: AssetImage(image),color: imageColor,height: size.height*imageHeight,),
        SizedBox(height: heightBetween,),
        Text(title,style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
        Text(subTitle,style: Theme.of(context).textTheme.bodyText1,textAlign: textAlign,),

      ],
    );
  }
}
