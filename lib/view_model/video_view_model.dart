import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/video_lecture/video_lecture_model.dart';
import 'package:fundamakers/repo/video_repo.dart';

class VideoViewModel with ChangeNotifier {
  final _videoRepo = VideoRepository();

  ///VIDEO-LECTURE-LIST
  ApiResponse<VideoLectureModel> _videoLectureResponse = ApiResponse.loading();

  ApiResponse<VideoLectureModel> get videoLectureResponse =>
      _videoLectureResponse;

  void setVideoLectureModel(ApiResponse<VideoLectureModel> response) {
    if (_videoLectureResponse != response) {
      _videoLectureResponse = response;
      notifyListeners();
    }
  }

  Future<void> videoLecturesApi(context) async {
    setVideoLectureModel(ApiResponse.loading());
    try {
      final value = await _videoRepo.videoLecturesApi();
      setVideoLectureModel(ApiResponse.completed(value));
    } catch (error) {
      setVideoLectureModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }


  Future<void> videoLecturesDetailsApi(dynamic data,context) async {
    setVideoLectureModel(ApiResponse.loading());
    try {
      final value = await _videoRepo.videoLecturesDetailsApi(data);
      setVideoLectureModel(ApiResponse.completed(value));
    } catch (error) {
      setVideoLectureModel(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
