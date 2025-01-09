import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/models/course/sub_course_model.dart';
import 'package:fundamakers/providers/course/sub_course_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/app/home/course/plans/plan_lists.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuCourse extends StatefulWidget {
  final String subjectId;
  const MenuCourse({Key? key,required this.subjectId}) : super(key: key);
  @override
  State<MenuCourse> createState() => _MenuCourseState();
}

class _MenuCourseState extends State<MenuCourse> {
  SubCourseProvider subCourseProvider = SubCourseProvider();
  List<SubCourseModel> subCourseList = [];
  bool isLoading = false;

  Future<void> allSubCourseData(String subjectId) async {
    subCourseList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<SubCourseModel> reviewsList =
      await subCourseProvider.fetchSubCourseData(subjectId);
      setState(() {
        subCourseList = reviewsList;
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
    allSubCourseData(widget.subjectId);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double containerWidth = constraints.maxWidth;
          double containerHeight = constraints.maxHeight;
          return isLoading && subCourseList.isEmpty
              ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.themeGreenColor,
            ),
          )
              : subCourseList.isEmpty
              ? const Center(
            child: Text("No Data Available",style: TextStyle(color: Colors.black),),
          )
              : ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: subCourseList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlanCourse(
                            subCourse: subCourseList[index]
                                .id
                                .toString())),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: containerWidth * 0.05,
                      vertical: 20),
                  height: containerHeight * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.themeWhiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: containerHeight * 0.09,
                        width: containerWidth *
                            (width > 600 ? 0.2 : 0.3),
                        child: const Image(
                            image: AssetImage(
                                Assets.imagesCommunity)),
                      ),
                      SizedBox(
                        width: containerWidth *
                            (width > 600 ? 0.2 : 0.45),
                        height: containerHeight *
                            (width > 600 ? 0.08 : 0.08),
                        child: ListView(
                          physics:
                          const NeverScrollableScrollPhysics(),
                          children: [
                            Text(
                              subCourseList[index].name,
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              subCourseList[index]
                                  .courseId
                                  .toString(),
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: false,
                                  initialRating: 5,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: containerWidth *
                                      (width > 600 ? 0.015 : 0.05),
                                  itemBuilder: (context, _) =>
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (double value) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 10),
                          Icon(Icons.arrow_forward_ios),
                          SizedBox(height: 10),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


