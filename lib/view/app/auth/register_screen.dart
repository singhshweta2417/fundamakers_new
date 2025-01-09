import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/models/course/sub_course_model.dart';
import 'package:fundamakers/providers/auth/new_register_provider.dart';
import 'package:fundamakers/providers/auth/otp_screen_new.dart';
import 'package:fundamakers/providers/course/course_provider.dart';
import 'package:fundamakers/providers/course/sub_course_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/custom_text_field.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        print('Error fetching subjects data: $e');
      }
    }
  }

  CourseProvider subjectProvider = CourseProvider();

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
        print('Error fetching subjects data: $e');
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
  TextEditingController otpCon = TextEditingController();

  late Timer _timer;
  String? _emailError;
  String? _firstNameError;
  bool isPhoneValid = false;
  bool isOtpValid = false;
  @override
  void initState() {
    super.initState();
    _startTimer();
    allCourseListData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OtpScreenNewProvider>(context, listen: false).clear();
    });
    mobileNumber.addListener(() {
      setState(() {
        isPhoneValid = mobileNumber.text.length == 10;
      });
    });
    otpCon.addListener(() {
      setState(() {
        isOtpValid = otpCon.text.length == 10;
      });
    });
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  OtpScreenNewProvider otpScreenNewProvider = OtpScreenNewProvider();

  @override
  Widget build(BuildContext context) {
    final otpScreenNewProvider = Provider.of<OtpScreenNewProvider>(context);
    final registerNewProvider = Provider.of<RegistrationNewProvider>(context);
    return Scaffold(
      backgroundColor: Colors.green,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          logoContainer(),
          paddingContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    text: 'नमस्ते',
                    color: AppColors.lastButtonColor,
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.twentyFour),
                SizedBox(
                  height: height * 0.01,
                ),
                textWidget(
                    text:
                        'Welcome to FundaMakers Community.Enter your\nmobile number to register with us.',
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.sixteen),
                SizedBox(height: height * 0.02),
                otpScreenNewProvider.randomBool
                    ? const Text('')
                    : textWidget(
                        text: 'Please Verify Your Number Firstly',
                        fontWeight: FontWeight.w500,
                        fontSize: Dimensions.sixteen),
                otpScreenNewProvider.randomBool
                    ? CustomTextField(
                        controller: otpCon,
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        hintText: 'Verify Otp',
                      )
                    : CustomTextField(
                        readOnly: otpScreenNewProvider.randomBool,
                        controller: mobileNumber,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        hintText: 'Mobile Number',
                        prefixIcon:
                            const Icon(Icons.phone_android_outlined, size: 20),
                      ),

                if (isPhoneValid)
                  TextButton(
                    onPressed: () {
                      otpScreenNewProvider.sendOtpNewPhone(
                          context, mobileNumber.text);
                      isPhoneValid=false;
                    },
                    child:
                        const Text('Send OTP', style: TextStyle(fontSize: 15)),
                  )
                else if (isOtpValid)
                  TextButton(
                    onPressed: () {
                      otpScreenNewProvider.verifyNewOtp(
                          context, mobileNumber.text, otpCon.text);
                    },
                    child: const Text('Verify OTP',
                        style: TextStyle(fontSize: 15)),
                  )
                else
                  Container(),
                SizedBox(height: height * 0.02),
                if (otpScreenNewProvider.verifyLoading == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        width: width * 0.43,
                        controller: firstNameCon,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.person_outline, size: 20),
                        hintText: 'First Name',
                        errorText: _firstNameError,
                      ),
                      CustomTextField(
                        width: width * 0.43,
                        controller: lastNameCon,
                        keyboardType: TextInputType.name,
                        prefixIcon: const Icon(Icons.person_outline, size: 20),
                        hintText: 'Last Name',
                      )
                    ],
                  ),
                SizedBox(height: height * 0.02),
                if (otpScreenNewProvider.verifyLoading == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownMenu<String>(
                        enabled: true,
                        width: kIsWeb ? width * 0.15 : width * 0.43,
                        leadingIcon: const Icon(Icons.import_contacts_sharp),
                        trailingIcon:
                            const Icon(Icons.keyboard_arrow_down_sharp),
                        initialSelection:
                            list.isNotEmpty ? list.first.name ?? '' : '',
                        onSelected: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              dropdownValue = newValue;
                              CourseModel selectedCourse = list.firstWhere(
                                  (element) => element.name == dropdownValue);
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
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.zero),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.white,
                              ),
                            ),
                            label: course.name ?? 'CAT',
                          );
                        }).toList(),
                      ),
                      DropdownMenu<String>(
                        enabled: true,
                        width: kIsWeb ? width * 0.15 : width * 0.43,
                        leadingIcon: const Icon(Icons.import_contacts_sharp),
                        trailingIcon:
                            const Icon(Icons.keyboard_arrow_down_sharp),
                        initialSelection:
                            listTwo.isNotEmpty ? listTwo.first.name ?? '' : '',
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
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                      EdgeInsets.zero),
                              backgroundColor: WidgetStateProperty.all<Color>(
                                Colors.white,
                              ),
                            ),
                            label: subCourse.name ?? '',
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                SizedBox(height: height * 0.02),
                if (otpScreenNewProvider.verifyLoading == true)
                  SizedBox(
                    height: _emailError != null ? height * 0.09 : height * 0.06,
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
                SizedBox(height: height * 0.02),
                if (otpScreenNewProvider.verifyLoading == true)
                  AppBtn(
                    loading: registerNewProvider.loading,
                    onTap: () {
                      if (mobileNumber.text.isEmpty &&
                          mobileNumber.text.length != 10) {
                        setState(() {});
                      } else if (firstNameCon.text.isEmpty) {
                        setState(() {
                          _firstNameError = 'The first name field is required.';
                          _emailError = null;
                        });
                      } else if (emailCon.text.isEmpty) {
                        setState(() {
                          _emailError = 'Please fill this field';
                          _firstNameError = null;
                        });
                      } else {
                        registerNewProvider.userNewRegister(
                          context,
                          emailCon.text,
                          firstNameCon.text,
                          mobileNumber.text,
                          list.isNotEmpty ? list.first.id.toString() : '',
                          listTwo.isNotEmpty ? listTwo.first.id.toString() : '',
                          lastNameCon.text,
                        );
                      }
                    },
                    title: 'Register',
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
