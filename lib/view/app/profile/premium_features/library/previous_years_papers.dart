import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/models/library/previous_years_papers_model.dart';
import 'package:fundamakers/providers/premium_features/previous_years_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class PreviousYearsPaperScreen extends StatefulWidget {
  const PreviousYearsPaperScreen({super.key});

  @override
  State<PreviousYearsPaperScreen> createState() => _PreviousYearsPaperScreenState();
}

class _PreviousYearsPaperScreenState extends State<PreviousYearsPaperScreen> {


  PreviousYearProvider previousYearProvider = PreviousYearProvider();

  List<PreviousYearModel> previousYearList = [];
  bool isLoading = false;

  Future<void> allPreviousYearData() async {
    previousYearList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<PreviousYearModel> reviewsList = await previousYearProvider.fetchPreviousYearData();
      setState(() {
        previousYearList = reviewsList;
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
    super.initState();
    allPreviousYearData();
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
              previousYearList.isEmpty?const Center(
                child: CircularProgressIndicator(
                  color: AppColors.themeGreenColor,
                ),
              ):
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: previousYearList.length,
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
                                if (await canLaunch(pdfUrl)) {
                                  await launch(pdfUrl);
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
                                previousYearList[index].fileName.toString(),
                                style: GoogleFonts.robotoCondensed(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Text(
                                previousYearList[index].description.toString(),
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
                                previousYearList[index].uniqueName.toString(),
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
