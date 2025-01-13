import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view/test/bottom_sheet_test_type.dart';
import 'package:fundamakers/view_model/test_type_details_view_model.dart';
import 'package:provider/provider.dart';

class TestTypeListScreen extends StatefulWidget {
  const TestTypeListScreen({Key? key}) : super(key: key);

  @override
  State<TestTypeListScreen> createState() => _TestTypeListScreenState();
}

class _TestTypeListScreenState extends State<TestTypeListScreen> {
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
            return circularProgressIndicator();
          case Success.ERROR:
            return noDataAvailable();
          case Success.COMPLETED:
            if (value.testListResponse.data != null &&
                value.testListResponse.data!.data != null &&
                value.testListResponse.data!.data!.isNotEmpty) {
              final testListView = value.testListResponse.data!.data!;
              return ListView.builder(
                  padding: EdgeInsets.only(top: height * 0.03),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: testListView.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          if (testListView[index].id == 12) {
                            Navigator.pushNamed(
                                context, RoutesName.subListMenu);
                          } else {
                            Navigator.pushNamed(
                                context, RoutesName.mainTestList);
                          }
                        },
                        child: listContainer(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: height * 0.07,
                              child: const Image(
                                image: AssetImage(Assets.imagesCommunity),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: testListView[index].name.toString(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimensions.thirteen),
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
                            const Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (bc) {
                                        return TestDetailsScreen(
                                            testId: testListView[index]
                                                .id
                                                .toString());
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: AppColors.gradientFirstColor,
                                    size: 20,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                                SizedBox(height: height * 0.05)
                              ],
                            )
                          ],
                        )));
                  });
            } else {
              return noDataAvailable();
            }
        }
      }),
    );
  }
}
