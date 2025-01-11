import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/profile/online_test_result.dart';
import 'package:google_fonts/google_fonts.dart';

class OnlineTest extends StatefulWidget {
  const OnlineTest({Key? key}) : super(key: key);

  @override
  OnlineTestState createState() => OnlineTestState();
}

class OnlineTestState extends State<OnlineTest> {
  String selectedOption = "";
  String correctAnswer = "c";
  late PageController _pageController;
  int _selectedIndex = 0;
  List<ColorModel> colorList = [
    ColorModel(color: Colors.black45, name: " Not Visited Questions."),
    ColorModel(color: Colors.red, name: " Not Answered Questions."),
    ColorModel(color: Colors.green, name: " Answered Questions."),
    ColorModel(color: Colors.orange, name: " Answered & Marked For Review."),
    ColorModel(color: Colors.purple, name: " Not-Answered Marked For Review."),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_seconds == 0) {
          if (_minutes == 0) {
            _timer.cancel();
          } else {
            _minutes--;
            _seconds = 59;
          }
        } else {
          _seconds--;
        }
        setState(() {});
      },
    );
  }

  void checkAnswer(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  Widget buildOption(String optionText) {
    String optionLetter = optionText[0].toLowerCase();
    bool isCorrect = correctAnswer == optionLetter;
    bool isSelected = selectedOption == optionLetter;

    Color optionColor = AppColors.textButtonColor;

    if (isSelected) {
      optionColor = isCorrect ? Colors.green : Colors.red;
    }
    return InkWell(
      onTap: () => checkAnswer(optionLetter),
      child: Container(
        alignment: Alignment.center,
        height: kIsWeb ? height * 0.02 : height * 0.04,
        width: kIsWeb ? width * 0.15 : width * 0.3,
        decoration: BoxDecoration(
          color: optionColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          optionText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  late Timer _timer;
  int _minutes = 30;
  int _seconds = 0;

  String _formatTime(int time) {
    return time < 10 ? '0$time' : '$time';
  }

  bool isTablet(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double aspectRatio = screenWidth;

    const tabletAspectRatioThreshold = 600;

    return aspectRatio > tabletAspectRatioThreshold;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.themeGreenColor,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
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
        actions: [
          //PerformanceChart()
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnlineTestResult()));
              },
              child: const Text(
                'Result ',
                style:
                    TextStyle(color: AppColors.themeWhiteColor, fontSize: 17),
              ))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.themeWhiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "\nOnline Test",
                style: GoogleFonts.robotoCondensed(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.themeGreenColor,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Image(
                image: const AssetImage(Assets.imagesArrow),
                width: isTablet(context)
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.width * 0.3,
              ),
            ),
            Container(
              // color: Colors.blue,
              height: isTablet(context) ? height * 0.25 : height * 0.17,
              margin: const EdgeInsets.all(5),
              child: PageView(
                controller: _pageController,
                children: List.generate(10, (index) => buildQuestion(index)),
                onPageChanged: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = (_selectedIndex + 1) % 10;
                    _pageController.animateToPage(
                      _selectedIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: kIsWeb ? height * 0.04 : height * 0.04,
                  width: kIsWeb ? width * 0.08 : width * 0.25,
                  decoration: BoxDecoration(
                      color: AppColors.themeGreenColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('Submit',
                      style: GoogleFonts.robotoCondensed(
                        textStyle: const TextStyle(
                            color: AppColors.themeWhiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isTablet(context)
                      ? MediaQuery.of(context).size.width * 0.2
                      : 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = (_selectedIndex + 1) % 10;
                        _pageController.animateToPage(
                          _selectedIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: isTablet(context)
                          ? MediaQuery.of(context).size.height * 0.05
                          : MediaQuery.of(context).size.height * 0.04,
                      width: isTablet(context)
                          ? MediaQuery.of(context).size.width * 0.2
                          : MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Skip',
                          style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                                color: AppColors.themeWhiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: isTablet(context)
                          ? MediaQuery.of(context).size.height * 0.05
                          : MediaQuery.of(context).size.height * 0.04,
                      width: isTablet(context)
                          ? MediaQuery.of(context).size.width * 0.2
                          : MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                          color: AppColors.lastButtonColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Reset',
                          style: GoogleFonts.robotoCondensed(
                            textStyle: const TextStyle(
                                color: AppColors.themeWhiteColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Result:5/10',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Text(
                  'Passed',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
            buildPageNumbers(),
            const Text(
              '  Legends:',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: colorList.length,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.blue,
                    margin: const EdgeInsets.only(left: 10),
                    height: height * 0.03,
                    width: width * 0.42,
                    child: Row(
                      children: [
                        Container(
                          height: height * 0.02,
                          width: isTablet(context)
                              ? MediaQuery.of(context).size.width * 0.01
                              : MediaQuery.of(context).size.width * 0.04,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              color: colorList[index].color,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        Text(colorList[index].name)
                      ],
                    ),
                  );
                }),
            SizedBox(height: height * 0.01),
            Row(
              children: [
                const Text(
                  '   Time Left:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' ${_formatTime(_minutes)}:${_formatTime(_seconds)}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            )
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(int index) {
    return ListView(
      children: [
        Container(
          alignment: Alignment.center,
          width: isTablet(context)
              ? MediaQuery.of(context).size.width * 0.9
              : MediaQuery.of(context).size.width * 0.9,
          child: Text(
            'Which planet is known as the "Red Planet"?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: isTablet(context) ? 15 : 15,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: height * 0.01,
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: isTablet(context) ? 15 : 6,
          mainAxisSpacing: isTablet(context) ? 8 : 7,
          crossAxisSpacing: isTablet(context) ? 5 : 7,
          children: [
            buildOption(
              "a. Venus",
            ),
            buildOption("b. Earth"),
            buildOption("c. Mars"),
            buildOption("d. Jupiter"),
          ],
        ),
        // Text('  Ans.${correctAnswer}',
        //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      ],
    );
  }

  Widget buildPageNumbers() {
    return Container(
      // color: Colors.blue,
      height: isTablet(context)
          ? MediaQuery.of(context).size.height * 0.1
          : MediaQuery.of(context).size.height * 0.2,
      padding: isTablet(context)
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: isTablet(context) ? 10 : 2,
          crossAxisCount: 5,
          crossAxisSpacing: isTablet(context) ? 10 : 10,
          mainAxisSpacing: isTablet(context) ? 5 : 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          bool isSelected = index == _selectedIndex;
          return InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            },
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.themeGreenColor
                    : AppColors.textButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: AppColors.themeWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet(context) ? 12 : 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }
}

class ColorModel {
  final Color color;
  final String name;

  ColorModel({required this.color, required this.name});
}
