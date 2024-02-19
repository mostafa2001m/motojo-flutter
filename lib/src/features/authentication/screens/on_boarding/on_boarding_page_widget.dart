import 'package:flutter/material.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/features/authentication/models/model_on_boarding.dart';

class onBoardingPageWidget extends StatelessWidget {
  const onBoardingPageWidget({
    super.key,
    required this.model,
  });

  final onBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(tDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image),height: size.height*0.4,),
          Column(
            children: [
              Text(model.title,style: Theme.of(context).textTheme.headline3,),
              Text(model.subTitle,textAlign: TextAlign.center,),
            ],
          ),
          Text(model.counterText,style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 90,)
        ],
      ),
    );
  }
}