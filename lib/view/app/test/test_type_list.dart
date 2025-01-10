import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/test/test_list_model.dart';
import 'package:fundamakers/providers/test/test_list_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/app/test/bottom_sheet_test_type.dart';
import 'package:fundamakers/view/app/test/main_test_list.dart';
import 'package:fundamakers/view/app/test/test_topic_menu.dart';
import 'package:google_fonts/google_fonts.dart';


class TestTypeMenu extends StatefulWidget {
  const TestTypeMenu({Key? key}) : super(key: key);

  @override
  State<TestTypeMenu> createState() => _TestTypeMenuState();
}

class _TestTypeMenuState extends State<TestTypeMenu> {
  TestListProvider testListProvider = TestListProvider();
  List<TestListModel> testList = [];
  bool isLoading = false;

  Future<void> allTestData() async {
    testList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<TestListModel> reviewsList =
          await testListProvider.fetchTestListData();
      setState(() {
        testList = reviewsList;
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
    allTestData();
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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double containerWidth = constraints.maxWidth;
          double containerHeight = constraints.maxHeight;
          return testList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.themeGreenColor,
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: testList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                         showModalBottomSheet(
                           context: context,
                           builder: (bc) {
                             return TestDetailsScreen(testList[index].id);
                           },
                         );
                       });
                      },
                      child: Container(
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
                              child: const Image(
                                image: AssetImage(Assets.imagesCommunity),
                              ),
                            ),
                            SizedBox(
                              width:
                                  containerWidth * (width > 600 ? 0.2 : 0.45),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testList[index].name.toString(),
                                    style: GoogleFonts.robotoCondensed(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Test Available: ${testList[index].totalSections.toString()}',
                                    style: GoogleFonts.robotoCondensed(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Test taken: ${testList[index].hasTimeLimit.toString()}',
                                    style: GoogleFonts.robotoCondensed(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SubListMenu(),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainTestList(),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            )
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
