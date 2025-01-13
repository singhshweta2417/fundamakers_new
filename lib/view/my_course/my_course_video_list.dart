import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/helper/response/status.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/res/custom_widgets.dart';
import 'package:fundamakers/res/text_widget.dart';
import 'package:fundamakers/utils/routes/routes_name.dart';
import 'package:fundamakers/view_model/video_view_model.dart';
import 'package:provider/provider.dart';

class MyCourseVideoList extends StatefulWidget {
  const MyCourseVideoList({Key? key}) : super(key: key);

  @override
  State<MyCourseVideoList> createState() => _MyCourseVideoListState();
}

class _MyCourseVideoListState extends State<MyCourseVideoList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final videoView = Provider.of<VideoViewModel>(context, listen: false);
      videoView.videoLecturesApi(context);
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
        body: Consumer<VideoViewModel>(builder: (context, value, _) {
          switch (value.videoLectureResponse.success) {
            case Success.LOADING:
              return circularProgressIndicator();
            case Success.ERROR:
              return noDataAvailable();
            case Success.COMPLETED:
              if (value.videoLectureResponse.data != null &&
                  value.videoLectureResponse.data!.data != null &&
                  value.videoLectureResponse.data!.data!.isNotEmpty) {
                final videos = value.videoLectureResponse.data!.data!;
                return ListView.builder(
                  padding: EdgeInsets.only(top: height * 0.03),
                  shrinkWrap: true,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return listContainer(
                        child: ListTile(
                      leading: Container(
                          height: height * 0.1,
                          width: width * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all( color: Colors.black.withOpacity(0.2),),
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: videos[index].thumbnailUrl != null
                                  ? AssetImage(
                                      videos[index].thumbnailUrl.toString())
                                  : const AssetImage(Assets.imagesSolution),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 30,
                            color: Colors.green,
                          )),
                      title: textWidget(
                          text: videos[index].videoTitle.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.fifteen),
                      subtitle: textWidget(
                          text: videos[index].description.toString(),
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.thirteen,
                          maxLines: 2),
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.courseVideo,arguments: {'onlineID':videos[index].id});
                        //thumbnailUrl:videos[index].thumbnailUrl
                      },
                    ));
                  },
                );
              } else {
                return noDataAvailable();
              }
          }
        }));
  }
}
