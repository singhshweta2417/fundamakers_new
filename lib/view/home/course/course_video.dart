import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view_model/video_view_model.dart';
import 'package:provider/provider.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class CourseVideo extends StatefulWidget {
  final int? onlineID;

  const CourseVideo({Key? key, this.onlineID}) : super(key: key);

  @override
  State<CourseVideo> createState() => _CourseVideoState();
}

class _CourseVideoState extends State<CourseVideo> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args != null && args.containsKey('onlineID')) {
        final onlineID = args['onlineID'];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final videoView =
          Provider.of<VideoViewModel>(context, listen: false);
          videoView.videoLecturesDetailsApi(onlineID, context);
        });
      }
    });
  }


  String getVideoId(String videoUrl) {
    RegExp regExp = RegExp(r'vimeo\.com/(\d+)');
    Match? match = regExp.firstMatch(videoUrl);
    return match?.group(1) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
      body:
      Column(
        children: [
          ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    String videoUrl = 'https://vimeo.com/137925379';
                    String videoId = getVideoId(videoUrl);
                    return Container(
                      width: 150,
                      height: 200,
                      margin: EdgeInsets.only(
                        left: width * 0.05,
                        right: width * 0.05,
                        top: 20,
                      ),
                      child: VimeoPlayer(
                        videoId: videoId,
                      ),
                    );
                  },
                ),
          Container(
            height: height*0.25,
            width: width*0.9,
            decoration: BoxDecoration(
               color:AppColors.themeWhiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5,),
                const Text('"CAT 2023 Exam Analysis: Slot-wise Comparison,Percentiles and Marks Estimate"',style: TextStyle(color: AppColors.textButtonColor,fontWeight: FontWeight.w700,fontSize: 17),),
                 Padding(
                   padding: EdgeInsets.fromLTRB(width*0.6,15,0,8),
                   child: const Text('~ by Surya Sir',style: TextStyle(color: AppColors.textButtonColor,fontWeight: FontWeight.w900,fontSize: 17)),
                 ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      RatingBar.builder(
                        ignoreGestures: false,
                        initialRating: 5,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 27.0,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                      const Text('  2.7/5',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
             
              ],
            ),
          )
        ],
      ),
    );
  }
}
