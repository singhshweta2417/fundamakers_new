import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/test/bottom_sheet_test_type.dart';
import 'package:fundamakers/view_model/test_type_details_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TestTypeMenu extends StatefulWidget {
  const TestTypeMenu({Key? key}) : super(key: key);

  @override
  State<TestTypeMenu> createState() => _TestTypeMenuState();
}

class _TestTypeMenuState extends State<TestTypeMenu> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coursesView =
          Provider.of<TestTypeViewModel>(context, listen: false);
      coursesView.testListApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Consumer<TestTypeViewModel>(builder: (context, value, _) {
        switch (value.testListResponse.success) {
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
            if (value.testListResponse.data != null &&
                value.testListResponse.data!.data != null &&
                value.testListResponse.data!.data!.isNotEmpty) {
              final testListView = value.testListResponse.data!.data!;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: testListView.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (bc) {
                            return TestDetailsScreen(testId:testListView[index].id.toString());
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: 20),
                        height: height * 0.15,
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
                              height: height * 0.09,
                              width: width * (width > 600 ? 0.2 : 0.3),
                              child: const Image(
                                image: AssetImage(Assets.imagesCommunity),
                              ),
                            ),
                            SizedBox(
                              width: width * (width > 600 ? 0.2 : 0.45),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testListView[index].name.toString(),
                                    style: GoogleFonts.robotoCondensed(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  textWidget(
                                      text:
                                          'Test Available: ${testListView[index].totalSections.toString()}',
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.twelve),
                                  textWidget(
                                      text:
                                          'Test taken: ${testListView[index].hasTimeLimit.toString()}',
                                      fontWeight: FontWeight.w300,
                                      fontSize: Dimensions.twelve),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (index == 0) {
                                  Navigator.pushNamed(
                                      context, RoutesName.subListMenu);
                                } else {
                                  Navigator.pushNamed(
                                      context, RoutesName.mainTestList);
                                }
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.25,
                    width: width,
                    alignment: Alignment.center,
                    child: const Image(image: AssetImage(Assets.imagesNoData)),
                  ),
                  textWidget(
                      text: 'No Data Available',
                      fontSize: Dimensions.eighteen,
                      color: AppColors.textButtonColor,
                      fontWeight: FontWeight.w500)
                ],
              );
            }
        }
      }),
    );
  }
}
