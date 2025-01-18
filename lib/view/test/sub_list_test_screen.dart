import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/subject_view_model.dart';
import 'package:provider/provider.dart';

class SubListTestMenu extends StatefulWidget {
  const SubListTestMenu({Key? key}) : super(key: key);

  @override
  State<SubListTestMenu> createState() => _SubListTestMenuState();
}

class _SubListTestMenuState extends State<SubListTestMenu> {
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
    final args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'];
    final testId = args?['testId'];
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
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
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
                              Navigator.pushNamed(context, RoutesName.mainTestList,arguments: {
                                'title':subjectView[index].name,
                                'testId':testId.toString()
                              });
                            },
                            child: listContainer(
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
                            )));
                      },
                    ),
                  ],
                );
              } else {
                return noDataAvailable();
              }
          }
        }));
  }
}
