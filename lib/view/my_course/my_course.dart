import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/course_view_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class MyCourse extends StatefulWidget {
  const MyCourse({Key? key}) : super(key: key);

  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coursesView = Provider.of<CoursesViewModel>(context, listen: false);
      coursesView.coursesApi(context);
    });
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
      body: Consumer<CoursesViewModel>(builder: (context, value, _) {
        switch (value.coursesResponse.success) {
          case Success.LOADING:
            return Container(
              height: height * 0.3,
              width: width,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          case Success.ERROR:
            return Container(
              height: height * 0.3,
              width: width,
              alignment: Alignment.center,
              child: const Image(image: AssetImage(Assets.imagesNoData)),
            );
          case Success.COMPLETED:
            if (value.coursesResponse.data != null &&
                value.coursesResponse.data!.data != null &&
                value.coursesResponse.data!.data!.isNotEmpty) {
              final coursesView = value.coursesResponse.data!.data!;
              return ListView(
                shrinkWrap: true,
                children: [
                  textWidget(
                      text: 'My Course',
                      fontWeight: FontWeight.w700,
                      fontSize: Dimensions.twentyFour),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1,
                    crossAxisSpacing: width * 0.02,
                    mainAxisSpacing: height * 0.01,
                    children: coursesView.map((data) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.introCourseScreen);
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
                                height: height * 0.1,
                                child: const Image(
                                    image: AssetImage(Assets.imagesCommunity)),
                              ),
                              textWidget(
                                  text: data.name.toString(),
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimensions.fifteen),
                              Row(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  LinearPercentIndicator(
                                    width: width * 0.3,
                                    animation: true,
                                    lineHeight: 5.0,
                                    animationDuration: 2000,
                                    percent: 0.99,
                                    barRadius: const Radius.circular(10),
                                    progressColor: AppColors.textButtonColor,
                                  ),
                                  textWidget(
                                      text: "90.0%",
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.fifteen),
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
            } else {
              return Column(
                children: [
                  Container(
                    height: height * 0.5,
                    width: width,
                    alignment: Alignment.center,
                    child: const Image(image: AssetImage(Assets.imagesNoData)),
                  ),
                  textWidget(text: 'No Data Available')
                ],
              );
            }
        }
      }),
    );
  }
}
