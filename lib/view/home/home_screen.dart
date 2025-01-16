import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/bottom_navigation_screen.dart';
import 'package:fundamakers/view_model/course_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final List<ItemsModel> itemList = [
      ItemsModel(
        title: 'Online Classes',
        imageData: "",
        onTap: () {
          Navigator.pushNamed(context, RoutesName.onlineClassesList);
        },
      ),
      ItemsModel(
        title: 'MY Courses',
        imageData: "",
        onTap: () {
          NavigatorService.navigateToCourseScreen(context);
        },
      ),
    ];
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.notifications);
            },
            icon: const Icon(Icons.notifications),
          )
        ],
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
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SpaceHeight.getZeroTwo(context),
                    textWidget(
                        text:
                            "Get Ready To Excel In CAT,IPMAT And CUET Exams With FundaMakers, India's Favorite Coaching Destination",
                        fontSize: Dimensions.twenty,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textButtonColor,
                        textAlign: TextAlign.center),
                    Image(
                      image: const AssetImage(Assets.imagesArrowPng),
                      width: width * 0.3,
                    ),
                    SpaceHeight.getZeroTwo(context),
                    textWidget(
                        text: "All Courses (CAT,IPMAT,CUET)",
                        fontSize: Dimensions.twenty,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textButtonColor,
                        textAlign: TextAlign.center),
                    Image(
                      image: const AssetImage(Assets.imagesArrowPng),
                      width: width * 0.3,
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: coursesView.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.05,
                              vertical: height * 0.01),
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.01),
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
                          child: ListTile(
                            minVerticalPadding: 0.0,
                            contentPadding: EdgeInsets.zero,
                            onTap: () {
                              if (index >= 0 && index < coursesView.length) {
                                Navigator.pushNamed(
                                    context, RoutesName.menuCourse, arguments: {
                                  'subjectId': coursesView[index].id.toString()
                                });
                              }
                            },
                            trailing: const Icon(Icons.arrow_forward_ios),
                            leading: Container(
                              height: height * 0.05,
                              width: width * 0.15,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Assets.imagesCourse))),
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Container(
                              alignment: Alignment.center,
                              height: height * 0.04,
                              child: textWidget(
                                  text: coursesView[index].name.toString(),
                                  fontSize: Dimensions.eighteen,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textButtonColor,
                                  textAlign: TextAlign.center),
                            ),
                            subtitle: SizedBox(
                              height: height * 0.07,
                              child: textWidget(
                                  threshold: 900,
                                  text:
                                      coursesView[index].description.toString(),
                                  maxLines: 2,
                                  fontSize: Dimensions.thirteen,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textButtonColor),
                            ),
                          ),
                        );
                      },
                    ),
                    textWidget(
                        text: "Question Bank (CAT)",
                        fontSize: Dimensions.twenty,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textButtonColor,
                        textAlign: TextAlign.center),
                    Image(
                      image: const AssetImage(Assets.imagesArrowPng),
                      width: width * 0.3,
                    ),
                    SpaceHeight.getZeroTwo(context),
                    AppBtn(
                      gradient: AppColors.gradientDisable,
                      width: width * 0.5,
                      onTap: () {
                        // Navigator.pushNamed(context, RoutesName.onlineTestResult);
                      },
                      title: 'CAT Question Bank',
                    ),
                    SpaceHeight.getZeroTwo(context),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio:4.5,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: itemList.map((data) {
                        return InkWell(
                          onTap: data.onTap,
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.themeWhiteColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(width: 0.1),
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                            ),
                            alignment: Alignment.center,
                            child: textWidget(
                                text:
                                data.title,
                                fontSize: Dimensions.fifteen,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textButtonColor),
                          ),
                        );
                      }).toList(),
                    ),
                    SpaceHeight.getZeroTwo(context),

                  ],
                ),
              );
            } else {
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
        }
      }),
    );
  }
}
class ItemsModel {
  final String title;
  final String imageData;
  final VoidCallback onTap;
  ItemsModel(
      {required this.title, required this.imageData, required this.onTap});
}
