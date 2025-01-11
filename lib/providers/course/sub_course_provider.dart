//
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:fundamakers/models/auth/auth_model.dart';
// import 'package:fundamakers/models/course/sub_course_model.dart';
// import 'package:fundamakers/view_model/user_view_model.dart';
// import 'package:fundamakers/res/app_url.dart';
// import 'package:http/http.dart' as http;
//
// class SubCourseProvider with ChangeNotifier {
//   List<SubCourseModel> _subCourseList = [];
//
//   List<SubCourseModel> get subCourseList => _subCourseList;
//
//   void setTopicList(List<SubCourseModel> subCourse) {
//     _subCourseList = subCourse;
//     notifyListeners();
//   }
//   UserViewModel userViewModel = UserViewModel();
//   Future<List<SubCourseModel>> fetchSubCourseData(courseId) async {
//     AuthModel authModel = await userViewModel.getUser();
//     String userToken = authModel.token.toString();
//     try {
//       final response = await http.get(
//         Uri.parse('${AppUrls.subCourseUrls}course_id=$courseId'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $userToken',
//         },
//       );
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final List<dynamic> jsonData = jsonResponse["data"];
//         List<SubCourseModel> subCourseList = jsonData
//             .map((jsonMap) => SubCourseModel.fromJson(jsonMap))
//             .toList();
//         // for (var courseData in data) {
//         //   final List<dynamic> subCoursesData = courseData["sub_courses"];
//         //   subCourseList.addAll(subCoursesData.map((subCourseData) => SubCourseModel.fromJson(subCourseData)));
//         // }
//         return subCourseList;
//       } else {
//         throw Exception('Failed to load subjects data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//       throw Exception('Failed to fetch subjects data. Check your internet connection.');
//     }
//   }
//
// }
