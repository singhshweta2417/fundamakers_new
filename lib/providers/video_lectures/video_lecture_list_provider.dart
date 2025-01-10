
// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/video_lecture/video_lecture_model.dart';
import 'package:fundamakers/view_model/user_view_model.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class VideoLectureProvider with ChangeNotifier {
  List<VideoLectureModel> _videoLectureList = [];

  List<VideoLectureModel> get videoLectureList => _videoLectureList;

  void setVideoLectureList(List<VideoLectureModel> videoLectureList) {
    _videoLectureList = videoLectureList;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<VideoLectureModel>> fetchVideoLectureListData() async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.videoLecturesUrls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<VideoLectureModel> videos = jsonData
            .map((jsonMap) => VideoLectureModel.fromJson(jsonMap))
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
