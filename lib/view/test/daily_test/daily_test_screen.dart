import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyTestScreen extends StatefulWidget {
  const DailyTestScreen({super.key});

  @override
  DailyTestScreenState createState() => DailyTestScreenState();
}

class DailyTestScreenState extends State<DailyTestScreen> {
  String selectedOption = "";
  String correctAnswer = "c";
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
        child: Text(optionText,
            style: GoogleFonts.robotoCondensed(
              textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            )),
      ),
    );
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
          children: [
            Center(
              child: Text(
                "Daily Test",
                style: GoogleFonts.robotoCondensed(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.themeGreenColor,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image(
              image: const AssetImage(Assets.imagesArrowPng),
              width: width * 0.3,
            ),
            Expanded(
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
            Text('Result:5/10',
                style: GoogleFonts.robotoCondensed(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                )),
            buildPageNumbers(),
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(int index) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.99,
          child: Text('Which planet is known as the "Red Planet"?',
              textAlign: TextAlign.center,
              style: GoogleFonts.robotoCondensed(
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              )),
        ),
        const SizedBox(height: 2),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 3.5,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 13,
          crossAxisSpacing: 13,
          children: [
            buildOption("a. Venus"),
            buildOption("b. Earth"),
            buildOption("c. Mars"),
            buildOption("d. Jupiter"),
          ],
        ),
        // Text('  Ans.$correctAnswer',
        //     style: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildPageNumbers() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.5,
          crossAxisCount: 5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.themeGreenColor
                    : AppColors.textButtonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                    color: AppColors.themeWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
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
    super.dispose();
  }
}
