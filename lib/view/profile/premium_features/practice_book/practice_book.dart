import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/models/premium_features_model/practice_books_model.dart';
import 'package:fundamakers/providers/premium_features/practice_books_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PracticeBookScreen extends StatefulWidget {
  const PracticeBookScreen({Key? key}) : super(key: key);

  @override
  State<PracticeBookScreen> createState() => _PracticeBookScreenState();
}

class _PracticeBookScreenState extends State<PracticeBookScreen> {

  PracticeBookProvider practiceBookProvider = PracticeBookProvider();
  List<PracticeBooksModel> practiceBookList = [];

  Future<void> allPracticeBookData() async {
    practiceBookList.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<PracticeBooksModel> reviewsList = await practiceBookProvider.fetchPracticeBookData();
      setState(() {
        practiceBookList = reviewsList;
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
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    allPracticeBookData();
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
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: practiceBookList.length,
            itemBuilder: (context, index) {
              return InkWell(
                // onTap: (){
                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const CourseVideo()));
                // },
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
                        child: const Image(image:AssetImage(Assets.imagesCommunity)),
                      ),
                      SizedBox(
                        width: containerWidth * (width > 600 ? 0.2 : 0.45),
                        height: containerHeight * 0.09,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              practiceBookList[index].name.toString(),
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Text(
                              practiceBookList[index].fileName.toString(),
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: false,
                                  initialRating: 5,
                                  // double.parse(editReviewItems!.rating.toString()),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 23.0,
                                  itemBuilder: (context, _) => const Icon(
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

class PracticeBookModel {
  final String title;
  final String subTitle;
  final String image;
  final String screen;
  PracticeBookModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.screen,
  });
}
