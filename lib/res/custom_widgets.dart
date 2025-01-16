import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';

Widget logoContainer() {
  return Container(
      alignment: Alignment.topCenter,
      height: double.infinity,
      width: double.infinity,
      color: Colors.green,
      child: Container(
        height: height * 0.10,
        width: width * 0.5,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.logoFundamakers))),
      ));
}

Widget paddingContainer({required child}) {
  return Container(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.1, horizontal: width * 0.05),
      margin: EdgeInsets.only(
        top: height * 0.15,
      ),
      height: height * 0.9,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.themeWhiteColor,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(width * 0.3))),
      child: child);
}

Widget verticalBorder({Color? color}) {
  return Container(
    height: height * 0.03,
    width: 1.5,
    color: color,
  );
}

Widget listContainer({required child,padding,margin}) {
  return Container(
    alignment: Alignment.center,
    padding:padding??
        EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.02),
    margin:margin??
        EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
    decoration: BoxDecoration(
      color: AppColors.themeWhiteColor,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 3,
          blurRadius: 2,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget noDataAvailable() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: height * 0.25,
        width: width,
        alignment: Alignment.center,
        child: const Image(image: AssetImage(Assets.imagesNoData)),
      ),
      textWidget(
          text: 'No Data Available',
          fontSize: Dimensions.eighteen,
          color: AppColors.textButtonColor,
          fontWeight: FontWeight.w500)
    ],
  );
}

Widget circularProgressIndicator() {
  return Center(
    child: Container(
      height: height * 0.3,
      width: width,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ),
  );
}
