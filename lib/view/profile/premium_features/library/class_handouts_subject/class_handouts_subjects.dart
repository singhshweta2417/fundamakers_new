import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/subject_view_model.dart';
import 'package:provider/provider.dart';

class ClassHandOutsSubjectsScreen extends StatefulWidget {
  const ClassHandOutsSubjectsScreen({Key? key}) : super(key: key);

  @override
  State<ClassHandOutsSubjectsScreen> createState() =>
      _ClassHandOutsSubjectsScreenState();
}

class _ClassHandOutsSubjectsScreenState
    extends State<ClassHandOutsSubjectsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final subjectView = Provider.of<SubjectViewModel>(context, listen: false);
      subjectView.subjectApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String? title = args['title'];
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
        body: Consumer<SubjectViewModel>(builder: (context, value, _) {
          switch (value.subjectResponse.success) {
            case Success.LOADING:
              return Container(
                height: height * 0.3,
                width: width,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            case Success.ERROR:
              return Container(
                height: height * 0.3,
                width: width,
                alignment: Alignment.center,
                child: const Image(image: AssetImage(Assets.imagesNoData)),
              );
            case Success.COMPLETED:
              if (value.subjectResponse.data != null &&
                  value.subjectResponse.data!.data != null &&
                  value.subjectResponse.data!.data!.isNotEmpty) {
                final subjectView = value.subjectResponse.data!.data!;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: height * 0.06,
                      width: width * 0.3,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textWidget(
                              text: title.toString(),
                              fontSize: Dimensions.eighteen,
                              fontWeight: FontWeight.w600),
                          const Image(
                            image: AssetImage(Assets.imagesArrowPng),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: subjectView.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutesName.classHandOutsScreen,arguments: {
                                  'title':subjectView[index].name.toString()
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03, vertical: height * 0.02),
                            margin: EdgeInsets.symmetric(
                                horizontal: width * 0.05, vertical: height * 0.01),
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
                                  height: height * 0.07,
                                  child: Image(
                                    image: subjectView[index].image != null
                                        ? AssetImage(
                                            subjectView[index].image.toString())
                                        : const AssetImage(Assets.imagesCommunity),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.45,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                          text: subjectView[index].name.toString(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimensions.thirteen),
                                      textWidget(
                                          text: 'Ques: 10/10',
                                          fontWeight: FontWeight.w500,
                                          fontSize: Dimensions.thirteen),
                                      textWidget(
                                          text: subjectView[index]
                                              .description
                                              .toString(),
                                          fontWeight: FontWeight.w300,
                                          fontSize: Dimensions.thirteen),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Container(
                      height: height * 0.5,
                      width: width,
                      alignment: Alignment.center,
                      child:
                          const Image(image: AssetImage(Assets.imagesNoData)),
                    ),
                    textWidget(text: 'No Data Available')
                  ],
                );
              }
          }
        }));
  }
}
