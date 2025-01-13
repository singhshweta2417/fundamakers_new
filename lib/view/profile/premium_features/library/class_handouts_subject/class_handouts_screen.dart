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

class ClassHandOutsScreen extends StatefulWidget {
  const ClassHandOutsScreen({Key? key}) : super(key: key);

  @override
  State<ClassHandOutsScreen> createState() => _ClassHandOutsScreenState();
}

class _ClassHandOutsScreenState extends State<ClassHandOutsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final classHangOutsView =
          Provider.of<PremiumViewModel>(context, listen: false);
      classHangOutsView.classHandOutApi(context);
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
          switch (value.classHandoutsResponse.success) {
            case Success.LOADING:
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
            case Success.COMPLETED:
              if (value.classHandoutsResponse.data != null &&
                  value.classHandoutsResponse.data!.data != null &&
                  value.classHandoutsResponse.data!.data!.isNotEmpty) {
                final classHangOutsList =
                    value.classHandoutsResponse.data!.data!;
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: classHangOutsList.length,
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
                        SizedBox(width: width*0.03,),
                        SizedBox(
                          width: width * 0.45,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textWidget(
                                  text: classHangOutsList[index]
                                      .fileName
                                      .toString(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimensions.thirteen),
                              textWidget(
                                text: classHangOutsList[index]
                                    .description
                                    .toString(),
                                fontWeight: FontWeight.w500,
                                fontSize: Dimensions.twelve,
                                maxLines: 1,
                              ),
                              textWidget(
                                text: classHangOutsList[index]
                                    .uniqueName
                                    .toString(),
                                fontWeight: FontWeight.w300,
                                fontSize: Dimensions.twelve,
                              ),
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
