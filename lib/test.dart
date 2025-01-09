// import 'package:flutter/material.dart';
// import 'package:fundamakers/res/app_colors.dart';
//
// class YourWidget extends StatefulWidget {
//   const YourWidget({super.key});
//
//   @override
//   _YourWidgetState createState() => _YourWidgetState();
// }
//
// class _YourWidgetState extends State<YourWidget> {
//   bool _isExpanded = false; // Track the expansion state
//   bool _isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           setState(() {
//             _isExpanded = !_isExpanded;
//           });
//         },
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 300), // Add animation duration
//           height: _isExpanded ? height * 0.2 : height * 0.15, // Adjust height based on expansion state
//           width: width * 0.92,
//           child: _isExpanded
//               ? Container()
//               : Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Introduction',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 20,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.keyboard_arrow_down_rounded),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: height * 0.01,
//               ),
//               Row(
//                 children: [
//                   Container(
//                     alignment: Alignment.center,
//                     height: height * 0.04,
//                     width: width * 0.25,
//                     decoration: BoxDecoration(
//                       color: AppColors.textButtonColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       '00:24:30',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.themeWhiteColor,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: width * 0.02,
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     height: height * 0.04,
//                     width: width * 0.25,
//                     decoration: BoxDecoration(
//                       color: AppColors.themeGreenColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       '10 Lessons',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.themeWhiteColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
//   setPathUrlStrategy();
// }
// double height = 0.0;
// double width = 0.0;
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     width = kIsWeb ? 380 : MediaQuery.of(context).size.width;
//     return MultiProvider(
//       child:  Builder(
//         builder: (context) {
//           if (kIsWeb) {
//             print("aaa");
//             width = 380;
//             return MaterialApp(
//               builder: (context, child) {
//                 return Center(
//                   child: Container(
//                     constraints: const BoxConstraints(
//                       maxWidth: 380,
//                     ),
//                     child: child,
//                   ),
//                 );
//               },
//               title: AppConstants.appName,
//               debugShowCheckedModeBanner: false,
//               initialRoute: RoutesName.splashScreen,
//               color:const Color(0xffef3a38),
//               onGenerateRoute: (settings) {
//                 if (settings.name != null) {
//                   return MaterialPageRoute(
//                     builder: Routers.generateRoute(settings.name!),
//                     settings: settings,
//                   );
//                 }
//                 return null;
//               },
//             );
//           } else {
//             print("bbbb");
//             return   MaterialApp(
//               title: AppConstants.appName,
//               debugShowCheckedModeBanner: false,
//               initialRoute: RoutesName.splashScreen,
//               color:const Color(0xffef3a38),
//               onGenerateRoute: (settings) {
//                 if (settings.name != null) {
//                   return MaterialPageRoute(
//                     builder: Routers.generateRoute(settings.name!),
//                     settings: settings,
//                   );
//                 }
//                 return null;
//               },
//             );
//           }
//         },
//       ),
//
//       // MaterialApp(
//       //   title: AppConstants.appName,
//       //   debugShowCheckedModeBanner: false,
//       //   initialRoute: RoutesName.splashScreen,
//       //   onGenerateRoute: (settings) {
//       //     if (settings.name != null) {
//       //       return MaterialPageRoute(
//       //         builder: Routers.generateRoute(settings.name!),
//       //         settings: settings,
//       //       );
//       //     }
//       //     return null;
//       //   },
//       // ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, library_private_types_in_public_api
///
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fundamakers/generated/assets.dart';
// import 'package:fundamakers/main.dart';
// import 'package:fundamakers/models/video_lecture/video_lecture_model.dart';
// import 'package:fundamakers/providers/video_lectures/video_lecture_list_provider.dart';
// import 'package:fundamakers/res/app_colors.dart';
// import 'package:http/http.dart' as http;
//
// class VimeoVideoListScreen extends StatefulWidget {
//   const VimeoVideoListScreen({super.key});
//
//   @override
//   State<VimeoVideoListScreen> createState() => _VimeoVideoListScreenState();
// }
//
// class _VimeoVideoListScreenState extends State<VimeoVideoListScreen> {
//   VideoLectureProvider videoLectureProvider = VideoLectureProvider();
//
//   Future<void> allVideoListData() async {
//     videos.clear();
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       List<VideoLectureModel> reviewsList =
//           await videoLectureProvider.fetchVideoLectureListData();
//       setState(() {
//         videos = reviewsList;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       if (kDebugMode) {
//         print('Error fetching subjects data: $e');
//       }
//     }
//   }
//
//   bool isLoading = false;
//   List<VideoLectureModel> videos = [
//     // VimeoVideo(
//     //   title: 'Video 1',
//     //   description: 'Description for Video 1',
//     //   videoUrl: 'https://vimeo.com/356370511',
//     // ),
//     // VimeoVideo(
//     //   title: 'Video 2',
//     //   description: 'Description for Video 2',
//     //   videoUrl: 'https://vimeo.com/356370512',
//     // ),
//   ];
//   Future<String> _getThumbnailUrl(String videoUrl) async {
//     final response = await http
//         .get(Uri.parse('https://vimeo.com/api/oembed.json?url=$videoUrl'));
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       return responseData['thumbnail_url'];
//     } else {
//       throw Exception('Failed to load thumbnail');
//     }
//   }
//
//   @override
//   void initState() {
//     allVideoListData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         backgroundColor: AppColors.themeGreenColor,
//         title: SizedBox(
//           width: width * 0.4,
//           child: const Image(
//             image: AssetImage(Assets.logoFundamakers),
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       body: videos.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: videos.length,
//               itemBuilder: (context, index) {
//                 return FutureBuilder<String>(
//                   future: _getThumbnailUrl(videos[index].thumbnailUrl ?? ''),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center();
//                     } else if (snapshot.hasError) {
//                       return Text('Error: ${snapshot.error}');
//                     } else {
//                       return ListTile(
//                         leading: Container(
//                             height: height * 0.08,
//                             width: width * 0.28,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(snapshot.data ?? ''),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             child: IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.play_arrow,
//                                   size: 30,
//                                   color: Colors.green,
//                                 ))),
//                         title: Text(videos[index].videoTitle ?? ''),
//                         subtitle: Text(videos[index].description ?? ''),
//                         onTap: () {},
//                       );
//                     }
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }
// // ListView.builder(
// //   itemCount: videos.length,
// //   itemBuilder: (context, index) {
// //     return ListTile(
// //       leading: Container(
// //         height: height*0.07,
// //         width: width*0.2,
// //         color: Colors.blue,
// //       ),
// //       title: Text(videos[index].title ?? ''),
// //       subtitle: Text(videos[index].description ?? ''),
// //       onTap: () {
// // Navigator.push(
// //    context,
// //    MaterialPageRoute(
// //      builder: (context) => VimeoVideoPlayerScreen(videoUrl: videos[index].videoUrl),
// //    ),
// //  );
// //       },
// //     );
// //   },
// // ),
//
// class VimeoVideo {
//   String? title;
//   String? description;
//   String? videoUrl;
//
//   VimeoVideo({this.title, this.description, this.videoUrl});
//
// // // Method to extract Vimeo video ID from the URL
// //  String getVideoId() {
// //   RegExp regExp = RegExp(r'vimeo\.com/(\d+)');
// //   Match match = regExp.firstMatch(videoUrl)!;
// //   return match.group(1)!;
// // }
// }
// //
// // class VimeoVideoListItem extends StatelessWidget {
// //   final VimeoVideo video;
// //
// //   const VimeoVideoListItem({Key? key, required this.video}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       title: Text(video.title),
// //       subtitle: Text(video.description),
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => VimeoVideoPlayerScreen(videoUrl: video.videoUrl),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class VimeoVideoPlayerScreen extends StatelessWidget {
// //   final String videoUrl;
// //
// //   const VimeoVideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     String videoId = VimeoVideo(title: '', description: '', videoUrl: videoUrl).getVideoId();
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Vimeo Video Player'),
// //       ),
// //       body: Center(
// //         child: VimeoPlayer(videoId: videoId),
// //         //id: videoId, autoPlay: false, showControls: true
// //       ),
// //     );
// //   }
// // }
/// youtubeiframe
// import 'package:flutter/material.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
//
// class VideoPlayerScreen extends StatefulWidget {
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Video Player'),
//       ),
//       body:Container(
//         margin: EdgeInsets.all(20),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: YoutubePlayer(
//             controller: YoutubePlayerController.fromVideoId(
//               videoId: 'gCRNEJxDJKM',
//               params: const YoutubePlayerParams(
//                 showControls: true,
//                 showFullscreenButton: true,
//               ),
//             ),
//             aspectRatio: 16 / 9,
//           ),
//         ),
//       ),
//
//     );
//   }
// }
