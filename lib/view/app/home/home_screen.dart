import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/providers/course/course_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/app/home/course/menu_course.dart';
import 'package:fundamakers/view/app/home/notifications.dart';
import 'package:google_fonts/google_fonts.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  CourseProvider subjectProvider = CourseProvider();
  List<CourseModel> homeList = [];
  bool isLoading = false;

  Future<void> allCourseData() async {
    homeList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<CourseModel> reviewsList = await subjectProvider.fetchCourseData();
      setState(() {
        homeList = reviewsList;
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
    Future<bool?> showBackDialog() {
      return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.themeWhiteColor,
            content: const Text(
              'Are you sure you want to exit?',
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Exit'),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
            ],
          );
        },
      );
    }
    return PopScope(
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Notifications()));
              },
              icon: const Icon(Icons.notifications),
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double containerWidth = constraints.maxWidth;
            double containerHeight = constraints.maxHeight;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: containerHeight * 0.02,
                  ),
                  SizedBox(
                    width: containerWidth,
                    child: Center(
                      child: Text(
                        "Get Ready To Excel In CAT,IPMAT And CUET Exams With FundaMakers, India's Favorite Coaching Destination",
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textButtonColor,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Image(
                    image: const AssetImage(Assets.imagesArrow),
                    width: containerWidth * 0.3,
                  ),
                  Center(
                    child: Text(
                      "\nAll Courses (CAT,IPMAT,CUET)",
                      style: GoogleFonts.robotoCondensed(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textButtonColor,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image(
                    image: const AssetImage(Assets.imagesArrow),
                    width: containerWidth * 0.3,
                  ),
                  homeList.isEmpty?const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.themeGreenColor,
                    ),
                  ):
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: homeList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: containerWidth * 0.05, right: containerWidth * 0.05, top: 18),
                        height: containerHeight * 0.13,
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
                          onTap: () {
                            if (index >= 0 && index < homeList.length) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MenuCourse(subjectId: homeList[index].id.toString())),
                              );
                            } else {
                            }
                          },
                          trailing: const Icon(Icons.arrow_forward_ios),
                          leading:Image(
                            image: const AssetImage(Assets.imagesCourse),
                            width: containerWidth * 0.2,
                          ),
                          title: Text(
                            homeList[index].name.toString(),
                            style: GoogleFonts.robotoCondensed(
                              textStyle: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            homeList[index].description.toString(),
                            maxLines: 2,
                            style: GoogleFonts.robotoCondensed(
                              textStyle: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Text(
                      "\nQuestion Bank (CAT)",
                      style: GoogleFonts.robotoCondensed(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textButtonColor,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Image(
                    image: const AssetImage(Assets.imagesArrow),
                    width: containerWidth * 0.3,
                  ),
                  SizedBox(height: containerHeight * 0.01,),
                  InkWell(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>const OnlineTestResult()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: containerHeight * 0.06,
                      width: containerWidth * 0.5,
                      decoration: BoxDecoration(
                        color: AppColors.textButtonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'CAT Question Bank',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(color: AppColors.themeWhiteColor, fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: containerHeight * 0.02,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
