// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/test/main_test_list_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class MainTestListProvider with ChangeNotifier {
  List<MainTestListModel> _testList = [];

  List<MainTestListModel> get testList => _testList;

  void setCourseList(List<MainTestListModel> testLists) {
    _testList = testLists;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<MainTestListModel>> fetchMainTestListData() async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.testsUrls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<MainTestListModel> testMainList = jsonData
            .map((jsonMap) => MainTestListModel.fromJson(jsonMap))
            .toList();

        return testMainList;

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

