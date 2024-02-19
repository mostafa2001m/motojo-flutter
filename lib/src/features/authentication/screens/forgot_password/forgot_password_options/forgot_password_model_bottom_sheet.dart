import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motojo/src/constants/sizes.dart';
import 'package:motojo/src/constants/text_strings.dart';
import 'package:motojo/src/features/authentication/screens/forgot_password/forgot_password_mail/forgot_password_mail.dart';
import 'package:motojo/src/features/authentication/screens/forgot_password/forgot_password_options/forgot_Password_Btn_Widget.dart';

class ForgotPasswordScreen
{
static Future<dynamic> buildShowModalBottomSheet(BuildContext context)
  {
    return showModalBottomSheet(
                    context: context, 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    builder: (context)=>Container(
                      padding: EdgeInsets.all(tDefaultSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tForgotPasswordTitle,style: Theme.of(context).textTheme.headlineLarge,),
                          Text(tForgotPasswordSubTitle,style: Theme.of(context).textTheme.bodyText2,),
                          SizedBox(height: 30.0,),
                          forgotPasswordBtnWidget(
                            btnIcon: Icons.mail_outline_rounded, 
                            title: tEmail, 
                            subTitle: tResetviaEmail, 
                            onTap: () {
                              Navigator.pop(context);
                              Get.to(()=>ForgotPasswordMailScreen());
                            },
                          ),
                          SizedBox(height: 20,),
                          forgotPasswordBtnWidget(
                            btnIcon: Icons.mobile_friendly_rounded, 
                            title: tPhoneNo, 
                            subTitle: tResetviaPhone, 
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                    );
  }  
}