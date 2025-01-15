import 'package:flutter/foundation.dart';
import 'package:fundamakers/helper/response/api_response.dart';
import 'package:fundamakers/models/course/course_model.dart';
import 'package:fundamakers/models/course/sub_course_model.dart';
import 'package:fundamakers/repo/course_repo.dart';

class CoursesViewModel with ChangeNotifier {
  final _coursesRepo = CoursesRepository();
///COURSE
  ApiResponse<CourseModel> _coursesResponse = ApiResponse.loading();

  ApiResponse<CourseModel> get coursesResponse => _coursesResponse;

  void setCourseModel(ApiResponse<CourseModel> response) {
    if (_coursesResponse != response) {
      _coursesResponse = response;
      notifyListeners();
    }
  }

  clearCoursesModel() {
    _coursesResponse = ApiResponse.loading();
    notifyListeners();
  }

  Future<void> coursesApi(context) async {
    try {
      final value = await _coursesRepo.coursesApi();
      setCourseModel(ApiResponse.completed(value));
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
///SUB-COURSE
  SubCourseModel? _subCourseResponse;
  SubCourseModel? get subCourseResponse => _subCourseResponse;

  setSubCourseModel(SubCourseModel shweta) {
    _subCourseResponse = shweta;
    notifyListeners();
  }

  clearSubCoursesModel() {
    _subCourseResponse = null;
    notifyListeners();
  }

  Future<void> subCoursesApi(dynamic data,context) async {
    clearSubCoursesModel();
    try {
      final value = await _coursesRepo.subCourseApi(data);
      setSubCourseModel(value);
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching data: $error");
      }
    }
  }
}
