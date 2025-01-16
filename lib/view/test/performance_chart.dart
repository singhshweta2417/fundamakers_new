import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PerformanceChart extends StatefulWidget {
  const PerformanceChart({Key? key}) : super(key: key);

  @override
  State<PerformanceChart> createState() => _PerformanceChartState();
}

class _PerformanceChartState extends State<PerformanceChart> {
  String selectedOption = "";
  String correctAnswer = "c";
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  bool _isExpanded = false;

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
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.3,
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
            fontSize: 13,
          ),
        ),
      ),
    );
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
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
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
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "\nPerformance Chart",
              style: GoogleFonts.robotoCondensed(
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.themeGreenColor,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: isTablet(context)
                  ? MediaQuery.of(context).size.width * 0.6
                  : MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Hi! Shweta Singh Chauhan",
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(
                      fontSize: isTablet(context) ? 17 : 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textButtonColor,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Image(
                image: const AssetImage(Assets.imagesArrowPng),
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
                        _isExpanded = !_isExpanded;
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
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Solution',
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showPopUp(context);
                        },
                      );
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
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Video Solution',
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

            ///done
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: _isExpanded
                  ? SizedBox(
                      height: isTablet(context)
                          ? MediaQuery.of(context).size.height * 0.1
                          : MediaQuery.of(context).size.height * 0.2,
                      width: isTablet(context)
                          ? MediaQuery.of(context).size.width * 0.35
                          : MediaQuery.of(context).size.width * 0.5,
                      child:
                          const Image(image: AssetImage(Assets.imagesSolution)),
                    )
                  : buildPageNumbers(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.175,
                  width: isTablet(context)
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Not Visited Questions.',
                        style: TextStyle(
                            color: AppColors.textButtonColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      CircularPercentIndicator(
                        radius: isTablet(context) ? 30 : 45.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 10.0,
                        percent: 0.4,
                        center: const Text(
                          "40%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: Colors.yellow,
                        progressColor: Colors.black45,
                      ),
                      const Text(
                        '1/20',
                        style: TextStyle(
                            color: AppColors.textButtonColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.175,
                  width: isTablet(context)
                      ? MediaQuery.of(context).size.width * 0.2
                      : MediaQuery.of(context).size.width * 0.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Not Answered Question',
                        style: TextStyle(
                            color: AppColors.textButtonColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      CircularPercentIndicator(
                        radius: isTablet(context) ? 30 : 45.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 10.0,
                        percent: 0.4,
                        center: const Text(
                          "40%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: Colors.yellow,
                        progressColor: Colors.red,
                      ),
                      const Text(
                        '1/20',
                        style: TextStyle(
                            color: AppColors.textButtonColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: isTablet(context)
                  ? MediaQuery.of(context).size.height * 0.02
                  : MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.175,
              width: isTablet(context)
                  ? MediaQuery.of(context).size.width * 0.2
                  : MediaQuery.of(context).size.width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Answered Question',
                    style: TextStyle(
                        color: AppColors.textButtonColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  CircularPercentIndicator(
                    radius: isTablet(context) ? 30 : 45.0,
                    animation: true,
                    animationDuration: 1200,
                    lineWidth: 10.0,
                    percent: 0.4,
                    center: const Text(
                      "40%",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: Colors.yellow,
                    progressColor: Colors.green,
                  ),
                  const Text(
                    '1/20',
                    style: TextStyle(
                        color: AppColors.textButtonColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
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
          // padding: isTablet(context) ? EdgeInsets.all(0) : EdgeInsets.all(10),
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

  Widget showPopUp(context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          controller: YoutubePlayerController.fromVideoId(
            videoId: 'gCRNEJxDJKM',
            params: const YoutubePlayerParams(
              showControls: true,
              showFullscreenButton: true,
            ),
          ),
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
