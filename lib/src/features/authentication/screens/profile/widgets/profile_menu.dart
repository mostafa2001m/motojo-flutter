import 'package:flutter/material.dart';
import 'package:motojo/src/constants/colors.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key, required this.title, required this.icon, required this.onPressed,  this.endIcon=true, this.textColor,
  });
 final String title;
 final IconData icon;
 final VoidCallback onPressed;
 final bool endIcon;
 final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark=MediaQuery.of(context).platformBrightness==Brightness.dark;
    var iconColor=isDark?tSecondaryColor:tPrimaryColor;
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1)
        ),
        child: Icon(icon,color:iconColor,),
      ),
      title: Text(title,style:Theme.of(context).textTheme.bodyText1?.apply(color: textColor),),
      trailing:endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1)
        ),
        child: Icon(Icons.arrow_right,size: 30,color: Colors.grey,),
      ):null,
    );
  }
}