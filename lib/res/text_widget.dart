import 'package:flutter/material.dart';
import 'package:fundamakers/main.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textWidget({
  required String text,
  double? fontSize,
  FontWeight fontWeight = FontWeight.normal,
  Color? color,
  TextAlign textAlign = TextAlign.start,
  TextDecoration? decoration ,
  int? maxLines,
  String? fontFamily,
  bool showMore = false,
  int threshold = 150,
  final void Function()?onTap,
  Function()? onToggle,
}) {
  bool isLongText = text.length > threshold;
  String displayedText =
  isLongText && !showMore ? '${text.substring(0, threshold)}...' : text;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: onTap,
        child: Text(
          displayedText,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: maxLines != null ? TextOverflow.ellipsis : null,
          style: TextStyle(
            fontSize: fontSize ?? Dimensions.twenty,
            fontWeight: fontWeight,
            color: color??Colors.black,
            decoration: decoration,
          ).merge(GoogleFonts.robotoCondensed()),
        ),
      ),
      if (isLongText)
        GestureDetector(
          onTap: onToggle,
          child: Text(
            showMore ? 'Read Less' : 'Read More',
            style: TextStyle(
              fontSize: fontSize ?? Dimensions.sixteen,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
    ],
  );
}

class Dimensions {
  static double twentyFour = 24;
  static double twenty = 20;
  static double five = 5;
  static double fourteen = 14;
  static double thirteen = 13;
  static double eighteen = 18;
  static double sixteen = 16;
  static double fifteen = 15;
  static double ten = 10;
  static double twelve = 12;
  static double eight = 8;
}


class SpaceHeight {
  static Widget getZeroTwo(BuildContext context) {
    return SizedBox(height: height * 0.02);
  }
  static Widget getZeroFive(BuildContext context) {
    return SizedBox(height: height * 0.05);
  }
}
