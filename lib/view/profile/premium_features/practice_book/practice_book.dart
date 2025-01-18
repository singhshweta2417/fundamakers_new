import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/premium_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PracticeBookScreen extends StatefulWidget {
  const PracticeBookScreen({Key? key}) : super(key: key);

  @override
  State<PracticeBookScreen> createState() => _PracticeBookScreenState();
}

class _PracticeBookScreenState extends State<PracticeBookScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final practiceBookView =
          Provider.of<PremiumViewModel>(context, listen: false);
      practiceBookView.practiceBookApi(context);
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
        body: Consumer<PremiumViewModel>(builder: (context, value, _) {
          switch (value.practiceBookResponse.success) {
            case Success.LOADING:
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
            case Success.COMPLETED:
              if (value.practiceBookResponse.data != null &&
                  value.practiceBookResponse.data!.data != null &&
                  value.practiceBookResponse.data!.data!.isNotEmpty) {
                final practiceBookList = value.practiceBookResponse.data!.data!;
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
                      itemCount: practiceBookList.length,
                      itemBuilder: (context, index) {
                        final pdfLink =
                            '${practiceBookList[index].host}${practiceBookList[index].filePath}${practiceBookList[index].fileName}';
                        return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RoutesName.pDFViewScreen,
                                  arguments: {'urlLink': pdfLink});
                            },
                            child: listContainer(
                                child: Row(
                              children: [
                                SizedBox(
                                  height: height * 0.07,
                                  child: const Image(
                                      image:
                                          AssetImage(Assets.imagesCommunity)),
                                ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                                SizedBox(
                                  width: width * 0.45,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textWidget(
                                          text: practiceBookList[index]
                                              .name
                                              .toString(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimensions.thirteen),
                                      SizedBox(
                                          height: height * 0.03,
                                          child: textWidget(
                                              onTap: () async {
                                                if (await canLaunchUrl(
                                                    Uri.parse(pdfLink))) {
                                                  await launchUrl(
                                                      Uri.parse(pdfLink));
                                                } else {
                                                  throw 'Could not launch $pdfLink';
                                                }
                                              },
                                              text: 'download.pdf',
                                              color: Colors.blueAccent,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: Dimensions.fifteen)),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            initialRating: 5,
                                            // double.parse(editReviewItems!.rating.toString()),
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 20.0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (double value) {
                                              // updatePublishedUserProvider.updatePublishedReview(
                                              //     context,
                                              //     editReviewItems.id.toString(),
                                              //     value.toString(),
                                              //     editReviewItems.discription.toString());
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios),
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
