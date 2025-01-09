// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fundamakers/models/auth/auth_model.dart';
import 'package:fundamakers/models/library/b_school_info_model.dart';
import 'package:fundamakers/providers/auth/userview_provider.dart';
import 'package:fundamakers/res/app_url.dart';
import 'package:http/http.dart' as http;

class BSchoolInfoProvider with ChangeNotifier {
  List<BSchoolInfoModel> _bSchoolInfoList = [];

  List<BSchoolInfoModel> get bSchoolInfoList => _bSchoolInfoList;

  void setClassHandoutsList(List<BSchoolInfoModel> bSchoolInfoList) {
    _bSchoolInfoList = bSchoolInfoList;
    notifyListeners();
  }
  UserViewModel userViewModel = UserViewModel();
  Future<List<BSchoolInfoModel>> fetchBSchoolInfoData() async {
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
        List<BSchoolInfoModel> gkZoneList = jsonData
            .map((jsonMap) => BSchoolInfoModel.fromJson(jsonMap))
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

