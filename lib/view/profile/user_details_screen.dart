import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/models/course/sub_course_model.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/components/app_btn.dart';
import 'package:fundamakers/res/custom_text_field.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/view_model/course_view_model.dart';
import 'package:fundamakers/view_model/user_details_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool isLoading = false;

  String dropdownValue = '';
  String dropdownValueTwo = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //subCoursesApi
      final coursesView = Provider.of<CoursesViewModel>(context, listen: false);
      coursesView.coursesApi(context);

      final viewProfile =
          Provider.of<UserDetailViewModel>(context, listen: false);
      viewProfile.getUserDetailsApi(context);
      setData();
    });
  }

  setSubCourse(String courseId) {
    final subCoursesView =
        Provider.of<CoursesViewModel>(context, listen: false);
    subCoursesView.subCoursesApi(courseId, context);
  }

  setData() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final viewProfile =
          Provider.of<UserDetailViewModel>(context, listen: false);
      if (viewProfile.userDetailsResponse?.data != null) {
        firstNameCon.text =
            viewProfile.userDetailsResponse!.data!.firstName.toString();
        lastNameCon.text =
            viewProfile.userDetailsResponse!.data!.lastName.toString();
        whatsAppNumberCon.text =
            viewProfile.userDetailsResponse!.data!.mobileNumber.toString();
      }
    });
  }

  TextEditingController firstNameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController whatsAppNumberCon = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  String? base64Image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      base64Image = base64Encode(_image!.readAsBytesSync());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userDetailUpdate = Provider.of<UserDetailViewModel>(context);
    final subCoursesView =
        Provider.of<CoursesViewModel>(context).subCourseResponse?.data;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SpaceHeight.getZeroTwo(context),
            Center(
              child: Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(_image!),
                        )
                      : const CircleAvatar(
                          backgroundImage: AssetImage(Assets.imagesProfile),
                          radius: 70,
                        ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: InkWell(
                        onTap: () {
                          _settingModalBottomSheet(context);
                        },
                        child: Container(
                            height: 45,
                            width: 45,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.gradientFirstColor,
                                    AppColors.gradientSecondColor
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30)),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            )),
                      ))
                ],
              ),
            ),
            SpaceHeight.getZeroFive(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.43,
                  child: customTextFormField(
                      controller: firstNameCon,
                      keyboardType: TextInputType.name,
                      hintText: 'First Name',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        size: 20,
                      ),
                      fieldRadius: BorderRadius.circular(3)),
                ),
                SizedBox(
                  width: width * 0.43,
                  child: customTextFormField(
                      controller: lastNameCon,
                      keyboardType: TextInputType.name,
                      hintText: 'Last Name',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        size: 20,
                      ),
                      fieldRadius: BorderRadius.circular(3)),
                ),
              ],
            ),
            SpaceHeight.getZeroTwo(context),
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
                          leadingIcon: const Icon(Icons.import_contacts_sharp),
                          trailingIcon:
                              const Icon(Icons.keyboard_arrow_down_sharp),
                          initialSelection: (coursesView.isNotEmpty)
                              ? (coursesView.first.name ?? 'CAT')
                              : 'CAT',
                          onSelected: (String? newValue) {
                            if (newValue != null) {
                              if (coursesView.isNotEmpty) {
                                setState(() {
                                  dropdownValue = newValue;
                                  CourseData selectedCourse =
                                      coursesView.firstWhere(
                                    (element) => element.name == dropdownValue,
                                    orElse: () =>
                                        CourseData(id: 0, name: 'CAT'),
                                  );
                                  setSubCourse(selectedCourse.id.toString());
                                });
                              }
                            }
                          },
                          dropdownMenuEntries: (coursesView.isNotEmpty)
                              ? coursesView.map<DropdownMenuEntry<String>>(
                                  (CourseData course) {
                                  return DropdownMenuEntry<String>(
                                    value: course.name ?? 'CAT',
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all<
                                          EdgeInsetsGeometry>(EdgeInsets.zero),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    label: course.name ?? 'CAT',
                                  );
                                }).toList()
                              : [],
                        ),
                        DropdownMenu<String>(
                          enabled: true,
                          width: width * 0.435,
                          leadingIcon: const Icon(Icons.import_contacts_sharp),
                          trailingIcon:
                              const Icon(Icons.keyboard_arrow_down_sharp),
                          initialSelection: (subCoursesView != null &&
                                  subCoursesView.isNotEmpty)
                              ? (subCoursesView.first.name ?? '')
                              : 'CAT 23',
                          onSelected: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                dropdownValueTwo = newValue;
                              });
                            }
                          },
                          dropdownMenuEntries: (subCoursesView != null &&
                                  subCoursesView.isNotEmpty)
                              ? subCoursesView.map<DropdownMenuEntry<String>>(
                                  (SubCourseData subCourse) {
                                  return DropdownMenuEntry<String>(
                                    value: subCourse.name ?? '',
                                    style: ButtonStyle(
                                      padding: WidgetStateProperty.all<
                                          EdgeInsetsGeometry>(EdgeInsets.zero),
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                        Colors.white,
                                      ),
                                    ),
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
            customTextFormField(
                controller: emailCon,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email Address',
                prefixIcon: const Icon(
                  Icons.mail,
                  size: 20,
                ),
                fieldRadius: BorderRadius.circular(3)),
            SpaceHeight.getZeroTwo(context),
            customTextFormField(
                controller: whatsAppNumberCon,
                keyboardType: TextInputType.phone,
                hintText: 'WhatsApp Number',
                prefixIcon: const Icon(
                  Icons.phone_android_outlined,
                  size: 20,
                ),
                fieldRadius: BorderRadius.circular(3)),
            SpaceHeight.getZeroFive(context),
            AppBtn(
              loading: userDetailUpdate.userDetailLoading,
              onTap: () {
                userDetailUpdate.userDetailLoading
                    ? null
                    : userDetailUpdate.userDetailsApi(
                        firstNameCon.text.toString(),
                        lastNameCon.text.toString(),
                        context);
              },
              title: 'Submit',
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    final heights = MediaQuery.of(context).size.height;
    final widths = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
            height: heights / 7,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  widths / 12, 0, widths / 12, heights / 60),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _getImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                          // color: Colors.blue,
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.gradientFirstColor,
                              AppColors.gradientSecondColor
                            ],
                          ),
                          border: Border.all(
                              color: AppColors.themeWhiteColor, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'Camera',
                        style: TextStyle(color: AppColors.themeWhiteColor),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _getImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: heights / 20,
                      width: widths / 2.7,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.gradientFirstColor,
                              AppColors.gradientSecondColor
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
