import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/models/test/main_test_list_model.dart';
import 'package:fundamakers/providers/test/main_test_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/test/online_test.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTestList extends StatefulWidget {
  const MainTestList({Key? key}) : super(key: key);

  @override
  State<MainTestList> createState() => _MainTestListState();
}

class _MainTestListState extends State<MainTestList> {



  MainTestListProvider mainTestListProvider = MainTestListProvider();
  List<MainTestListModel> testMainList = [];
  bool isLoading = false;

  Future<void> allMainTestData() async {
    testMainList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<MainTestListModel> reviewsList = await mainTestListProvider.fetchMainTestListData();
      setState(() {
        testMainList = reviewsList;
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
    allMainTestData();
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
        builder: (BuildContext context, BoxConstraints constraints) {
          double containerWidth = constraints.maxWidth;
          double containerHeight = constraints.maxHeight;
          return testMainList.isEmpty?const Center(
            child: CircularProgressIndicator(
              color: AppColors.themeGreenColor,
            ),
          ):
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: testMainList.length,
            itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnlineTest(),
                    ),
                  );
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
                        child: const Image(image:  AssetImage(Assets.imagesCommunity),),
                      ),
                      SizedBox(
                        width: containerWidth * (width > 600 ? 0.2 : 0.45),
                        height: containerHeight * 0.09,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              testMainList[index].name.toString(),
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Text(
                              testMainList[index].description.toString(),
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              testMainList[index].hasWindowTimeLimit.toString(),
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
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

