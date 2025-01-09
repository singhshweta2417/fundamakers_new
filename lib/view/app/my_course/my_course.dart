
// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/providers/course/course_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/app/my_course/intro_course_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({Key? key}) : super(key: key);

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {


  CourseProvider subjectProvider = CourseProvider();
  List<CourseModel> myCourseList = [];
  bool isLoading = false;

  Future<void> allCourseData() async {
    myCourseList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<CourseModel> reviewsList = await subjectProvider.fetchCourseData();
      setState(() {
        myCourseList = reviewsList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print('Error fetching subjects data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    allCourseData();
  }


  @override
  Widget build(BuildContext context) {
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
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double containerWidth = constraints.maxWidth;
      double containerHeight = constraints.maxHeight;
      return ListView(
        shrinkWrap: true,
        children: [
          Text(
            '\n  My Course\n',
            style: GoogleFonts.robotoCondensed(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 22)),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                0,
                MediaQuery.of(context).size.width * 0.1,
                MediaQuery.of(context).size.width * 0.1),
            crossAxisCount:
            MediaQuery.of(context).size.width > 600 ? 4 : 2,
            children: myCourseList.map((data) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IntroCourseScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: containerHeight *
                            (MediaQuery.of(context).size.height > 800
                                ? 0.12
                                : 0.07),
                        width: containerWidth *
                            (MediaQuery.of(context).size.width > 600
                                ? 0.32
                                : 0.43),
                        child: const Image(image: AssetImage(Assets.imagesCommunity)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          data.name.toString(),
                          style: GoogleFonts.robotoCondensed(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
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
                      Row(
                        children: [
                          LinearPercentIndicator(
                            width: containerWidth *
                                (MediaQuery.of(context).size.width > 600 ? (containerWidth > 600 ? 0.12 : 0.12) : 0.25),
                            animation: true,
                            lineHeight: 5.0,
                            animationDuration: 2000,
                            percent: 0.99,
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            progressColor: AppColors.textButtonColor,
                          ),
                          Text(
                            "90.0%",
                            style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      );
    },
    ),
    );
  }
}

