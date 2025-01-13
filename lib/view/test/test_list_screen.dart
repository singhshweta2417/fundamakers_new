import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/test_type_details_view_model.dart';
import 'package:provider/provider.dart';

class TestListScreen extends StatefulWidget {
  const TestListScreen({Key? key}) : super(key: key);

  @override
  State<TestListScreen> createState() => _TestListScreenState();
}

class _TestListScreenState extends State<TestListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final testView = Provider.of<TestTypeViewModel>(context, listen: false);
      testView.testApi(context);
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Consumer<TestTypeViewModel>(builder: (context, value, _) {
          switch (value.testResponse.success) {
            case Success.LOADING:
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
            case Success.COMPLETED:
              if (value.testResponse.data != null &&
                  value.testResponse.data!.data != null &&
                  value.testResponse.data!.data!.isNotEmpty) {
                final testMainList = value.testResponse.data!.data!;
                return ListView.builder(
                  padding: EdgeInsets.only(top: height * 0.03),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: testMainList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.onlineTest);
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
                            SizedBox(
                              width: width * 0.45,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textWidget(
                                      text: testMainList[index].name.toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimensions.thirteen),
                                  textWidget(
                                      text: testMainList[index]
                                          .description
                                          .toString(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: Dimensions.twelve),
                                  textWidget(
                                      text: testMainList[index]
                                          .hasWindowTimeLimit
                                          .toString(),
                                      fontWeight: FontWeight.w300,
                                      fontSize: Dimensions.twelve),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        )));
                  },
                );
              } else {
                return noDataAvailable();
              }
          }
        }));
  }
}
