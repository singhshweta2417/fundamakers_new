import 'package:flutter/material.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/models/course/sub_course_model.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/custom_text_field.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/view_model/auth_view_model.dart';
import 'package:fundamakers/view_model/course_view_model.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  bool isOtpVerified = false;

  String dropdownValue = '';
  String dropdownValueTwo = '';

  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController otpCon = TextEditingController();

  bool isPhoneValid = false;
  bool isOtpValid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //subCoursesApi
      final coursesView = Provider.of<CoursesViewModel>(context, listen: false);
      coursesView.coursesApi(context);
      if (coursesView.coursesResponse.data != null &&
          coursesView.coursesResponse.data!.data!.isNotEmpty) {
        final firstCourse = coursesView.coursesResponse.data!.data!.first;
        setSubCourse(firstCourse.id.toString());
      }
    });
    mobileNumber.addListener(() {
      setState(() {
        isPhoneValid = mobileNumber.text.length == 10;
      });
    });
    otpCon.addListener(() {
      setState(() {
        isOtpValid = otpCon.text.length == 4;
      });
    });
  }

  setSubCourse(String courseId) {
    final subCoursesView =
        Provider.of<CoursesViewModel>(context, listen: false);
    subCoursesView.subCoursesApi(courseId, context);
  }

  @override
  Widget build(BuildContext context) {
    final otpNewSent = Provider.of<AuthenticationViewModel>(context);
    final registerNew = Provider.of<AuthenticationViewModel>(context);
    final coursesView =
        Provider.of<CoursesViewModel>(context).coursesResponse.data?.data;
    final subCoursesView =
        Provider.of<CoursesViewModel>(context).subCourseResponse?.data;
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
                SpaceHeight.getZeroTwo(context),
                textWidget(
                    text:
                        'Welcome to FundaMakers Community.Enter your\nmobile number to register with us.',
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.sixteen),
                SizedBox(height: height * 0.02),
                if (isPhoneValid && !isOtpVerified)
                  textWidget(
                      text: 'Please Verify Your Number Firstly',
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.sixteen),
                customTextFormField(
                  readOnly: isOtpVerified,
                  controller: otpNewSent.setViewField ? otpCon : mobileNumber,
                  maxLength: otpNewSent.setViewField ? 4 : 10,
                  keyboardType: otpNewSent.setViewField
                      ? TextInputType.number
                      : TextInputType.phone,
                  hintText:
                      otpNewSent.setViewField ? 'Verify OTP' : 'Mobile Number',
                  prefixIcon:
                      const Icon(Icons.phone_android_outlined, size: 20),
                  errorText: otpNewSent.setViewField
                      ? otpNewSent.verifyNewMessage
                      : otpNewSent.errorNewMessage,
                ),
                if (otpNewSent.setViewField)
                  TextButton(
                    onPressed: () {
                      otpNewSent.verifyNewOtpApi(
                          mobileNumber.text, otpCon.text, context);
                      setState(() {
                        isOtpVerified = true;
                      });
                    },
                    child: textWidget(
                      text: 'Verify OTP',
                      fontSize: Dimensions.fifteen,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gradientFirstColor,
                    ),
                  )
                else if (isPhoneValid && !isOtpVerified)
                  TextButton(
                    onPressed: () {
                      otpNewSent.otpNewSentApi(mobileNumber.text, context);
                    },
                    child: textWidget(
                      text: 'Send OTP',
                      fontSize: Dimensions.fifteen,
                      fontWeight: FontWeight.w600,
                      color: AppColors.gradientFirstColor,
                    ),
                  ),
                SpaceHeight.getZeroTwo(context),
                if (isOtpVerified)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.43,
                        child: customTextFormField(
                            controller: firstNameCon,
                            keyboardType: TextInputType.name,
                            prefixIcon:
                                const Icon(Icons.person_outline, size: 20),
                            hintText: 'First Name',
                            errorText: registerNew.regMessage?.isEmpty ?? true
                                ? null
                                : registerNew.regMessage),
                      ),
                      SizedBox(
                        width: width * 0.43,
                        child: customTextFormField(
                          controller: lastNameCon,
                          keyboardType: TextInputType.name,
                          prefixIcon:
                              const Icon(Icons.person_outline, size: 20),
                          hintText: 'Last Name',
                        ),
                      )
                    ],
                  ),
                SpaceHeight.getZeroTwo(context),
                if (isOtpVerified)
                  Consumer<CoursesViewModel>(builder: (context, value, _) {
                    switch (value.coursesResponse.success) {
                      case Success.LOADING:
                        return Container(
                          height: height * 0.3,
                          width: width,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      case Success.ERROR:
                        return Container();
                      case Success.COMPLETED:
                        if (value.coursesResponse.data != null &&
                            value.coursesResponse.data!.data != null &&
                            value.coursesResponse.data!.data!.isNotEmpty) {
                          final coursesView = value.coursesResponse.data!.data!;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownMenu<String>(
                                enabled: true,
                                width: width * 0.435,
                                leadingIcon:
                                    const Icon(Icons.import_contacts_sharp),
                                trailingIcon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                initialSelection: (coursesView.isNotEmpty)
                                    ? (coursesView.first.name ?? 'CAT')
                                    : 'CAT',
                                onSelected: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      dropdownValue = newValue;
                                      // Find the selected course and update subCoursesView
                                      CourseData selectedCourse =
                                          coursesView.firstWhere(
                                        (element) =>
                                            element.name == dropdownValue,
                                        orElse: () =>
                                            CourseData(id: 0, name: ''),
                                      );
                                      setSubCourse(
                                          selectedCourse.id.toString());
                                    });
                                  }
                                },
                                dropdownMenuEntries: (coursesView.isNotEmpty)
                                    ? coursesView
                                        .map<DropdownMenuEntry<String>>(
                                            (CourseData course) {
                                        return DropdownMenuEntry<String>(
                                          value: course.name ?? 'CAT',
                                          label: course.name ?? 'CAT',
                                        );
                                      }).toList()
                                    : [],
                              ),
                              DropdownMenu<String>(
                                enabled: true,
                                width: width * 0.435,
                                leadingIcon:
                                    const Icon(Icons.import_contacts_sharp),
                                trailingIcon:
                                    const Icon(Icons.keyboard_arrow_down_sharp),
                                initialSelection: (subCoursesView != null &&
                                        subCoursesView.isNotEmpty)
                                    ? (subCoursesView.first.name ?? '')
                                    : 'No Sub-Courses',
                                onSelected: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      dropdownValueTwo = newValue;
                                    });
                                  }
                                },
                                dropdownMenuEntries: (subCoursesView != null &&
                                        subCoursesView.isNotEmpty)
                                    ? subCoursesView
                                        .map<DropdownMenuEntry<String>>(
                                            (SubCourseData subCourse) {
                                        return DropdownMenuEntry<String>(
                                          value: subCourse.name ?? '',
                                          label: subCourse.name ?? '',
                                        );
                                      }).toList()
                                    : [],
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                    }
                  }),
                SpaceHeight.getZeroTwo(context),
                if (isOtpVerified)
                  TextField(
                    controller: emailCon,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.mail, size: 20),
                      hintStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      hintText: 'Email Address',
                      border: OutlineInputBorder(),
                      // errorText: _emailError,
                    ),
                  ),
                SpaceHeight.getZeroTwo(context),
                if (isOtpVerified)
                  AppBtn(
                    loading: registerNew.regLoading,
                    onTap: () {
                      registerNew.regLoading
                          ? null
                          : registerNew.registerApi(
                              emailCon.text,
                              firstNameCon.text,
                              mobileNumber.text,
                              coursesView!.isNotEmpty
                                  ? coursesView.first.id.toString()
                                  : '',
                              subCoursesView!.isNotEmpty
                                  ? subCoursesView.first.id.toString()
                                  : '',
                              lastNameCon.text,
                              context);
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
