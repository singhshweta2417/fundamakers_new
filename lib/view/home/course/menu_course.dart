import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/course_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MenuCourse extends StatefulWidget {
  const MenuCourse({Key? key}) : super(key: key);
  @override
  State<MenuCourse> createState() => _MenuCourseState();
}

class _MenuCourseState extends State<MenuCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null && args.containsKey('subjectId')) {
        final subjectId = args['subjectId'];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final coursesView =
              Provider.of<CoursesViewModel>(context, listen: false);
          coursesView.subCoursesApi(subjectId, context);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final subCoursesView =
        Provider.of<CoursesViewModel>(context).subCourseResponse?.data;
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
          return (subCoursesView == null || subCoursesView.isEmpty)
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.themeGreenColor,
                  ),
                )
              : (subCoursesView == [])
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: height * 0.25,
                          width: width,
                          alignment: Alignment.center,
                          child: const Image(
                              image: AssetImage(Assets.imagesNoData)),
                        ),
                        textWidget(
                            text: 'No Data Available',
                            fontSize: Dimensions.eighteen,
                            color: AppColors.textButtonColor,
                            fontWeight: FontWeight.w500)
                      ],
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: subCoursesView.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.planCourse, arguments: {
                              'subCourseId': subCoursesView[index].id.toString(),
                              'title':subCoursesView[index].name.toString()
                            });
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: containerHeight * 0.09,
                                  width: containerWidth *
                                      (width > 600 ? 0.2 : 0.3),
                                  child: const Image(
                                      image:
                                          AssetImage(Assets.imagesCommunity)),
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
                                        subCoursesView[index].name.toString(),
                                        style: GoogleFonts.robotoCondensed(
                                          textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        subCoursesView[index]
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
