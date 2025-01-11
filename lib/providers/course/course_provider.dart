// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:fundamakers/models/auth/auth_model.dart';
// import 'package:fundamakers/models/course/course_model.dart';
// import 'package:fundamakers/view_model/user_view_model.dart';
// import 'package:fundamakers/res/app_url.dart';
// import 'package:http/http.dart' as http;
//
// class CourseProvider with ChangeNotifier {
//   List<CourseModel> _courseList = [];
//
//   List<CourseModel> get courseList => _courseList;
//
//   void setCourseList(List<CourseModel> courses) {
//     _courseList = courses;
//     notifyListeners();
//   }
//
//   UserViewModel userViewModel = UserViewModel();
//   Future<List<CourseModel>> fetchCourseData() async {
//     AuthModel authModel = await userViewModel.getUser();
//     String userToken = authModel.token.toString();
//     try {
//       final response = await http.get(
//         Uri.parse(AppUrls.courseUrls),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $userToken',
//         },
//       );
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         final List<dynamic> jsonData = jsonResponse["data"];
//         List<CourseModel> homeList =
//             jsonData.map((jsonMap) => CourseModel.fromJson(jsonMap)).toList();
//         return homeList;
//       } else {
//         throw Exception(
//             'Failed to load subjects data. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//       throw Exception(
//           'Failed to fetch subjects data. Check your internet connection.');
//     }
//   }
// }
