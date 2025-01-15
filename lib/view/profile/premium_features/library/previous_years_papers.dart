import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/view_model/premium_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousYearsPaperScreen extends StatefulWidget {
  const PreviousYearsPaperScreen({super.key});

  @override
  State<PreviousYearsPaperScreen> createState() =>
      _PreviousYearsPaperScreenState();
}

class _PreviousYearsPaperScreenState extends State<PreviousYearsPaperScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final previousYearPaperView =
          Provider.of<PremiumViewModel>(context, listen: false);
      previousYearPaperView.previousYearPaperApi(context);
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
          switch (value.previousYearPaperResponse.success) {
            case Success.LOADING:
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
            case Success.COMPLETED:
              if (value.previousYearPaperResponse.data != null &&
                  value.previousYearPaperResponse.data!.data != null &&
                  value.previousYearPaperResponse.data!.data!.isNotEmpty) {
                final previousYearList =
                    value.previousYearPaperResponse.data!.data!;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: height * 0.05,
                      child: textWidget(
                          text: '  $title',
                          fontSize: Dimensions.twenty,
                          fontWeight: FontWeight.w700),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: previousYearList.length,
                      itemBuilder: (context, index) {
                        return listContainer(
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
                              width: width * 0.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget(
                                      text: previousYearList[index]
                                          .fileName
                                          .toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.thirteen),
                                  textWidget(
                                      text: previousYearList[index]
                                          .description
                                          .toString(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.thirteen,
                                      maxLines: 1),
                                  SizedBox(
                                      height: height * 0.03,
                                      child: textWidget(
                                          onTap: () async {
                                            const pdfUrl =
                                                'https://online.fundamakers.com/content/b9d2b5a165327713960ec0f9117df628.pdf';
                                            if (await canLaunchUrl(
                                                Uri.parse(pdfUrl))) {
                                              await launchUrl(
                                                  Uri.parse(pdfUrl));
                                            } else {
                                              throw 'Could not launch $pdfUrl';
                                            }
                                          },
                                          text: 'download.pdf',
                                          color: Colors.blueAccent,
                                          decoration: TextDecoration.underline,
                                          fontSize: Dimensions.fifteen)),
                                ],
                              ),
                            ),
                          ],
                        ));
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
