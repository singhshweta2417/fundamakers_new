// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/subjects/subject_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class SubjectProvider with ChangeNotifier {
  List<SubjectModel> _subjectList = [];

  List<SubjectModel> get subjectList => _subjectList;

  void setCourseList(List<SubjectModel> subjects) {
    _subjectList = subjects;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<SubjectModel>> fetchSubjectData() async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.subjectsUrls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<SubjectModel> homeList = jsonData
            .map((jsonMap) => SubjectModel.fromJson(jsonMap))
            .toList();

        return homeList;

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

