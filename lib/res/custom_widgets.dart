import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
Widget logoContainer(){
  return  Container(
      alignment: Alignment.topCenter,
      height: double.infinity,
      width: double.infinity,
      color: Colors.green,
      child:Container(
        height: height * 0.10,
        width: width * 0.5,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.logoFundamakers))),
      )
  );
}

Widget paddingContainer({required child}){
 return Container(
     padding: EdgeInsets.symmetric(
       vertical: height * 0.1,
       horizontal: width*0.05
     ),
     margin: EdgeInsets.only(
       top: height * 0.15,
     ),
   height: height * 0.9,
   width: width,
   decoration: BoxDecoration(
       color: AppColors.themeWhiteColor,
       borderRadius:
       BorderRadius.only(topLeft: Radius.circular(width * 0.3))),
   child: child
 );
}

Widget verticalBorder({Color?color}){
  return Container(
      height: height * 0.03,
    width: 1.5,
    color: color,
  );
}