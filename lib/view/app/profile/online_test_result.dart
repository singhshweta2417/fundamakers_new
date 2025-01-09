import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/app/test/performance_chart.dart';

class OnlineTestResult extends StatefulWidget {
  const OnlineTestResult({Key? key}) : super(key: key);

  @override
  State<OnlineTestResult> createState() => _OnlineTestResultState();
}

class _OnlineTestResultState extends State<OnlineTestResult> {
  List<BuyCourseModel> courseList = [
    BuyCourseModel(
      title: '8 March 2023',
      subTitle: 'Time: 8:30am',
      image: Assets.imagesCommunity,
      screen: 'Passed',
    ),
    BuyCourseModel(
      title: '8 March 2023',
      subTitle: 'Time: 8:30am',
      image: Assets.imagesCommunity,
      screen: 'Passed',
    ),
    BuyCourseModel(
      title: '8 March 2023',
      subTitle: 'Time: 8:30am',
      image: Assets.imagesCommunity,
      screen: 'Passed',
    ),
  ];
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
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: courseList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PerformanceChart()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: containerWidth * 0.05, vertical: 20),
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
                        width: containerWidth * (width > 600 ? 0.2 : 0.45),
                        height: containerHeight * 0.092,
                        child: const Image(
                          image: AssetImage(Assets.imagesCommunity),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseList[index].title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: kIsWeb ? 13 : 12,
                            ),
                          ),
                          Text(
                            courseList[index].subTitle,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: kIsWeb ? 13 : 12,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.25,
                                child: const Text(
                                  'Result: 15/20',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: kIsWeb ? 13 : 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                courseList[index].screen,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: kIsWeb ? 13 : 12,
                                ),
                              ),
                            ],
                          ),
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

class BuyCourseModel {
  final String title;
  final String subTitle;
  final String image;
  final String screen;
  BuyCourseModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.screen,
  });
}
