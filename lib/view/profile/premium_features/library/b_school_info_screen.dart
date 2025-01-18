import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/library/b_school_info_model.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/premium_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BSchoolInfoScreen extends StatefulWidget {
  const BSchoolInfoScreen({super.key});

  @override
  State<BSchoolInfoScreen> createState() => _BSchoolInfoScreenState();
}

class _BSchoolInfoScreenState extends State<BSchoolInfoScreen> {
  List<BSchoolInfoModel> bSchoolInfoList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bSchoolInfoView =
          Provider.of<PremiumViewModel>(context, listen: false);
      bSchoolInfoView.bSchoolInfoApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final title = args?['title'];
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
        body: Consumer<PremiumViewModel>(builder: (context, value, _) {
          switch (value.bSchoolInfoResponse.success) {
            case Success.LOADING:
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
            case Success.COMPLETED:
              if (value.bSchoolInfoResponse.data != null &&
                  value.bSchoolInfoResponse.data!.data != null &&
                  value.bSchoolInfoResponse.data!.data!.isNotEmpty) {
                final bSchoolInfoList = value.bSchoolInfoResponse.data!.data!;
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
                      itemCount: bSchoolInfoList.length,
                      itemBuilder: (context, index) {
                        final pdfUrl ='${bSchoolInfoList[index].host}${bSchoolInfoList[index].filePath}${bSchoolInfoList[index].uniqueName}';
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, RoutesName.pDFViewScreen,arguments: {
                              'urlLink':pdfUrl
                            });
                          },
                          child: listContainer(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: height * 0.07,
                                child: const Icon(Icons.download,
                                    size: 30, color: AppColors.themeGreenColor),
                              ),
                              SizedBox(width: width * 0.05),
                              SizedBox(
                                width: width*0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textWidget(
                                        text: bSchoolInfoList[index]
                                            .description
                                            .toString(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: Dimensions.thirteen,maxLines: 3),
                                    SizedBox(
                                      height: height*0.03,
                                      child:  textWidget(
                                          onTap:() async {
                                            if (await canLaunchUrl(
                                                Uri.parse(pdfUrl))) {
                                              await launchUrl(Uri.parse(pdfUrl));
                                            } else {
                                              throw 'Could not launch $pdfUrl';
                                            }
                                          },
                                          text: 'download.pdf',
                                          color: Colors.blueAccent,
                                          decoration: TextDecoration.underline,
                                          fontSize: Dimensions.fifteen)
                                    ),

                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_sharp)
                            ],
                          )),
                        );
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
