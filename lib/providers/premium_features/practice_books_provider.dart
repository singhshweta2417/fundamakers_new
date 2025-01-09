// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/premium_features_model/practice_books_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class PracticeBookProvider with ChangeNotifier {
  List<PracticeBooksModel> _practiceBookList = [];

  List<PracticeBooksModel> get practiceBookList => _practiceBookList;

  void setPracticeBookList(List<PracticeBooksModel> courses) {
    _practiceBookList = courses;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<PracticeBooksModel>> fetchPracticeBookData() async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.practiceBooksUrls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<PracticeBooksModel> homeList = jsonData
            .map((jsonMap) => PracticeBooksModel.fromJson(jsonMap))
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

