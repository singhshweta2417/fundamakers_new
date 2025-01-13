import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/video_lecture/video_lecture_model.dart';
import 'package:fundamakers/res/app_url.dart';

class VideoRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  ///VIDEO-LECTURE-LIST
  Future<VideoLectureModel> videoLecturesApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiBearerResponse(AppUrls.videoLecturesUrls);
      return VideoLectureModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during videoLecturesApi: $e');
      }
      rethrow;
    }
  }
  ///VIDEO-LECTURE-DETAILS-LIST
  Future<VideoLectureModel> videoLecturesDetailsApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiBearerResponse('${AppUrls.videoLecturesUrls}/$data');
      return VideoLectureModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during videoLecturesDetailsApi: $e');
      }
      rethrow;
    }
  }
}
