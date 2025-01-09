import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fundamakers/generated/assets.dart';
import 'package:fundamakers/main.dart';
import 'package:fundamakers/models/video_lecture/video_lecture_model.dart';
import 'package:fundamakers/providers/video_lectures/video_lecture_list_provider.dart';
import 'package:fundamakers/res/app_colors.dart';
import 'package:fundamakers/view/app/home/course/course_video.dart';

class MyCourseVideoList extends StatefulWidget {
  const MyCourseVideoList({Key? key}) : super(key: key);

  @override
  State<MyCourseVideoList> createState() => _MyCourseVideoListState();
}

class _MyCourseVideoListState extends State<MyCourseVideoList> {

  VideoLectureProvider videoLectureProvider = VideoLectureProvider();

  Future<void> allVideoListData() async {
    videos.clear();
    try {
      setState(() {
        isLoading = true;
      });
      List<VideoLectureModel> reviewsList = await videoLectureProvider.fetchVideoLectureListData();
      setState(() {
        videos = reviewsList;
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
  List<VideoLectureModel> videos = [];

  // Future<String> _getThumbnailUrl(String videoUrl) async {
  //   final response = await http.get(Uri.parse('https://vimeo.com/api/oembed.json?url=$videoUrl'));
  //   print('https://vimeo.com/api/oembed.json?url=$videoUrl');
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     return responseData['thumbnail_url'];
  //   } else {
  //     throw Exception('Failed to load thumbnail');
  //   }
  // }

  @override
  void initState() {
    allVideoListData();
    super.initState();
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
      body:
      isLoading && videos.isEmpty?const Center(
        child: CircularProgressIndicator(
          color: AppColors.themeGreenColor,
        ),
      ): videos.isEmpty
          ? const Center(
        child: Text("No Data Available",style: TextStyle(color: Colors.black),),
      ):
      ListView.builder(
        shrinkWrap: true,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
                height: height * 0.08,
                width: width * 0.28,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:videos[index].thumbnailUrl!=null? AssetImage(videos[index].thumbnailUrl.toString()):
                    const AssetImage(Assets.imagesSolution),
                    fit: BoxFit.cover,
                  ),
                ),
                child:const Icon(Icons.play_arrow,size: 30,color: Colors.green,)),
            title: Text(videos[index].videoTitle.toString()),
            subtitle:
            Text(videos[index].description.toString()),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CourseVideo(onlineID:videos[index].id,),));//thumbnailUrl:videos[index].thumbnailUrl
            },
          );
        },
      ),
    );
  }
}
