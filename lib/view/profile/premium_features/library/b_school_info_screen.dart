import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/library/b_school_info_model.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
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
    final width = MediaQuery.of(context).size.width;
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
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: bSchoolInfoList.length,
                  itemBuilder: (context, index) {
                    return listContainer(
                        child: Row(
                      children: [
                        SizedBox(
                            height: height * 0.07,
                            child: IconButton(
                              onPressed: () async {
                                const pdfUrl =
                                    'https://online.fundamakers.com/content/b9d2b5a165327713960ec0f9117df628.pdf';
                                if (await canLaunchUrl(Uri.parse(pdfUrl))) {
                                  await launchUrl(Uri.parse(pdfUrl));
                                } else {
                                  throw 'Could not launch $pdfUrl';
                                }
                              },
                              icon: const Icon(Icons.download,
                                  size: 30, color: AppColors.themeGreenColor),
                            )),
                        SizedBox(width: width * 0.02),
                        SizedBox(
                          width: width * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidget(
                                  text: bSchoolInfoList[index]
                                      .fileName
                                      .toString(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimensions.thirteen),
                              textWidget(
                                  text: bSchoolInfoList[index]
                                      .description
                                      .toString(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimensions.thirteen,
                                  maxLines: 1),
                              textWidget(
                                  text: bSchoolInfoList[index]
                                      .uniqueName
                                      .toString(),
                                  fontWeight: FontWeight.w300,
                                  fontSize: Dimensions.thirteen),
                            ],
                          ),
                        ),
                      ],
                    ));
                  },
                );
              } else {
                return noDataAvailable();
              }
          }
        }));
  }
}
