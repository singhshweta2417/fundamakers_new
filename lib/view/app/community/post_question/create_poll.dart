// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({super.key});

  @override
  _PollScreenState createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {

  List<Widget> optionWidgets = [];
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.themeGreenColor,
        title: const Text('Create Your Poll'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                width: isTablet(context) ? width * 0.47 : width * 0.87,
                alignment: Alignment.center,
                margin: EdgeInsets.all(width * 0.04),
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
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.07,
                      color: Colors.white,
                      child: const TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          hintText: 'Ask a question?',
                          hintStyle: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    _buildOptionTextField('Option 1'),
                    _buildOptionTextField('Option 2'),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: optionWidgets.length + 1,
                      itemBuilder: (context, index) {
                        if (index == optionWidgets.length) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                optionWidgets.add(_buildOptionTextField(''));
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.07,
                              color: Colors.white,
                              child: const Text(
                                'Add More Options',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          );
                        } else {
                          return Row(
                            children: [
                              Expanded(child: optionWidgets[index]),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    optionWidgets.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    AppBtn(
                      width: width * 0.82,
                      title: 'Create Poll',
                    ),
                    SizedBox(height: height * 0.02)
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                width: isTablet(context)
                    ? MediaQuery.of(context).size.width * 0.47
                    : MediaQuery.of(context).size.width * 0.85,
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
                child: Column(children: [
                  SizedBox(height: height * 0.02),
                  Text(
                    'What is Your Name?',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.02
                            : MediaQuery.of(context).size.width * 0.05),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Option A:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: isTablet(context)
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.05),
                      ),
                      LinearPercentIndicator(
                        width: isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.2
                            : MediaQuery.of(context).size.width * 0.4,
                        animation: true,
                        lineHeight: height * 0.015,
                        animationDuration: 2000,
                        percent: 0.99,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.blue,
                      ),
                      Text(
                        '90%',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: isTablet(context)
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.05),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Option B:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: isTablet(context)
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.05),
                      ),
                      LinearPercentIndicator(
                        width: isTablet(context)
                            ? MediaQuery.of(context).size.width * 0.2
                            : MediaQuery.of(context).size.width * 0.4,
                        animation: true,
                        lineHeight: height * 0.015,
                        animationDuration: 2000,
                        percent: 0.99,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.blue,
                      ),
                      Text(
                        '90%',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: isTablet(context)
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.05),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Text(
                        '  1 Votes',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: isTablet(context)
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.05),
                      ),
                      Text(
                        '   ● 2 Weeks ago',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: isTablet(context)
                                ? MediaQuery.of(context).size.width * 0.01
                                : MediaQuery.of(context).size.width * 0.05),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02)
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTextField(String hintText) {
    return Container(
      alignment: Alignment.center,
      height: height * 0.07,
      color: Colors.white,
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: const EdgeInsets.all(0),
            hintText: hintText,
            hintStyle: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}
