
// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/video_lecture/video_lecture_list_details_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class VideoLectureDetailsProvider with ChangeNotifier {
  List<VideoLectureDetailsModel> _videoLectureDetails = [];

  List<VideoLectureDetailsModel> get videoLectureDetails  => _videoLectureDetails;

  void setVideoLectureDetails(List<VideoLectureDetailsModel> videoLectureDetails ) {
    _videoLectureDetails = videoLectureDetails ;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<VideoLectureDetailsModel>> fetchVideoLectureDetailsData(String lectureId) async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.videoLecturesDetailsUrls+lectureId),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<VideoLectureDetailsModel> videos = jsonData
            .map((jsonMap) => VideoLectureDetailsModel.fromJson(jsonMap))
            .toList();

        return videos;

      } else {
        throw Exception(
            'Failed to load subjects data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw Exception(
          'Failed to fetch subjects data. Check your internet connection.');
    }
  }

}
