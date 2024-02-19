import 'package:flutter/material.dart';

class forgotPasswordBtnWidget extends StatelessWidget {
  const forgotPasswordBtnWidget({
    super.key, required this.btnIcon, required this.title, required this.subTitle, required this.onTap,
  });
  final IconData btnIcon;
  final String title,subTitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(btnIcon,size: 60,),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: Theme.of(context).textTheme.headline6,),
                Text(subTitle,style: Theme.of(context).textTheme.bodyText2,)
              ],
            )
          ],
        ),
      ),
    );
  }
}