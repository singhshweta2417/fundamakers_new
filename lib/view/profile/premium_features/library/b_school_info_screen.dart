import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/models/library/b_school_info_model.dart';
import 'package:fundamakers/providers/premium_features/b_school_info_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class BSchoolInfoScreen extends StatefulWidget {
  const BSchoolInfoScreen({super.key});

  @override
  State<BSchoolInfoScreen> createState() => _BSchoolInfoScreenState();
}

class _BSchoolInfoScreenState extends State<BSchoolInfoScreen> {

  BSchoolInfoProvider bSchoolInfoProvider= BSchoolInfoProvider();

  List<BSchoolInfoModel> bSchoolInfoList = [];
  bool isLoading = false;

  Future<void> allBSchoolInfoData() async {
    bSchoolInfoList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<BSchoolInfoModel> reviewsList = await bSchoolInfoProvider.fetchBSchoolInfoData();
      setState(() {
        bSchoolInfoList = reviewsList;
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
    @override
  void initState() {
      allBSchoolInfoData();
      super.initState();
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
      body: LayoutBuilder(
          builder:  (BuildContext context, BoxConstraints constraints)  {
            double containerWidth = constraints.maxWidth;
            double containerHeight = constraints.maxHeight;
            return
              bSchoolInfoList.isEmpty?const Center(
                child: CircularProgressIndicator(
                  color: AppColors.themeGreenColor,
                ),
              ):
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: bSchoolInfoList.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(
                        horizontal: containerWidth * 0.05, vertical: 20),
                    height: containerHeight * 0.15,
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
                            height: containerHeight * 0.09,
                            width: containerWidth * (width > 600 ? 0.2 : 0.3),
                            child:IconButton(
                              onPressed: () async {
                                const pdfUrl = 'https://online.fundamakers.com/content/b9d2b5a165327713960ec0f9117df628.pdf';
                                if (await canLaunchUrl(Uri.parse(pdfUrl))) {
                                  await launchUrl(Uri.parse(pdfUrl));
                                } else {
                                  throw 'Could not launch $pdfUrl';
                                }
                              },
                              icon: const Icon(Icons.download, size: 30, color: AppColors.themeGreenColor),
                            )
                        ),
                        SizedBox(
                          width: containerWidth * (width > 600 ? 0.2 : 0.45),
                          height: containerHeight * 0.09,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bSchoolInfoList[index].fileName.toString(),
                                style: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Text(
                                bSchoolInfoList[index].description.toString(),
                                style: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                bSchoolInfoList[index].uniqueName.toString(),
                                style: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                  ),
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: width*0.02,)
                      ],
                    ),
                  );
                },
              );
          }
      ),
    );
  }
}
