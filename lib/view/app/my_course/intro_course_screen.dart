
// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/app/my_course/my_course_video.dart';
import 'package:fundamakers/view/app/my_course/my_course_video_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class IntroCourseScreen extends StatefulWidget {
  const IntroCourseScreen({Key? key}) : super(key: key);

  @override
  State<IntroCourseScreen> createState() => _IntroCourseScreenState();
}

class _IntroCourseScreenState extends State<IntroCourseScreen> {
  bool _isExpanded1 = false;
  bool _isExpanded2 = false;
  bool _isExpanded3 = false;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.themeGreenColor,
        title: SizedBox(
          width: width * 0.4,
          child: const Image(
            image: AssetImage(Assets.logoFundamakers),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15,8,15,8),
        child: ListView(
          children: [
            SizedBox(height: height * 0.02),
            Container(
              width: kIsWeb ? width * 0.5 : width * 0.3,
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              decoration: BoxDecoration(
              color: AppColors.themeWhiteColor,
                border: Border.all(width: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CAT 8 Month Weekend Course',
                    style: GoogleFonts.robotoCondensed(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: kIsWeb ? 15 : width * 0.05,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        RatingBar.builder(
                          ignoreGestures: false,
                          initialRating: 5,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  LinearPercentIndicator(
                    width: kIsWeb ? width * 0.55 : width * 0.65,
                    animation: true,
                    lineHeight:5.0,
                    animationDuration: 2000,
                    percent: 0.99,
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: AppColors.textButtonColor,
                  ),
                  Padding(
                    padding: EdgeInsets.all(kIsWeb ? width * 0.02 : width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "90%",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kIsWeb ? 15 : width * 0.035,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "5/18",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kIsWeb ? 15 : width * 0.035,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.03, height * 0.015, width * 0.03, height * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCourseVideoList()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: kIsWeb ? width * 0.2 : width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.textButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Lessons',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeWhiteColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCourseVideoList()));
                      //MyCourseVideo()
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: kIsWeb ? width * 0.2 : width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.textButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Live Class',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:const EdgeInsets.fromLTRB(20,10,20,10),
              decoration: BoxDecoration(
                color: AppColors.themeWhiteColor,
                border: Border.all(width: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Introduction',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded1 = !_isExpanded1;
                            });
                          },
                          icon: Icon(_isExpanded1
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded))
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.04,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                            color: AppColors.textButtonColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '00:24:30',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.themeWhiteColor),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.04,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                            color: AppColors.themeGreenColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '10 Lessons',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.themeWhiteColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _isExpanded1 ? null : 0,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text(
                              'Lesson 1',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '5 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                          ListTile(
                            title: const Text(
                              'Lesson 2',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '10 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                          ListTile(
                            title: const Text(
                              'Lesson 3',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '15 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.03, height * 0.015, width * 0.03, height * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCourseVideo()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: kIsWeb ? width * 0.2 : width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.textButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Lessons',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeWhiteColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCourseVideo()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: kIsWeb ? width * 0.2 : width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.textButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Live Class',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              decoration: BoxDecoration(
                color: AppColors.themeWhiteColor,
                border: Border.all(width: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Introduction',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded2 = !_isExpanded2;
                            });
                          },
                          icon: Icon(_isExpanded2
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded))
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.04,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                            color: AppColors.textButtonColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '00:24:30',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.themeWhiteColor),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.04,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                            color: AppColors.themeGreenColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '10 Lessons',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.themeWhiteColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _isExpanded2? null : 0,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text(
                              'Lesson 1',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '5 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                          ListTile(
                            title: const Text(
                              'Lesson 2',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '10 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                          ListTile(
                            title: const Text(
                              'Lesson 3',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '15 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  width * 0.03, height * 0.015, width * 0.03, height * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCourseVideoList()));
                      //MyCourseVideo()
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: kIsWeb ? width * 0.2 : width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.textButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Lessons',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeWhiteColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyCourseVideo()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      width: kIsWeb ? width * 0.2 : width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.textButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        'Live Class',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeWhiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20,10,20,10),
              decoration: BoxDecoration(
                color: AppColors.themeWhiteColor,
                border: Border.all(width: 0.1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Introduction',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded3 = !_isExpanded3;
                            });
                          },
                          icon: Icon(_isExpanded3
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded))
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.04,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                            color: AppColors.textButtonColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '00:24:30',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.themeWhiteColor),
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.04,
                        width: width * 0.25,
                        decoration: BoxDecoration(
                            color: AppColors.themeGreenColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          '10 Lessons',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.themeWhiteColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _isExpanded3? null : 0,
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text(
                              'Lesson 1',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '5 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                          ListTile(
                            title: const Text(
                              'Lesson 2',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '10 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                          ListTile(
                            title: const Text(
                              'Lesson 3',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            subtitle: const Text(
                              '15 min',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            leading: Checkbox(
                              activeColor: AppColors.themeGreenColor,
                              value: _isChecked,
                              onChanged: (value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            trailing: const Icon(Icons.download),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
