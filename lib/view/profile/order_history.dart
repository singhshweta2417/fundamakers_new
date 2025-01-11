import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  List<OrderHistoryModel> orderHistoryList = [
    OrderHistoryModel(
      title: 'Delivered by wed, 11 March 2023,7:00pm',
      subTitle: 'Arithmatic',
      image: Assets.imagesCommunity,
      screen: '₹2000',
    ),
    OrderHistoryModel(
      title: 'Delivered by wed, 11 March 2023,7:00pm',
      subTitle: 'Arithmatic',
      image: Assets.imagesCommunity,
      screen: '₹2000',
    ),
    OrderHistoryModel(
      title: 'Delivered by wed, 11 March 2023,7:00pm',
      subTitle: 'Arithmatic',
      image: Assets.imagesCommunity,
      screen: '₹2000',
    ),
  ];
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
            itemCount: orderHistoryList.length,
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
                        child: const Image(
                          image: AssetImage(Assets.imagesCommunity),
                        ),
                      ),
                      SizedBox(
                        width: containerWidth * (width > 600 ? 0.2 : 0.45),
                        height: containerHeight * 0.092,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderHistoryList[index].title,
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Text(
                              orderHistoryList[index].subTitle,
                              style: GoogleFonts.robotoCondensed(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
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
                                  itemSize: 23,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: const Icon(Icons.download,size: 20,),
                          ),
                          Text(
                            'Invoice',
                            style: GoogleFonts.robotoCondensed(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            orderHistoryList[index].screen,
                            style: GoogleFonts.robotoCondensed(
                              textStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
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

class OrderHistoryModel {
  final String title;
  final String subTitle;
  final String image;
  final String screen;
  OrderHistoryModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.screen,
  });
}
