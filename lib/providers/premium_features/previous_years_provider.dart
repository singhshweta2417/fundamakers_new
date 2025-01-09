// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/library/previous_years_papers_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class PreviousYearProvider with ChangeNotifier {
  List<PreviousYearModel> _previousYearList = [];

  List<PreviousYearModel> get previousYearList => _previousYearList;

  void setClassHandoutsList(List<PreviousYearModel> previousYearList) {
    _previousYearList = previousYearList;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<PreviousYearModel>> fetchPreviousYearData() async {
    AuthModel authModel = await userViewModel.getUser();
    String userToken = authModel.token.toString();
    try {
      final response = await http.get(
        Uri.parse(AppUrls.bSchoolInfoUrls),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $userToken',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> jsonData = jsonResponse["data"];
        List<PreviousYearModel> gkZoneList = jsonData
            .map((jsonMap) => PreviousYearModel.fromJson(jsonMap))
            .toList();
        return gkZoneList;
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

