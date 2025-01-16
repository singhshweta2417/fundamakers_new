import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MyCourseVideo extends StatefulWidget {
  const MyCourseVideo({Key? key}) : super(key: key);

  @override
  State<MyCourseVideo> createState() => _MyCourseVideoState();
}

class _MyCourseVideoState extends State<MyCourseVideo> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: const Icon(Icons.arrow_back_ios),),
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
      body: ListView(
        shrinkWrap: true,
        children: [
        Container(
        width: width,
        margin: EdgeInsets.only(
            left: width * 0.05, right: width * 0.05, top: 20),
        height:kIsWeb ?height*0.50: height * 0.25,
        decoration: BoxDecoration(
          color: AppColors.themeWhiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: YoutubePlayer(
            controller: YoutubePlayerController.fromVideoId(
              videoId: 'gCRNEJxDJKM',
              params: const YoutubePlayerParams(
                showControls: true,
                showFullscreenButton: true,
              ),
            ),
            aspectRatio: 16 / 9,
          ),
        ),
      ),
          SizedBox(height:height*0.02),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15,5,15,5),
              decoration: BoxDecoration(
                color:AppColors.themeWhiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.01,),
                  Container(
                      padding: EdgeInsets.only(left: width*0.05),
                      // color: Colors.blue,
                      child: const Text('The Complete Course of CAT in 1 hours',
                        style: TextStyle(color: AppColors.textButtonColor,fontWeight: FontWeight.w700,fontSize: 18),maxLines: 2,)),
                  SizedBox(height: height*0.02),
                  Row(
                      children: [
                        SizedBox(width: width*0.04,),
                        RatingBar.builder(
                          ignoreGestures: false,
                          initialRating:5,
                          // double.parse(editReviewItems!.rating.toString()),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25.0,
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
                        const Text('  (0.0)  0+ Rating',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)
                      ]),
                  SizedBox(height: height*0.01,),
                  Image(
                    image: const AssetImage(Assets.imagesArrowPng),
                    width: width * 0.9,
                    height: height*0.025,
                  ),
                  SizedBox(height: height*0.01,),
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,

                          height: height * 0.045,
                          width: width,
                          child: Row(
                            children: [
                              const Text(
                                '    ✔️',
                                style:
                                TextStyle(color: Colors.green),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  text: '  225+Topic Tests',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: AppColors
                                          .textButtonColor),
                                  children: [
                                    TextSpan(
                                        text:
                                        ' with video solutions',
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight.w400,
                                            color: AppColors
                                                .textButtonColor)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  SizedBox(height: height*0.01,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
