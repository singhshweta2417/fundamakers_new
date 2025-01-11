import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/network/base_api_services.dart';
import 'package:fundamakers/helper/network/network_api.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/models/course/sub_course_model.dart';
import 'package:fundamakers/res/app_url.dart';

class CoursesRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  ///COURSE
  Future<CourseModel> coursesApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiBearerResponse(AppUrls.courseUrls);
      return CourseModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during coursesApi: $e');
      }
      rethrow;
    }
  }
///SUB-COURSE
  Future<SubCourseModel> subCourseApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getGetApiBearerResponse('${AppUrls.subCourseUrls}course_id=$data');
      return SubCourseModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during subCourseApi: $e');
      }
      rethrow;
    }
  }
}
