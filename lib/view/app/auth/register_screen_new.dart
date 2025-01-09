import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/models/course/sub_course_model.dart';
import 'package:fundamakers/providers/auth/otp_provider.dart';
import 'package:fundamakers/providers/auth/registeration_provider.dart';
import 'package:fundamakers/providers/course/course_provider.dart';
import 'package:fundamakers/providers/course/sub_course_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RegisterScreenNew extends StatefulWidget {
  const RegisterScreenNew({Key? key}) : super(key: key);

  @override
  State<RegisterScreenNew> createState() => _RegisterScreenNewState();
}

class _RegisterScreenNewState extends State<RegisterScreenNew> {
  SubCourseProvider subCourseProvider = SubCourseProvider();
  List<SubCourseModel> listTwo = [];
  bool isLoading = false;

  Future<void> allSubCourseListData(String courseId) async {
    listTwo.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<SubCourseModel> reviewsList =
          await subCourseProvider.fetchSubCourseData(courseId);
      setState(() {
        listTwo = reviewsList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print('Error fetching sub-courses data: $e');
      }
    }
  }

  CourseProvider subjectProvider = CourseProvider();

  ///
  Future<void> allCourseListData() async {
    list.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<CourseModel> reviewsList = await subjectProvider.fetchCourseData();
      setState(() {
        list = reviewsList;
        isLoading = false;
      });
      if (listTwo.isEmpty && list.isNotEmpty) {
        allSubCourseListData(list[0].id.toString());
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print('Error fetching courses data: $e');
      }
    }
  }

  List<CourseModel> list = [];
  String dropdownValue = '';
  String dropdownValueTwo = '';

  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  late Timer _timer;
  bool _isVisible = true;

  String? _phoneError;
  String? _emailError;
  String? _firstNameError;
  bool showPhoneErrorContainer = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    allCourseListData();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  bool isVerifyingOTP = false;
  OtpScreenProvider otpScreenProvider = OtpScreenProvider();

  @override
  Widget build(BuildContext context) {
    final registerProvider = Provider.of<RegistrationProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.green,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.26, 0, 0, 0),
            child: Container(
              height: height * 0.10,
              width: width * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.logoFundamakers))),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.13,
              ),
              child: Container(
                height: height * 0.9,
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.themeWhiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width * 0.3))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.72),
                      child: Text(
                        'नमस्ते',
                        style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                              color: AppColors.lastButtonColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 25),
                        ),
                      ),
                    ),
                    Text(
                      'Welcome to FundaMakers Community. Enter your\nmobile number to register with us.',
                      style: GoogleFonts.robotoCondensed(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    showPhoneErrorContainer == false
                        ? Consumer<RegistrationProvider>(
                            builder: (context, registerProvider, child) {
                              return Visibility(
                                visible: registerProvider.errorMessage != null
                                    ? _isVisible
                                    : false,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: height * 0.05,
                                  width: width,
                                  color: AppColors.lastButtonColor,
                                  child: Text(
                                    registerProvider.errorMessage ??
                                        'Registration failed',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(),
                    SizedBox(
                      width: width * 0.87,
                      child: TextField(
                        controller: mobileNumber,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          counter: const Offstage(),
                          prefixIcon: const Icon(Icons.phone_android_outlined,
                              size: 20),
                          hintStyle: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                          hintText: 'Mobile Number',
                          border: const OutlineInputBorder(),
                          errorText: _phoneError,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: _firstNameError != null
                              ? height * 0.08
                              : height * 0.06,
                          width: width * 0.4,
                          child: TextField(
                            controller: firstNameCon,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.person_outline, size: 20),
                              hintStyle: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                              hintText: 'First Name',
                              border: const OutlineInputBorder(),
                              errorText: _firstNameError,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                          width: width * 0.4,
                          child: TextField(
                            controller: lastNameCon,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline, size: 20),
                              hintStyle: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                              hintText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        isLoading
                            ? const CircularProgressIndicator()
                            : list.isNotEmpty
                                ? DropdownMenu<String>(
                                    enabled: true,
                                    width: width * 0.4,
                                    leadingIcon: list.isNotEmpty
                                        ? const Icon(
                                            Icons.import_contacts_sharp)
                                        : const Icon(
                                            Icons.import_contacts_sharp),
                                    trailingIcon: list.isNotEmpty
                                        ? const Icon(
                                            Icons.keyboard_arrow_down_sharp)
                                        : const Icon(
                                            Icons.keyboard_arrow_down_sharp),
                                    initialSelection: list.isNotEmpty
                                        ? list.first.name ?? ''
                                        : '',
                                    onSelected: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          dropdownValue = newValue;
                                          CourseModel selectedCourse =
                                              list.firstWhere((element) =>
                                                  element.name ==
                                                  dropdownValue);
                                          allSubCourseListData(
                                              selectedCourse.id.toString());
                                        });
                                      }
                                    },
                                    dropdownMenuEntries: list
                                        .map<DropdownMenuEntry<String>>(
                                            (CourseModel course) {
                                      return DropdownMenuEntry<String>(
                                        value: course.name ?? 'CAT',
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                        label: course.name ?? 'CAT',
                                      );
                                    }).toList(),
                                  )
                                : DropdownMenu<String>(
                                    enabled: true,
                                    width: width * 0.4,
                                    leadingIcon: list.isNotEmpty
                                        ? const Icon(
                                            Icons.import_contacts_sharp)
                                        : const Icon(
                                            Icons.import_contacts_sharp),
                                    trailingIcon: list.isNotEmpty
                                        ? const Icon(
                                            Icons.keyboard_arrow_down_sharp)
                                        : const Icon(
                                            Icons.keyboard_arrow_down_sharp),
                                    initialSelection: list.isNotEmpty
                                        ? list.first.name ?? ''
                                        : '',
                                    onSelected: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          dropdownValue = newValue;
                                        });
                                      }
                                    },
                                    dropdownMenuEntries: list
                                        .map<DropdownMenuEntry<String>>(
                                            (CourseModel course) {
                                      return DropdownMenuEntry<String>(
                                        value: course.name ?? 'CAT',
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                        label: course.name ?? 'CAT',
                                      );
                                    }).toList(),
                                  ),
                        if (listTwo.isNotEmpty)
                          DropdownMenu<String>(
                            enabled: true,
                            width: width * 0.4,
                            leadingIcon:
                                const Icon(Icons.import_contacts_sharp),
                            trailingIcon:
                                const Icon(Icons.keyboard_arrow_down_sharp),
                            initialSelection: listTwo.isNotEmpty
                                ? listTwo.first.name ?? ''
                                : '',
                            onSelected: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  dropdownValueTwo = newValue;
                                });
                              }
                            },
                            dropdownMenuEntries: listTwo
                                .map<DropdownMenuEntry<String>>(
                                    (SubCourseModel subCourse) {
                              return DropdownMenuEntry<String>(
                                value: subCourse.name ?? '',
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                ),
                                label: subCourse.name ?? '',
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    SizedBox(
                      height:
                          _emailError != null ? height * 0.09 : height * 0.06,
                      width: width * 0.87,
                      child: TextField(
                        controller: emailCon,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail, size: 20),
                          hintStyle: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                          hintText: 'Email Address',
                          border: const OutlineInputBorder(),
                          errorText: _emailError,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    AppBtn(
                      width: width * 0.85,
                      onTap: () {
                        if (mobileNumber.text.isEmpty ||
                            mobileNumber.text.length != 10) {
                          setState(() {
                            _phoneError =
                                'The mobile number field is required.';
                            _emailError = null;
                            _firstNameError = null;
                            showPhoneErrorContainer = false;
                          });
                        } else if (firstNameCon.text.isEmpty) {
                          setState(() {
                            _firstNameError =
                                'The first name field is required.';
                            _emailError = null;
                            showPhoneErrorContainer = false;
                          });
                        } else {
                          registerProvider.userRegister(
                            context,
                            emailCon.text,
                            firstNameCon.text,
                            mobileNumber.text,
                            list.isNotEmpty ? list.first.id.toString() : '',
                            listTwo.isNotEmpty
                                ? listTwo.first.id.toString()
                                : '',
                            lastNameCon.text,
                          );
                        }
                      },
                      title: 'Register',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
